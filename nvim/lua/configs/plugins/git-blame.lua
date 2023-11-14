return {
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
}
