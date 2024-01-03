return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require("todo-comments").setup()
      -- keymap
      local keymap = vim.keymap

      local possible_comment_types = "FIX|TODO|HACK|WARN|PERF|NOTE|TEST"
      keymap.set("n", "<leader>;;", "<cmd>TodoTelescope<cr>", { desc = possible_comment_types })
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx and jsx files
        pre_hook = ts_context_commentstring.create_pre_hook(),
        toggle = true,
        opleader = {
          line = "gcc",
          block = "gcb",
        },
      })
    end,
  },
}
