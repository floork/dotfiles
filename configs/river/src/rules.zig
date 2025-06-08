const std = @import("std");
const common = @import("common.zig");

pub fn run(alloc: std.mem.Allocator) !void {
    // Define workspace variables
    const workspace1 = "1";
    const workspace2 = "2";
    const workspace3 = "4";
    const workspace4 = "8";
    const workspace5 = "16";
    const workspace6 = "32";
    // const workspace7 = "64";
    // const workspace8 = "128";
    // const workspace9 = "256";

    // List of commands to run
    const commands = [_][]const []const u8{
        // General window rules
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "popup", "float" },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "xwaylandvideobridge", "float" },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "kruler", "float" },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "org.kde.kruler", "float" },
        // &[_][]const u8{ "riverctl", "rule-add", "-app-id", "Gromit-mpx", "float" },
        // &[_][]const u8{ "riverctl", "rule-add", "-app-id", "Gromit-mpx", "stick" },

        // Tag 1: Terminals
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "com.mitchellh.ghostty", "tags", workspace1 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "wezterm", "tags", workspace1 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "alacritty", "tags", workspace1 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "warp-terminal", "tags", workspace1 },

        // Tag 2: Browsers
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "brave-browser", "tags", workspace2 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "firefox", "tags", workspace2 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "zen", "tags", workspace2 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "zen-browser", "tags", workspace2 },

        // Tag 3: Mail
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "thunderbird", "tags", workspace3 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "betterbird", "tags", workspace3 },

        // Tag 4: Music
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "spotify", "tags", workspace4 },

        // Tag 5: Chat/Comms
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "discord", "tags", workspace5 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "legcord", "tags", workspace5 },
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "element", "tags", workspace5 },

        // Tag 6: Notes
        &[_][]const u8{ "riverctl", "rule-add", "-app-id", "obsidian", "tags", workspace6 },
    };

    // Run all commands
    var cmd = common.Command{ .allocator = alloc };
    defer cmd.deinit();

    for (commands) |command| {
        try cmd.run(command);
    }
}
