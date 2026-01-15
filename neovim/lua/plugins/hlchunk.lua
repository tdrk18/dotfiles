return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
        },
        blank = {
          enable = false,
        },
      })
    end
  },
}
