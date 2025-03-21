#!/usr/bin/env lua

-- Define the power menu options
local options = {
  "Shutdown",
  "Reboot",
  "Suspend",
  "Lock",
  "Logout",
}

-- Determine the appropriate command based on the APP_LAUNCHER environment variable
local app_launcher = os.getenv("APP_LAUNCHER") or "walker"
local rofi_cmd

if app_launcher == "wofi" then
  rofi_cmd = "wofi --show dmenu -i -p 'Power Menu: '"
elseif app_launcher == "fuzzel" then
  rofi_cmd = "fuzzel --dmenu -p 'Power Menu: '"
elseif app_launcher == "walker" then
  rofi_cmd = "walker --dmenu -p 'Power Menu: '"
else
  print("Unsupported app launcher: " .. app_launcher)
  os.exit(1)
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
    os.execute("hyprlock")
  elseif selected_option == "Logout" then
    os.execute("hyprctl dispatch exit")
  end
end

-- Function to check if the app launcher is open
local function check_launcher_open()
  return os.execute("pgrep -x " .. app_launcher .. " >/dev/null 2>&1") == 0
end

-- Call the function to check if the launcher is open
if not check_launcher_open() then
  show_power_menu()
end
