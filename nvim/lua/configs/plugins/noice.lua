return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup()

    -- keymap
    local keymap = vim.keymap

    keymap.set("n", "<leader>nt", "<cmd>NoiceTelescope<CR>", { desc = "Show history" })
    keymap.set("n", "<leader>ns", "<cmd>NoiceStats<CR>", { desc = "Show stats" })
    keymap.set("n", "<leader>nl", "<cmd>NoiceLog<CR>", { desc = "Show logs" })
  end,
}
