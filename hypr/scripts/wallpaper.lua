#!/usr/bin/env lua

--- Kills a targeted process if it is running.
-- @param process The process to be killed.
local function kill_process(process)
	if os.execute(string.format('pgrep -x "%s" >/dev/null', process)) then
		os.execute(string.format('pkill %s', process))
	end
end

--- Kills the random wallpaper script if it is running.
local function kill_random_wallpaper()
	local handle = io.popen("pgrep -f hypr/scripts/random_wallpaper.sh")
	if handle then
		local pid = handle:read("*n")
		handle:close()
		if pid then
			os.execute("kill " .. pid)
		end
	end
end

--- Applies a wallpaper by copying it to a specified directory and setting it as the wallpaper.
-- @param wallpaper The path to the wallpaper image file.
-- @param wallpapers_dir The directory where wallpapers are stored.
local function apply_wallpaper(wallpaper, wallpapers_dir)
	kill_process("swaybg") -- Kill any existing swaybg process
	kill_random_wallpaper() -- Kill the random wallpaper script

	-- Copy the selected wallpaper to a directory and set it as the wallpaper
	os.execute(string.format('cp "%s" "%s/current.png"', wallpaper, wallpapers_dir))
	os.execute(string.format('swaybg -i "%s" -m fill &', wallpaper))
end

--- Displays a menu of wallpapers and applies the selected wallpaper.
local function show_wallpaper_menu()
	local rofi_cmd = "wofi --show dmenu -i -p 'Select a wallpaper: '"

	local wallpapers_dir = os.getenv("HOME") .. "/.config/wallpapers"
	local command = string.format("fd . --full-path %s -e png", wallpapers_dir)

	-- Execute the command to list wallpapers
	local handle = io.popen(command)
	if not handle then
		print("Error: Unable to list wallpapers.")
		return
	end

	local wallpapers = {}
	-- Read the output of the command line by line
	for line in handle:lines() do
		table.insert(wallpapers, line)
	end
	handle:close()

	local options = table.concat(wallpapers, "\n")

	-- Display the wallpaper menu using wofi
	local cmd = string.format("echo -e '%s' | %s", options, rofi_cmd)
	local selected_option = io.popen(cmd):read("*line")

	-- Apply the selected wallpaper
	if selected_option then
		apply_wallpaper(selected_option, wallpapers_dir)
	else
		print("No wallpaper selected.")
	end
end

--- Checks if the wofi menu is open.
-- @return boolean True if wofi is open, false otherwise.
local function check_wofi_open()
	return os.execute("pgrep -x wofi >/dev/null") == 0
end

-- Call the function to check if wofi is open
if not check_wofi_open() then
	show_wallpaper_menu()
end
