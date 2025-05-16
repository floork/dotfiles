local retro_classic = {}

retro_classic.name = "Retro Classic"

retro_classic.colors = {
  foreground = "#e5d27a",
  background = "#2b2b2b",
  cursor_bg = "#ffffff",
  cursor_fg = "#000000",
  cursor_border = "#ffffff",
  selection_fg = "#f8f8f2",
  selection_bg = "#44475a",
  scrollbar_thumb = "#4e4e4e",
  split = "#3a3a3a",

  ansi = {
    "#1c1c1c", -- black
    "#d72638", -- red
    "#3fb950", -- green
    "#f19d1a", -- yellow (terminal calls this yellow)
    "#1e90ff", -- blue
    "#a960d2", -- magenta
    "#39c5cf", -- cyan
    "#d3d3d3", -- white (silver)
  },

  brights = {
    "#4e4e4e", -- bright black (gray)
    "#ff6e6e", -- bright red
    "#5ffb83", -- bright green
    "#ffd966", -- bright yellow
    "#87bfff", -- bright blue
    "#d68fff", -- bright magenta
    "#73efff", -- bright cyan
    "#ffffff", -- bright white
  },

  tab_bar = {
    background = "#252525",
    active_tab = {
      bg_color = "#2b2b2b",
      fg_color = "#ffd966",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#252525",
      fg_color = "#d3d3d3",
    },
    inactive_tab_hover = {
      bg_color = "#333333",
      fg_color = "#e5d27a",
      italic = true,
    },
    new_tab = {
      bg_color = "#252525",
      fg_color = "#3fb950",
    },
    new_tab_hover = {
      bg_color = "#333333",
      fg_color = "#1e90ff",
    },
  },
}

return retro_classic
