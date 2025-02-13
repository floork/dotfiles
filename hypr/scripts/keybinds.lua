#!/usr/bin/env lua

-- Function to get the selected keybinding
local function get_selected(config)
  local selected = nil
  local menu_cmd = nil

  -- Determine which launcher to use based on APP_LAUNCHER or installed command
  local app_launcher = os.getenv("APP_LAUNCHER")

  if app_launcher == "wofi" then
    menu_cmd = "wofi --show dmenu -i -p 'Hyprland Keybinds: '"
  elseif app_launcher == "fuzzel" then
    menu_cmd = "fuzzel --dmenu -p 'Hyprland Keybinds: '"
  elseif os.execute("command -v wofi > /dev/null") then
    menu_cmd = "wofi --show dmenu -i -p 'Hyprland Keybinds: '"
  elseif os.execute("command -v rofi > /dev/null") then
    menu_cmd = "rofi -dmenu -i -markup-rows -p 'Hyprland Keybinds: '"
  else
    print("Neither wofi, fuzzel, nor rofi are installed or set.")
    os.exit(1)
  end

  -- Extract the keybindings from the Hyprland config file
  local binds = {}
  for line in io.lines(config) do
    if line:match("^bind") then
      line = line:gsub("%s+", " ")
          :gsub("bind[dlmn]* = ", "")
          :gsub(", ", ",")
          :gsub(" # ", ",")
      local parts = {}
      for part in line:gmatch("([^,]+)") do
        table.insert(parts, part)
      end
      local cmd = ""
      for i = 5, #parts do
        cmd = cmd .. parts[i] .. " "
      end
      cmd = cmd:gsub("&", "&amp;")
      local bind_str = ""
      if (not parts[1]:match("^bind")) then
        bind_str = parts[1] .. " + " .. parts[2] .. ", " .. parts[3]
      else
        bind_str = parts[2] .. " " .. parts[3]
      end
      table.insert(binds, bind_str)
    end
  end

  -- Display the menu using the selected launcher
  local menu_input = table.concat(binds, "\n")
  local menu_cmd_str = "echo '" .. menu_input .. "' | " .. menu_cmd

  local handle = io.popen(menu_cmd_str)
  if (handle == nil) then
    print("Failed to open menu.")
    os.exit(1)
  end

  selected = handle:read("*a")
  handle:close()

  return selected
end

-- Function to handle keybindings
local function keybindings()
  local config_file = os.getenv("HOME") .. "/.config/hypr/hyprland.conf"
  local selected = get_selected(config_file)

  if not selected or selected == "" then
    print("No selection made.")
    os.exit(1)
  end

  -- Extract the command from the selection
  local cmd = selected:match("<span color='gray'>(.*)</span>") or selected

  -- Execute the command
  if cmd then
    if cmd:match("^exec") then
      os.execute(cmd)
    else
      os.execute("hyprctl dispatch " .. cmd)
    end
  end
end

keybindings()
