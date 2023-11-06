return {
  "declancm/maximize.nvim",
  config = function()
    require("maximize").setup()

    -- keymap
    local keymap = vim.keymap
    keymap.set("n", "<leader>mt", function()
      require("maximize").toggle()
    end, { desc = "Maximize/minimize a split" })
    keymap.set("n", "<leader>mm", function()
      require("maximize").maximize()
    end, { desc = "Maximize a split" })
    keymap.set("n", "<leader>mr", function()
      require("maximize").restore()
    end, { desc = "Restore all splits" })
  end,
}
