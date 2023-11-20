return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("git-worktree").setup({})

    require("telescope").load_extension("git_worktree")
    -- keymap
    local keymap = vim.keymap
    keymap.set(
      "n",
      "<leader>gw",
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      { desc = "Open git worktree" }
    )
    keymap.set(
      "n",
      "<leader>gm",
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      { desc = "Create git worktree" }
    )
  end,
}
