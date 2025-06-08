const std = @import("std");
const common = @import("common.zig");

const opts = [_][]const []const u8{
    &[_][]const u8{ "riverctl", "spawn", "rivercarro -inner-gaps 6 -outer-gaps 6" },
    &[_][]const u8{ "riverctl", "keyboard-layout", "-options", "caps:swapescape", "us" },
    &[_][]const u8{ "riverctl", "input", "pointer-1739-0-Synaptics_TM3289-021", "natural-scroll", "enabled" },
    &[_][]const u8{ "riverctl", "default-layout", "rivercarro" },
    &[_][]const u8{ "riverctl", "focus-follows-cursor", "normal" },
    &[_][]const u8{ "riverctl", "border-width", "2" },
    &[_][]const u8{ "riverctl", "border-color-focused", "0xFFFFFF" },
    &[_][]const u8{ "riverctl", "border-color-unfocused", "0x333333" },
};

pub fn run(alloc: std.mem.Allocator) !void {
    for (opts) |opt| {
        var cmd = common.Command{ .allocator = alloc };
        defer cmd.deinit();
        try cmd.run(opt);
    }
}
