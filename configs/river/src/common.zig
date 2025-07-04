const std = @import("std");

pub const Command = struct {
    allocator: std.mem.Allocator,
    stdout: ?[]u8 = null,
    exit_code: ?std.process.Child.Term = null,

    fn joinArgs(args: []const []const u8, alloc: std.mem.Allocator) ![]u8 {
        var list = std.ArrayList(u8).init(alloc);
        defer if (list.capacity != 0) list.deinit();

        for (args, 0..) |arg, i| {
            if (i != 0) try list.append(' ');
            try list.appendSlice(arg);
        }
        return list.toOwnedSlice();
    }

    fn log(self: *Command, message: []const u8, command: []const []const u8, exit_code: ?std.process.Child.Term) void {
        var alloc = self.allocator;
        const cmd_str = joinArgs(command, alloc) catch "<join error>";

        if (exit_code) |code| {
            switch (code) {
                .Exited => |exit_val| {
                    if (exit_val != 0) {
                        std.log.warn("{s} \"{s}\", exit_code: {}", .{ message, cmd_str, exit_val });
                    } else {
                        std.log.info("{s} \"{s}\", exit_code: {}", .{ message, cmd_str, exit_val });
                    }
                },
                else => {
                    std.log.err("{s} \"{s}\", terminated abnormally: {}", .{ message, cmd_str, code });
                },
            }
            alloc.free(cmd_str);
            return;
        }

        std.log.info("{s} \"{s}\"", .{ message, cmd_str });
        alloc.free(cmd_str);
    }

    pub fn run(self: *Command, command: []const []const u8) !void {
        self.log("Starting", command, null);
        var child = std.process.Child.init(command, self.allocator);
        child.stdout_behavior = .Pipe;
        child.stderr_behavior = .Inherit;

        try child.spawn();

        const stdout = try child.stdout.?.reader().readAllAlloc(self.allocator, 1024);
        const exit_status = try child.wait();

        self.stdout = stdout;
        self.exit_code = exit_status;
        self.log("Finished", command, exit_status);
    }

    pub fn run_unsafe(self: *Command, cmd: []const u8) !void {
        try self.run(&[_][]const u8{ "sh", "-c", cmd });
    }

    pub fn deinit(self: *Command) void {
        if (self.stdout) |buf| {
            self.allocator.free(buf);
        }
    }
};

pub fn check_available(alloc: std.mem.Allocator, to_check: []const u8) !bool {
    var cmd = Command{ .allocator = alloc };
    defer cmd.deinit();

    const shell_command_str = try std.fmt.allocPrint(alloc, "command -v {s}", .{to_check});
    defer alloc.free(shell_command_str);

    try cmd.run(&[_][]const u8{ "/bin/sh", "-c", shell_command_str });

    if (cmd.exit_code) |code| {
        switch (code) {
            .Exited => |val| {
                return val == 0;
            },
            else => {
                std.log.warn("Shell command for '{s}' exited with non-zero code: {any}", .{ to_check, code });
                return false;
            },
        }
    }

    return false; // Assume not available if no exit code
}

pub fn check_running(alloc: std.mem.Allocator, to_check: []const u8) !bool {
    var cmd = Command{ .allocator = alloc };
    defer cmd.deinit();
    try cmd.run(&[_][]const u8{ "pgrep", "-x", to_check });

    if (cmd.exit_code) |code| {
        switch (code) {
            .Exited => |val| {
                return val == 0;
            },
            else => return false,
        }
    }

    return true;
}
