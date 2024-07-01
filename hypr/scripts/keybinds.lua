#!/usr/bin/env lua

-- Function to get the selected keybinding
local function get_selected(config)
  local selected = nil
  local menu_cmd = nil

  -- Check if wofi or rofi is installed
  if os.execute("command -v wofi > /dev/null") then
    menu_cmd = "wofi"
  elseif os.execute("command -v rofi > /dev/null") then
    menu_cmd = "rofi"
  else
    print("wofi or rofi not installed")
    os.exit(1)
  end

  -- Extract the keybinding from the Hyprland config file
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
      print(parts[1])
      table.insert(binds, bind_str)
    end
  end

  -- Display the menu using wofi or rofi
  local menu_input = table.concat(binds, "\n")
  local menu_cmd_str = ""
  if menu_cmd == "wofi" then
    menu_cmd_str = "echo '" .. menu_input .. "' | wofi --show dmenu -i -p 'Hyprland Keybinds:'"
  else
    menu_cmd_str = "echo '" .. menu_input .. "' | rofi -dmenu -i -markup-rows -p 'Hyprland Keybinds:'"
  end

  local handle = io.popen(menu_cmd_str)
  if (handle == nil) then
    print("handle is nil")
    os.exit()
  end

  selected = handle:read("*a")
  handle:close()

  return selected
end

-- Function to handle keybindings
local function keybindings()
  local config_file = os.getenv("HOME") .. "/.config/hypr/hyprland.conf"
  local selected = get_selected(config_file)

  -- Extract cmd from span <span color='gray'>cmd</span>
  local cmd = selected:match("<span color='gray'>(.*)</span>")

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
