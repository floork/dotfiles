return {
  "zbirenbaum/copilot.lua",
  cmd = { "Copilot" },
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
        },
      },
    })

    -- keymap
    local keymap = vim.keymap
    keymap.set("i", "<C-P>", "<cmd> Copilot panel <CR>")
  end,
}
