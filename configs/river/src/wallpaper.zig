const std = @import("std");
const common = @import("common.zig");

const WallpaperError = error{NoWallpapersFound};

pub fn getFilesInDir(
    allocator: std.mem.Allocator,
    dir_path: []const u8,
) !std.ArrayList([]const u8) {
    var file_list = std.ArrayList([]const u8).init(allocator);

    var dir = try std.fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();

    var it = dir.iterate();
    while (try it.next()) |entry| {
        if (entry.kind == .file) {
            const full_path = try std.fs.path.join(allocator, &[_][]const u8{ dir_path, entry.name });
            try file_list.append(full_path);
        }
    }

    return file_list;
}

fn get_random_wallpaper(alloc: std.mem.Allocator) ![]const u8 {
    const wallpaper_dir = "/home/floork/dotfiles/configs/live-wallpapers/";
    var files = try getFilesInDir(alloc, wallpaper_dir);
    defer files.deinit();

    if (files.items.len == 0) {
        return WallpaperError.NoWallpapersFound;
    }

    var random_u64_bytes: [8]u8 = undefined;
    std.crypto.random.bytes(&random_u64_bytes);
    const random_value = std.mem.readInt(u64, &random_u64_bytes, .little);

    const random_index = random_value % files.items.len;
    const selected_wallpaper = files.items[random_index];

    return try alloc.dupe(u8, selected_wallpaper);
}

pub fn run(alloc: std.mem.Allocator) !void {
    if (!(try common.check_available(alloc, "swww"))) {
        std.log.warn("swww is not available", .{});
        return;
    }

    if (!(try common.check_running(alloc, "swww-daemon"))) {
        std.log.warn("swww-daemon is not running", .{});
        var swwW_daemon_cmd = common.Command{ .allocator = alloc };
        defer swwW_daemon_cmd.deinit();
        std.log.info("Starting swww-daemon", .{});

        try swwW_daemon_cmd.run_unsafe("swww-daemon > /dev/null 2>&1 &");

        std.time.sleep(100 * std.time.ns_per_ms);
    }
    std.log.info("swww-daemon check passed.", .{});

    std.log.info("Getting random wallpaper...", .{});
    const wallpaper = try get_random_wallpaper(alloc);
    var buf: [256]u8 = undefined;
    const selected = try std.fmt.bufPrint(&buf, "Selected wallpaper: {s}", .{wallpaper});
    std.log.info("{s}", .{selected});

    var swww = common.Command{ .allocator = alloc };
    defer swww.deinit();
    const swww_img_shell_cmd_str = try std.fmt.allocPrint(alloc, "swww img \"{s}\" &", .{wallpaper});
    defer alloc.free(swww_img_shell_cmd_str);
    try swww.run_unsafe(swww_img_shell_cmd_str);

    std.log.info("Wallpaper executed", .{});
}
