require("lazy").setup({
  -- colorscheme
  {
    "shaunsingh/nord.nvim",
    priority = 1000, -- 最初にロード
    lazy = false,    -- 起動時に必ず有効
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true

      vim.cmd.colorscheme("nord")
    end,
  },

  -- treesitter
  require("plugins.treesitter"),
  -- LSP
  require("plugins.lsp"),
  -- Completion
  require("plugins.cmp"),
  -- telescope
  require("plugins.telescope"),
  -- lualine
  require("plugins.lualine"),
  -- which-key
  require("plugins.which-key"),
  -- gitsigns
  require("plugins.gitsigns"),
  -- nvim-tree
  require("plugins.nvim-tree"),
})
