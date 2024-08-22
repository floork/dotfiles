#!/usr/bin/env lua

-- Function to execute a command and return the output
function execute_command(command)
  local file = io.popen(command)
  local output = file:read("*a")
  file:close()
  return output
end

-- Get the app launcher from the environment variable or default to "wofi"
local app_launcher = os.getenv("APP_LAUNCHER") or "wofi"

-- Determine the command to use based on the app launcher
local launcher_cmd
if app_launcher == "wofi" then
  launcher_cmd = "wofi --show dmenu -i -p 'Select Window: '"
elseif app_launcher == "fuzzel" then
  launcher_cmd = "fuzzel --dmenu -p 'Select Window: '"
else
  print("Unsupported app launcher: " .. app_launcher)
  os.exit(1)
end

-- Get the list of window classes
local command = "hyprctl clients | grep 'class: ' | awk '{gsub(\"class: \", \"\");print}'"
local window_classes = execute_command(command)

if window_classes == "" then
  print("No windows found.")
  os.exit(1)
end

-- Clean up window classes and store them in a table
local window_options = {}
for window in window_classes:gmatch("[^\n]+") do
  local cleaned_window = window:gsub("[^%g ]", "")
  if cleaned_window ~= "" then
    table.insert(window_options, cleaned_window)
  end
end

if #window_options == 0 then
  print("No windows with text found.")
  os.exit(1)
end

-- Concatenate window options and display the menu using the selected launcher
local selected_window = execute_command(
  'echo "' .. table.concat(window_options, "\n") .. '" | ' .. launcher_cmd
)

-- Exit if no window is selected
if selected_window == "" then
  os.exit(1)
end

-- Focus the selected window
execute_command("hyprctl dispatch focuswindow " .. selected_window)
