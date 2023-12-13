return {
  -- awesome colorscheme
  {
    "folke/tokyonight.nvim",
  },

  -- nice cpp scheme
  { "lunacookies/vim-colors-xcode" },

  -- nice overall scheme
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- all time favorite
  {
    "loctvl842/monokai-pro.nvim",
  },

  -- github like theme
  {
    "projekt0n/github-nvim-theme",
  },

  -- nostalgic scheme
  { "lunarvim/synthwave84.nvim" },
}
