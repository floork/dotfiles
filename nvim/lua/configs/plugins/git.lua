return {
  {
    "f-person/git-blame.nvim",
    config = function()
      local gb = require("gitblame")

      -- setup
      gb.setup({
        enabled = false,
        relative_time = true,
      })

      -- keymap
      local keymap = vim.keymap
      keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle git blame" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
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
      keymap.set("n", "<leader>gw", "<cmd>Telescope git_worktree git_worktrees<cr>", { desc = "Open git worktree" })
      keymap.set(
        "n",
        "<leader>gm",
        "<cmd>Telescope git_worktree create_git_worktree<cr>",
        { desc = "Create git worktree" }
      )
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      local keymap = vim.keymap

      keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
      keymap.set("n", "<leader>gp", function()
        vim.cmd.Git("push")
      end)
      keymap.set("n", "<leader>gP", function()
        vim.cmd.Git({ "pull", "--rebase" })
      end)
      keymap.set("n", "<leader>go", ":Git push -u origin ", opts)
    end,
  },
}
