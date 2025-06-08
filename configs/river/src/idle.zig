const std = @import("std");
const common = @import("common.zig");

pub fn run(alloc: std.mem.Allocator) !void {
    const lock_time = "300";
    const dpms_time = "350";
    const lock_command_str = "swaylock -f -c 000000";
    const dpms_off_command_str = "wlopm --off '*'";
    const dpms_on_command_str = "wlopm --on '*'";

    // a big enough stack buffer
    var buf: [256]u8 = undefined;

    const fmt =
        \\swayidle -w \\
        \\    timeout {s} {s} \\
        \\    timeout {s} {s} \\
        \\    resume {s} \\
        \\    before-sleep {s}
    ;

    const fmt_buf = try std.fmt.bufPrint(
        &buf,
        fmt,
        .{
            lock_time,
            lock_command_str,
            dpms_time,
            dpms_off_command_str,
            dpms_on_command_str,
            lock_command_str,
        },
    );

    const args = [_][]const u8{
        "riverctl",
        "spawn",
        fmt_buf,
    };

    var cmd = common.Command{ .allocator = alloc };
    defer cmd.deinit();
    try cmd.run(&args);
}
