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
    },
    config = function()
      vim.lsp.enable({
        "lua_ls",
        "gopls",
        "sourcekit",
        "kotlin_language_server",
        "ruby_lsp"
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local buf = args.buf

          -- デフォルトで設定されている言語サーバー用キーバインドに設定を追加する
          -- See https://neovim.io/doc/user/lsp.html#lsp-defaults
          -- 言語サーバーのクライアントがLSPで定められた機能を実装していたら設定を追加するという流れ

          if client:supports_method("textDocument/definition") then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
          end

          if client:supports_method("textDocument/hover") then
            vim.keymap.set("n", "<leader>k",
              function() vim.lsp.buf.hover({ border = "single" }) end,
              { buffer = buf, desc = "Show hover documentation" })
          end

          -- Auto-format ("lint") on save.
          -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
          if not client:supports_method("textDocument/willSaveWaitUntil")
              and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
