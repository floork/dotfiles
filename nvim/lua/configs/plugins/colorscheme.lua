local function set_colorscheme(name)
  vim.cmd("colorscheme " .. name)
end

return {
  {
    "rose-pine/neovim",
    config = function()
      set_colorscheme("rose-pine-main")
    end,
  },
  { "folke/tokyonight.nvim" },
  { "lunacookies/vim-colors-xcode" },
  { "morhetz/gruvbox" },
  { "loctvl842/monokai-pro.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "lunarvim/synthwave84.nvim" },
}
