const std = @import("std");
const common = @import("common.zig");

const Keybind = struct {
    mode: []const u8,
    bind: []const u8,
    event: []const u8,

    pub fn create(self: Keybind, alloc: std.mem.Allocator) !void {
        var cmd = common.Command{ .allocator = alloc };
        defer cmd.deinit();

        const full_cmd = try std.fmt.allocPrint(alloc, "riverctl map {s} {s} {s}", .{ self.mode, self.bind, self.event });
        defer alloc.free(full_cmd);

        try cmd.run_unsafe(full_cmd);
    }
};

fn get_launcher(allocator: std.mem.Allocator) !?[]const u8 {
    const envvar = std.process.getEnvVarOwned(allocator, "APP_LAUNCHER") catch |err| {
        if (err == error.EnvironmentVariableNotFound) {
            return null;
        }
        return err;
    };

    return envvar;
}

pub fn run(alloc: std.mem.Allocator) !void {
    const main_mod = "Super";
    const alt_key = "Mod1";

    const app_launcher = try get_launcher(alloc);
    defer if (app_launcher) |ptr| alloc.free(ptr);

    const launcher = app_launcher orelse "walker";

    var buffer: [64]u8 = undefined;
    const dmenu = try std.fmt.bufPrint(&buffer, "{s}-d", .{launcher});

    var spawn_launcher_buf: [64]u8 = undefined;
    const spawn_launcher = try std.fmt.bufPrint(&spawn_launcher_buf, "spawn {s}", .{launcher});

    var spawn_clip_buf: [128]u8 = undefined;
    const spawn_clip = try std.fmt.bufPrint(
        &spawn_clip_buf,
        "spawn \"bash -c 'cliphist list | {s} | cliphist decode | wl-copy'\"",
        .{dmenu},
    );

    const keybinds = [_]Keybind{
        // Basic window management
        .{ .mode = "normal", .bind = main_mod ++ " Q", .event = "close" },
        .{ .mode = "normal", .bind = main_mod ++ " F", .event = "toggle-fullscreen" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift F", .event = "toggle-float" },
        // Focus movement
        .{ .mode = "normal", .bind = main_mod ++ " H", .event = "focus-view left" },
        .{ .mode = "normal", .bind = main_mod ++ " L", .event = "focus-view right" },
        .{ .mode = "normal", .bind = main_mod ++ " K", .event = "focus-view up" },
        .{ .mode = "normal", .bind = main_mod ++ " J", .event = "focus-view down" },
        // Window swapping
        .{ .mode = "normal", .bind = main_mod ++ "+Shift H", .event = "swap left " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift L", .event = "swap right" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift K", .event = "swap up   " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift J", .event = "swap down " },
        // Layout control
        .{ .mode = "normal", .bind = main_mod ++ "+Control H", .event = "send-layout-cmd rivercarro 'set-main-size -0.05'" },
        .{ .mode = "normal", .bind = main_mod ++ "+Control L", .event = "send-layout-cmd rivercarro 'set-main-size +0.05'" },
        .{ .mode = "normal", .bind = main_mod ++ "+Control K", .event = "send-layout-cmd rivercarro 'focus-cycle next'   " },
        .{ .mode = "normal", .bind = main_mod ++ "+Control J", .event = "send-layout-cmd rivercarro 'focus-cycle prev'   " },
        // Application Launchers
        .{ .mode = "normal", .bind = main_mod ++ " X", .event = "spawn 'ghostty'" },
        .{ .mode = "normal", .bind = main_mod ++ " Space", .event = spawn_launcher },
        .{ .mode = "normal", .bind = main_mod ++ " E", .event = "spawn 'thunar'" },
        .{ .mode = "normal", .bind = main_mod ++ " N", .event = "spawn 'obsidian'" },
        .{ .mode = "normal", .bind = main_mod ++ " V", .event = spawn_clip },
        .{ .mode = "normal", .bind = main_mod ++ " M", .event = "spawn 'thunderbird'" },
        .{ .mode = "normal", .bind = main_mod ++ " S", .event = "spawn spotify" },
        // Media and Communication:
        .{ .mode = "normal", .bind = main_mod ++ " A", .event = "spawn 'pavucontrol'" },
        .{ .mode = "normal", .bind = main_mod ++ " B", .event = "spawn 'zen'" },
        .{ .mode = "normal", .bind = main_mod ++ " D", .event = "spawn 'legcord'" },
        .{ .mode = "normal", .bind = main_mod ++ " O", .event = "spawn 'bash ~/.local/bin/bemoji'" },
        .{ .mode = "normal", .bind = main_mod ++ " R", .event = "spawn 'kruler'" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift B", .event = "spawn 'blueman-manager'" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift E", .event = "spawn 'element-desktop'" },
        // System and Utility:
        .{ .mode = "normal", .bind = main_mod ++ " P", .event = "spawn '$HOME/.local/bin/powermenu' " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift S", .event = "spawn '$HOME/.local/bin/screenshot'" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift R", .event = "spawn 'pkill waybar && waybar &'   " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift K", .event = "spawn '$HOME/.local/bin/killProc'  " },
        // Lock:
        .{ .mode = "normal", .bind = main_mod ++ "+Shift I", .event = "spawn 'swaylock -f -c 000000'" },
        // # Pyprpaper (Assuming pypr is available)
        .{ .mode = "normal", .bind = main_mod ++ " Z", .event = "spawn 'pypr zoom ++0.5' " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift Z", .event = "spawn 'pypr zoom'" },
        .{ .mode = "normal", .bind = main_mod ++ "+" ++ alt_key ++ " M", .event = "spawn 'pypr toggle_dpms'" },
        // Media controls (using keysym names)
        .{ .mode = "normal", .bind = "None" ++ " XF86AudioPlay", .event = "spawn 'playerctl play-pause'" },
        .{ .mode = "normal", .bind = "None" ++ " XF86AudioPrev", .event = "spawn 'playerctl previous'" },
        .{ .mode = "normal", .bind = "None" ++ " XF86AudioNext", .event = "spawn 'playerctl next'" },
        .{ .mode = "normal", .bind = "None" ++ " XF86AudioMute", .event = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'" },
        .{ .mode = "-repeat normal", .bind = "None" ++ " XF86AudioRaiseVolume", .event = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+'" },
        .{ .mode = "-repeat normal", .bind = "None" ++ " XF86AudioLowerVolume", .event = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-'" },
        .{ .mode = "-repeat normal", .bind = "None" ++ " XF86MonBrightnessUp", .event = "spawn 'brightnessctl set +1%'" },
        .{ .mode = "-repeat normal", .bind = "None" ++ " XF86MonBrightnessDown", .event = "spawn 'brightnessctl set 1%-'" },
        // Switch workspaces (tags in River)
        .{ .mode = "normal", .bind = main_mod ++ " 1", .event = "set-focused-tags 1  " },
        .{ .mode = "normal", .bind = main_mod ++ " 2", .event = "set-focused-tags 2  " },
        .{ .mode = "normal", .bind = main_mod ++ " 3", .event = "set-focused-tags 4  " },
        .{ .mode = "normal", .bind = main_mod ++ " 4", .event = "set-focused-tags 8  " },
        .{ .mode = "normal", .bind = main_mod ++ " 5", .event = "set-focused-tags 16 " },
        .{ .mode = "normal", .bind = main_mod ++ " 6", .event = "set-focused-tags 32 " },
        .{ .mode = "normal", .bind = main_mod ++ " 7", .event = "set-focused-tags 64 " },
        .{ .mode = "normal", .bind = main_mod ++ " 8", .event = "set-focused-tags 128" },
        .{ .mode = "normal", .bind = main_mod ++ " 9", .event = "set-focused-tags 256" },
        .{ .mode = "normal", .bind = main_mod ++ " 0", .event = "set-focused-tags 512" },
        // Move active window to a workspace (tag)
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 1", .event = "set-view-tags 1  " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 2", .event = "set-view-tags 2  " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 3", .event = "set-view-tags 4  " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 4", .event = "set-view-tags 8  " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 5", .event = "set-view-tags 16 " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 6", .event = "set-view-tags 32 " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 7", .event = "set-view-tags 64 " },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 8", .event = "set-view-tags 128" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 9", .event = "set-view-tags 256" },
        .{ .mode = "normal", .bind = main_mod ++ "+Shift 0", .event = "set-view-tags 512" },
    };

    for (keybinds) |bind| {
        bind.create(alloc) catch |err| {
            std.log.err("Failed to create keybind: {}", .{err});
        };
    }
}
