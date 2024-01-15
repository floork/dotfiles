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

-- config.color_scheme = "Codeschool (base16)"
config.color_scheme = "Chameleon (Gogh)"
config.harfbuzz_features = { "calt=0" } -- disable ligatures
config.window_background_opacity = 0.9

config.scrollback_lines = 10000


if GetDistro() == "nixos" then
  config.enable_wayland = false
  if IsThinkpad() then
    local action = wezterm.action
    config.keys = {
      {
        key = "CapsLock",
        action = action.SendKey({ key = "Escape" }),
      },
      {
        key = "Escape",
        action = action.SendKey({ key = "CapsLock" }),
      },
    }
    config.key_map_preference = "Mapped"
  end
end

return config
