return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      dimensions = {
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
      },
      border = "single", -- or 'double'
    })

    local keymap = vim.keymap
    keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
    keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
  end,
}
