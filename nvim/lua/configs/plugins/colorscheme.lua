return {
  -- nice cpp scheme
  { "lunacookies/vim-colors-xcode" },

  -- nice overall scheme
  {
    "morhetz/gruvbox",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- all time favorite
  { "loctvl842/monokai-pro.nvim" },

  -- nostalgic scheme
  { "lunarvim/synthwave84.nvim" },
}
