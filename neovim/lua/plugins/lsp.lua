return {
  -- LSP installer
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    build = ":MasonUpdate",
    config = true,
  },

  -- Mason ↔ LSP bridge
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "kotlin_language_server",
        "ruby_lsp"
      },
      automatic_enable = true,
    },
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.lsp.enable({
        "lua_ls",
        "gopls",
        "sourcekit",
        "kotlin_language_server",
        "ruby_lsp"
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      ---- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      ---- Go
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
        capabilities = capabilities,
      })

      ---- Swift
      vim.lsp.config("sourcekit", {
        capabilities = capabilities,
      })

      ---- Kotlin
      vim.lsp.config("kotlin_language_server", {
        capabilities = capabilities,
      })

      ---- Ruby
      vim.lsp.config("ruby_lsp", {
        capabilities = capabilities,
      })
    end,
  },
}
