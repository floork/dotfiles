return {
  "mogulla3/autosave.nvim",
  config = function()
    require("autosave").setup({
      enabled = false,
      trigger_events = { "FocusLost" },
    })
    --keymap
    local keymap = vim.keymap
    keymap.set("n", "<leader>as", ":AutosaveToggle<CR>", { noremap = true, silent = true })
  end,
}
