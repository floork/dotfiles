#!/usr/bin/env lua

-- Define the power menu options
local options = {
	"Shutdown",
	"Reboot",
	"Suspend",
	"Lock",
	"Logout",
}

-- Define the Rofi command
local rofi_cmd = "wofi --show dmenu -i -p 'Power Menu: '"

local function check_wofi_open()
	os.execute("pgrep -x wofi >/dev/null 2>&1 && killall wofi || false")
end

-- Function to display the power menu and execute the selected action
local function show_power_menu()
	local menu_items = table.concat(options, "\n")
	local cmd = string.format("echo -e '%s' | %s", menu_items, rofi_cmd)
	local selected_option = io.popen(cmd):read("*line")

	if selected_option == "Shutdown" then
		os.execute("shutdown now")
	elseif selected_option == "Reboot" then
		os.execute("shutdown -r now")
	elseif selected_option == "Suspend" then
		os.execute("systemctl suspend")
	elseif selected_option == "Lock" then
		os.execute("swaylock --color 444444 ")
	elseif selected_option == "Logout" then
		os.execute("hyprctl dispatch exit")
	end
end

-- Call the function to display the power menu
if not check_wofi_open() then
	show_power_menu()
end
