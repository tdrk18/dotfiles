return {
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
  }
}
