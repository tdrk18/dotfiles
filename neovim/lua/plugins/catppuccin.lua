return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- 最初にロード
    lazy = false,    -- 起動時に必ず有効
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        auto_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          mason = false,
          nvimtree = true,
          telescope = {
            enabled = true,
          },
          which_key = false,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}
