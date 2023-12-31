local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- keymap
local keymap = vim.keymap
keymap.set("n", "<leader>ll", ":Lazy<CR>", { noremap = true, silent = true })

require("lazy").setup(
  {
    {
      import = "configs.plugins",
    },
    {
      import = "configs.plugins.lsp",
    },
    {
      import = "configs.plugins.git",
    },
  },
  {
    install = {
      colorscheme = { "rose-pine-main" },
    },
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      notify = false,
    },
  }
)
