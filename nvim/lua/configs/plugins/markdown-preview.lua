return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    -- keymap
    local keymap = vim.keymap

    keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { noremap = false })
    keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { noremap = false })
    keymap.set("n", "<leader>mr", "<Plug>MarkdownPreviewToggle", { noremap = false })
  end,
}
