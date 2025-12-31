local treesitter_path = vim.fs.joinpath(vim.fn.stdpath("data"), "treesitter")

return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },

  config = function()
    -- パーサーのインストール先を指定
    require("nvim-treesitter").setup({ install_dir = treesitter_path })

    -- 自動ハイライトの有効化
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
