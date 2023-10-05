return {
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        -- ... your config
      })
      -- lua
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },
  -- {
  --   "lunarvim/synthwave84.nvim",
  --   priority = 1000,
  --   config = function ()
  --     vim.cmd([[colorscheme synthwave84]])
  --   end
  -- }
  -- -- {
  --   "bluz71/vim-nightfly-guicolors",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme nightfly]])
  --   end,
  -- },
}
