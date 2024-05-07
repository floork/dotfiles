local wezterm = require("wezterm")
require("functions")
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
config.color_scheme = "Chameleon (Gogh)"
config.harfbuzz_features = { "calt=0" }  -- disable ligatures
config.warn_about_missing_glyphs = false -- disable warning about missing glyphs

-- Configuring the window
config.window_background_opacity = 0.9

config.scrollback_lines = 10000

config.enable_wayland = true

config.keys = {
  {
    key = "w",
    mods = "SUPER",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
