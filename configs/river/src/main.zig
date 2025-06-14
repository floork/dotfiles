const std = @import("std");
const autostart = @import("autostart.zig");
const common = @import("common.zig");
const config = @import("config.zig");
const idle = @import("idle.zig");
const init = @import("init.zig");
const keybinds = @import("keybinds.zig");
const rules = @import("rules.zig");
const wallpaper = @import("wallpaper.zig");

const Issue = struct {
    level: std.log.Level,
    message: []u8,
};

var issues_arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
var runtime_issues =
    std.ArrayList(Issue).init(std.heap.page_allocator);

var log_file: ?std.fs.File = null;

pub fn customLogFn(
    comptime level: std.log.Level,
    comptime scope: @Type(.enum_literal),
    comptime message: []const u8,
    args: anytype,
) void {
    // Let Zig's default logger keep doing its job
    std.log.defaultLog(level, scope, message, args);

    if (log_file) |file| {
        var writer = file.writer();
        writer.print("[{s}] ", .{level.asText()}) catch {};
        writer.print(message, args) catch {};
        writer.print("\n", .{}) catch {};
    }

    switch (level) {
        .warn, .err => {
            const msg = std.fmt.allocPrint(
                issues_arena.allocator(),
                message,
                args,
            ) catch unreachable;
            runtime_issues.append(.{ .level = level, .message = msg }) catch unreachable;
        },
        else => {},
    }
}

pub const std_options: std.Options = .{
    .logFn = customLogFn,
};

fn issueNotify(alloc: std.mem.Allocator) !void {
    var warn_count: u16 = 0;
    var err_count: u16 = 0;

    for (runtime_issues.items) |iss| switch (iss.level) {
        .warn => warn_count += 1,
        .err => err_count += 1,
        else => {},
    };

    const urgency = if (err_count > 0) "critical" else "normal";

    var cmd = common.Command{ .allocator = alloc };
    defer cmd.deinit();

    var buf: [64]u8 = undefined;
    const body = try std.fmt.bufPrint(
        &buf,
        "{d} warnings and {d} errors",
        .{ warn_count, err_count },
    );

    if (!try common.check_available(alloc, "notify-send")) {
        return;
    }

    try cmd.run(&.{ "notify-send", "--urgency", urgency, "RIVER: Started with", body });
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const home = std.process.getEnvVarOwned(alloc, "HOME") catch |e| {
        std.log.err("Failed to get $HOME: {}", .{e});
        return e;
    };
    defer alloc.free(home);

    const path_buf = try std.fmt.allocPrint(alloc, "{s}/.river.log", .{home});
    defer alloc.free(path_buf);

    const file = try std.fs.cwd().createFile(
        path_buf,
        .{ .truncate = true },
    );
    log_file = file;
    defer file.close();

    try init.run(alloc);
    try config.run(alloc);
    try autostart.run(alloc);
    try idle.run(alloc);
    try keybinds.run(alloc);
    try rules.run(alloc);
    try wallpaper.run(alloc);

    if (runtime_issues.items.len > 0) {
        try issueNotify(alloc);
    }
}
