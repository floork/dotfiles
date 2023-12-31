return {
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
}
