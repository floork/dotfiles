return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "emmet_ls",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "prismals",
        "pyright",
        "rnix",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "taplo",
        "tsserver",
        "volar",
        "yamlls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "black", -- Python code formatter
        "clang-format", -- C++ code formatter
        "codespell", -- Spell checker for code
        "cpptools", -- C++ code formatter
        "debugpy", -- Python debugger
        "eslint", -- JavaScript code linter
        "yamllint", -- YAML code linter
        "markdownlint", -- Markdown linter
        "isort", -- Python code formatter
        "pylint", -- Python code linter
        "rnix", -- Nix code formatter
        "stylua", -- Lua code formatter
      },
    })
  end,
}
