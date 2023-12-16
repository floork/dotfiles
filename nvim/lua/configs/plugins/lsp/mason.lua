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
        "bashls", -- Bash language server
        "clangd", -- C/C++/Objective-C language server
        "cmake", -- CMake language server
        "cssls", -- CSS language server
        "dockerls", -- Docker language server
        "docker_compose_language_service", -- Docker Compose language server
        "emmet_ls", -- Emmet language server
        "html", -- HTML language server
        "jsonls", -- JSON language server
        "lua_ls", -- Lua language server
        "marksman", -- Markdown language server
        "pyright", -- Python language server
        "rnix", -- Nix language server
        "rust_analyzer", -- Rust language server
        "taplo", -- TOML language server
        "tsserver", -- TypeScript language server
        "volar", -- Vue language server
        "yamlls", -- YAML language server
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
