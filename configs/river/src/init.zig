const std = @import("std");
const common = @import("common.zig");

const progs = [_][]const []const u8{
    &[_][]const u8{ "systemctl", "--user", "import-environment", "WAYLAND_DISPLAY" },
    &[_][]const u8{ "systemctl", "--user", "restart", "xdg-desktop-portal-wlr.service" },
    &[_][]const u8{ "systemctl", "--user", "restart", "xdg-desktop-portal.service" },
    &[_][]const u8{"way-displays"},
};

pub fn run(alloc: std.mem.Allocator) !void {
    for (progs) |prog| {
        var cmd = common.Command{ .allocator = alloc };
        defer cmd.deinit();

        var prog_str = std.ArrayList(u8).init(alloc);
        defer prog_str.deinit();

        for (prog, 0..) |arg, i| {
            if (i > 0) try prog_str.append(' ');
            try prog_str.appendSlice(arg);
        }

        var prog_cmd = std.ArrayList([]const u8).init(alloc);
        defer prog_cmd.deinit();

        try prog_cmd.append("riverctl");
        try prog_cmd.append("spawn");
        try prog_cmd.append(prog_str.items);

        try cmd.run(prog_cmd.items);
    }
}
