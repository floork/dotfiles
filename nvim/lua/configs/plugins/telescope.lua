return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-dap.nvim",
    "folke/noice.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      extensions = {
        file_browser = {
          theme = "ivy",
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
      defaults = {
        -- path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("dap")
    telescope.load_extension("noice")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local builtins = require("telescope.builtin")

    keymap.set("n", "<leader>fl", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>ff", builtins.git_files, { desc = "Fuzzy find git files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep hidden=true<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>df", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "Show dap breakpoints" })
  end,
}
