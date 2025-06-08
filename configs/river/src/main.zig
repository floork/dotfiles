const std = @import("std");
const autostart = @import("autostart.zig");
const config = @import("config.zig");
const idle = @import("idle.zig");
const init = @import("init.zig");
const keybinds = @import("keybinds.zig");
const rules = @import("rules.zig");
const wallpaper = @import("wallpaper.zig");

var log_file: ?std.fs.File = null;

pub fn customLogFn(
    comptime level: std.log.Level,
    comptime scope: @Type(.enum_literal),
    comptime message: []const u8,
    args: anytype,
) void {
    std.log.defaultLog(level, scope, message, args);

    if (log_file) |file| {
        var writer = file.writer();
        writer.print("[{s}] ", .{level.asText()}) catch {};
        writer.print(message, args) catch {};
        writer.print("\n", .{}) catch {};
    }
}

pub const std_options: std.Options = .{
    .logFn = customLogFn,
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const home = try std.process.getEnvVarOwned(allocator, "HOME");
    defer allocator.free(home);

    // Build the path: $HOME/foo.log
    const path_buf = try std.fmt.allocPrint(allocator, "{s}/.river.log", .{home});
    defer allocator.free(path_buf);

    // Open the log file for writing (truncate)
    const file = try std.fs.cwd().createFile(
        path_buf,
        .{ .truncate = true },
    );
    log_file = file;
    defer file.close();

    try init.run(allocator);
    try config.run(allocator);
    try autostart.run(allocator);
    try idle.run(allocator);
    try keybinds.run(allocator);
    try rules.run(allocator);
    try wallpaper.run(allocator);
}
