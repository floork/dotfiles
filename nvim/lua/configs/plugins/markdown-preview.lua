return {
  "iamcco/markdown-preview.nvim",
  config = function()
    vim.fn["mkdp#util#install"]()

    -- keymap
    local keymap = vim.keymap

    keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { noremap = false })
    keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { noremap = false })
    keymap.set("n", "<leader>mr", "<Plug>MarkdownPreviewToggle", { noremap = false })
  end,
}
