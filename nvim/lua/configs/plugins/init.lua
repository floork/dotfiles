return {
  {
    "nvim-lua/plenary.nvim",
    "christoomey/vim-tmux-navigator",
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
    "wellle/context.vim", -- keep functions etc at the top of the file
  },
  {
    "github/copilot.vim",
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
}
