return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      icons = {
        rules = false, -- Nerd Font なしでもOK
      },
      win = {
        border = "rounded",
      },
    },
    config = function()
      local wk = require("which-key")

      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>l", group = "LSP" },
        { "<leader>g", group = "Git" },
        { "<leader>gh", group = "Hunk" },
      })
    end
  },
}
