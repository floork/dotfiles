#!/bin/env lua

--- Determines the Linux distribution.
-- @return string The name of the Linux distribution in lowercase.
local function GetDistro()
  local nixos = io.open("/etc/NIXOS", "r")
  if nixos then
    nixos:close()
    return "nixos"
  end
  local arch = io.open("/etc/arch-release", "r")
  if arch then
    arch:close()
    return "arch"
  end

  local distro_name = io.popen("lsb_release -si"):read("*a"):gsub("\n", "")
  return distro_name:lower()
end

--- Checks if the machine is a ThinkPad.
-- @return boolean True if the machine is a ThinkPad, false otherwise.
local function IsThinkpad()
  local product_name = io.popen("cat /sys/devices/virtual/dmi/id/product_name"):read("*a"):gsub("\n", "")
  return product_name:lower():find("thinkpad") ~= nil
end

--- Returns a table with white background settings.
-- @return table A table containing white background settings.
function WhiteBG()
  return {
    window_background_gradient = {
      orientation = "Vertical",
      colors = { "#FFFFFF" },
      interpolation = "Linear",
      blend = "Rgb",
    },
    color_scheme = 'Catppuccin Latte'
  }
end

--- Configures Wayland settings per operating system.
-- @param config table The configuration table to modify.
-- @param host string The target host operating system name.
-- @param enable boolean Whether to enable Wayland or not.
function Wayland_per_os(config, host, enable)
  if host == "*" or host == "all" then
    config.enable_wayland = enable
  end

  if GetDistro() == host then
    config.enable_wayland = enable
  end
end
