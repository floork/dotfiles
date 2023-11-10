return {
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    -- keymap
    local keymap = vim.keymap
    keymap.set("n", "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Toggle zen mode" })
  end,
}
