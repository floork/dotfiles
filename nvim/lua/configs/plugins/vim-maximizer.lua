return {
  "szw/vim-maximizer",
  config = function()
    vim.g.maximizer_set_default_mapping = 0

    -- keymap
    local keymap = vim.keymap
    keymap.set("n", "<leader>mm", "<cmd>MaximizerToggle!<CR>")
  end,
}
