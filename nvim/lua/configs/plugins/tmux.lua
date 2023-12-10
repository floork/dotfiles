return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    -- keymaps
    local keymap = vim.keymap
    keymap.set("n", "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { noremap = true })
    keymap.set("n", "<C-j>", "<CMD>TmuxNavigateDown<CR>", { noremap = true })
    keymap.set("n", "<C-k>", "<CMD>TmuxNavigateUp<CR>", { noremap = true })
    keymap.set("n", "<C-l>", "<CMD>TmuxNavigateRight<CR>", { noremap = true })
  end,
}
