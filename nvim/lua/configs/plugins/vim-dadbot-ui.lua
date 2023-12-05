return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1

    vim.g.db_ui_disable_mappings = 1

    -- keymap
    local keymap = vim.keymap
    keymap.set("n", "<leader>uu", ":DBUIToggle<CR>", { noremap = true })
    keymap.set("n", "<leader>uf", ":DBUIFindBuffer<CR>", { noremap = true })
    keymap.set("n", "<leader>ua", ":DBUIAddConnection<CR>", { noremap = true })
  end,
}
