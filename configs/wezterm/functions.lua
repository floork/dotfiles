#!/bin/env lua

local white_mode = false

function Toggle_white_mode(window, pane)
  white_mode = not white_mode

  if white_mode then
    window:set_config_overrides({
      color_scheme = "Builtin Light", -- or any light scheme you prefer
      window_background_opacity = 1.0,
    })
  else
    window:set_config_overrides({
      color_scheme = nil,
      window_background_opacity = nil,
    })
  end
end
