return {
  "mfussenegger/nvim-dap",

  dependencies = {

    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
        enabled = true,
        enabled_commands = true,
      },
    },

    -- which key integration
    -- {
    --   "folke/which-key.nvim",
    --   optional = true,
    --   opts = {
    --     defaults = {
    --       ["<leader>d"] = { name = "+debug" },
    --       ["<leader>da"] = { name = "+adapters" },
    --     },
    --   },
    -- },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },

  -- stylua: ignore
  keys = {
    { "<F1>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<F2>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<F5>", function() require("dap").continue() end, desc = "Continue" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
        -- { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    -- { "<F6>", function() require("dap").run_last() end, desc = "Run Last" },
    -- { "<F7>", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    -- { "<F8>", function() require("dap").terminate() end, desc = "Terminate" },
    -- { "<F3>", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    -- { "<F4>", function() require("dap").pause() end, desc = "Pause" },
    -- { "<F5>", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    -- { "<F13>", function() require("dap").down() end, desc = "Down" },
    -- { "<F14>", function() require("dap").up() end, desc = "Up" },
    -- { "<F15>", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    -- { "<F16>", function() require("dap").session() end, desc = "Session" },
      -- { "<F17>", function() require("dap").run_last() end, desc = "Restart" },
  },
}