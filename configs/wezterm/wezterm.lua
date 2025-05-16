local wezterm = require("wezterm")
local funcs = require("functions")
local config = {}

-- Use config builder if possible
if wezterm.config_builder then
  config = wezterm.config_builder({})
end

local retro_classic = require("color")

if retro_classic == nil then
  print("Retro Classic colorscheme not found.")
  return
end

config.color_schemes = {
  [retro_classic.name] = retro_classic.colors,
}
config.color_scheme = retro_classic.name

-- Configuring the font
config.font = wezterm.font_with_fallback({
  { family = "FiraCode Nerd Font" },
  { family = "Fira Code" },
})

-- config.color_scheme = 'Atelier Cave Light (base16)' -- light theme
-- config.harfbuzz_features = { "calt=0" }  -- disable ligatures
config.warn_about_missing_glyphs = false -- disable warning about missing glyphs

-- Configuring the window
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

config.enable_wayland = true

config.disable_default_key_bindings = true
config.keys = {
  {
    key = "D",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowDebugOverlay,
  },
  {
    key = "V",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
  {
    key = "C",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  {
    key = "+",
    mods = "CTRL|SHIFT",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "-",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "=",
    mods = "CTRL",
    action = wezterm.action.ResetFontSize,
  },
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      _G.toggle_white_mode(window, pane)
    end),
  },
}

return config
