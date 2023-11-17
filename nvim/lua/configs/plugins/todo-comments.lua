return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    require("todo-comments").setup()
    -- keymap
    local keymap = vim.keymap

    local possible_comment_types = "FIX|TODO|HACK|WARN|PERF|NOTE|TEST"
    keymap.set("n", "<leader>;;", "<cmd>TodoTelescope<cr>", { desc = possible_comment_types })
    keymap.set("n", "<leader>;f", "<cmd>TodoTelescope keywords=FIX<cr>", { desc = "Fix" })
    keymap.set("n", "<leader>;t", "<cmd>TodoTelescope keywords=TODO<cr>", { desc = "Todo" })
    keymap.set("n", "<leader>;h", "<cmd>TodoTelescope keywords=HACK<cr>", { desc = "Hack" })
    keymap.set("n", "<leader>;w", "<cmd>TodoTelescope keywords=WARN<cr>", { desc = "Warn" })
    keymap.set("n", "<leader>;p", "<cmd>TodoTelescope keywords=PERF<cr>", { desc = "Perf" })
    keymap.set("n", "<leader>;n", "<cmd>TodoTelescope keywords=NOTE<cr>", { desc = "Note" })
    keymap.set("n", "<leader>;l", "<cmd>TodoTelescope keywords=TEST<cr>", { desc = "Test" })
  end,
}
