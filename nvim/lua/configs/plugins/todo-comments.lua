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
    keymap.set("n", "<leader>;;", "<cmd>:TodoTelescope<cr>", { desc = possible_comment_types })
  end,
}
