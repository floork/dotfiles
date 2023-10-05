return {
  "toppair/peek.nvim",
  run = "deno task --quiet build:fast",
  config = function()
    -- keymap
    local keymap = vim.keymap

    keymap.set("n", "<leader>mp", ":Peek<CR>", { noremap = true, silent = true })
  end,
}
