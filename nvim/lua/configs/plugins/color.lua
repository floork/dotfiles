local function set_colorscheme(name)
  vim.cmd("colorscheme " .. name)
end

function ColorMyPencil(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        disable_background = true,
      })
      set_colorscheme("rose-pine-main")
      ColorMyPencil()
    end,
  },
  { "folke/tokyonight.nvim" },
  { "loctvl842/monokai-pro.nvim" },
}
