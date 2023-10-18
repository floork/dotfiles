return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- keymap
    local keymap = vim.keymap

    keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")
    keymap.set("n", "<leader>gf", "<cmd>LazyGitFilter<cr>")
    keymap.set("n", "<leader>gc", "<cmd>LazyGitConfig<cr>")
  end,
}
