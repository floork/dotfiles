return {
  "neovim/nvim-lspconfig",
  "simrat39/rust-tools.nvim",

  -- Debugging
  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-dap",
  config = function()
    local rt = require("rust-tools")

    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
      opts = {
        tools = {
          inlay_hints = {
            highlight = "#ff0000",
            only_current_line = false,
          },
        },
      },
    })
    -- Commands:
    -- RustEnableInlayHints
    -- RustDisableInlayHints
    -- RustSetInlayHints
    -- RustUnsetInlayHints
    rt.inlay_hints.set()
    rt.inlay_hints.enable()
  end,
}
