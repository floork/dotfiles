return {
  {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use

    "christoomey/vim-tmux-navigator", -- tmux & split window navigation

    "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
    config = function()
      -- keymaps
      local keymap = vim.keymap
      keymap.set("n", "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { noremap = true })
      keymap.set("n", "<C-j>", "<CMD>TmuxNavigateDown<CR>", { noremap = true })
      keymap.set("n", "<C-k>", "<CMD>TmuxNavigateUp<CR>", { noremap = true })
      keymap.set("n", "<C-l>", "<CMD>TmuxNavigateRight<CR>", { noremap = true })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "wellle/context.vim",
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "szw/vim-maximizer",
    config = function()
      vim.g.maximizer_set_default_mapping = 0

      -- keymap
      local keymap = vim.keymap
      keymap.set("n", "<leader>mm", "<cmd>MaximizerToggle!<CR>")
    end,
  },
}
