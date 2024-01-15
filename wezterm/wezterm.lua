local wezterm = require("wezterm")

local function whiteBG()
  return {
    orientation = "Vertical",
    colors = { "#FFFFFF" },
    interpolation = "Linear",
    blend = "Rgb",
  }
end

local config = {}

-- Use config builder if possible
if wezterm.config_builder then
  config = wezterm.config_builder({})
end

-- Configuring the font
config.font = wezterm.font_with_fallback({
  { family = "FiraCode Nerd Font" },
  { family = "Fira Code" },
})

-- config.color_scheme = "Codeschool (base16)"
config.color_scheme = "Chameleon (Gogh)"
config.harfbuzz_features = { "calt=0" } -- disable ligatures
config.window_background_opacity = 0.9

config.scrollback_lines = 10000

local function getDistro()
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

if getDistro() == "nixos" then
  config.enable_wayland = false
end

return config
