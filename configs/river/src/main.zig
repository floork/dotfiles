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
    comptime fmt_str: []const u8,
    args: anytype,
) void {
    // Let Zig's default logger keep doing its job
    std.log.defaultLog(level, scope, fmt_str, args);

    if (log_file) |*f| {
        var w = f.writer();
        w.print("[{s}] ", .{level.asText()}) catch |e|
            std.debug.panic("log write failed: {}", .{e});
        w.print(fmt_str, args) catch |e|
            std.debug.panic("log write failed: {}", .{e});
        w.print("\n", .{}) catch |e|
            std.debug.panic("log write failed: {}", .{e});
    }

    switch (level) {
        .warn, .err => {
            const msg = std.fmt.allocPrint(
                issues_arena.allocator(),
                fmt_str,
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

    try cmd.run(&.{ "notify-send", urgency, "Started with", body });
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const log_path = blk: {
        const home = try std.process.getEnvVarOwned(alloc, "HOME");
        defer alloc.free(home);
        break :blk try std.fmt.allocPrint(alloc, "{s}/.river.log", .{home});
    };
    defer alloc.free(log_path);

    var maybe_file: ?std.fs.File =
        std.fs.cwd().createFile(log_path, .{ .truncate = true }) catch null;
    log_file = maybe_file;

    if (maybe_file) |*f| {
        defer f.close();
    }
    defer issues_arena.deinit();

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
