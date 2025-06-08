const std = @import("std");
const common = @import("common.zig");

const progs = [_][]const []const u8{
    &[_][]const u8{"waybar"},
    &[_][]const u8{"mako"},
    &[_][]const u8{"pypr"},
    &[_][]const u8{ "wl-paste", "--watch", "cliphist", "store" },
    &[_][]const u8{"nm-applet"},
    &[_][]const u8{"legcord"},
    &[_][]const u8{"thunderbird"},
};

pub fn run(alloc: std.mem.Allocator) !void {
    for (progs) |prog| {
        var cmd = common.Command{ .allocator = alloc };

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
