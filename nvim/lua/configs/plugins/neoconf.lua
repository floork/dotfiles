return {
  "folke/neoconf.nvim",
  config = function()
    -- keymap
    local keymap = vim.keymap
    keymap.set("n", "<leader>nc", "<cmd>:Neoconf<cr>", { desc = "Neoconf" })
    keymap.set("n", "<leader>ncl", "<cmd>:Neoconf local<cr>", { desc = "Neoconf local" })
    keymap.set("n", "<leader>ncg", "<cmd>:Neoconf global<cr>", { desc = "Neoconf global" })
    keymap.set("n", "<leader>ncs", "<cmd>:Neoconf show<cr>", { desc = "Neoconf show" })
    keymap.set("n", "<leader>nclsp", "<cmd>:Neoconf lsp<cr>", { desc = "Neoconf lsp" })
  end,
}
