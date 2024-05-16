#!/bin/env lua

-- NOTE: not used anymore but keeping it for reference
function GetDistro()
  local nixos = io.open("/etc/NIXOS", "r")
  if nixos then
    return "nixos"
  end
  local arch = io.open("/etc/arch-release", "r")
  if arch then
    return "arch"
  end

  local distro_name = io.popen("lsb_release -si"):read("*a"):gsub("\n", "")
  return distro_name:lower()
end

-- NOTE: not used anymore but keeping it for reference
function IsThinkpad()
  local product_name = io.popen("cat /sys/devices/virtual/dmi/id/product_name"):read("*a"):gsub("\n", "")
  return product_name:lower():find("thinkpad")
end

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

function Wayland_per_os(config, host, enable)
  if GetDistro() == host then
    config.enable_wayland = enable
  end
end
