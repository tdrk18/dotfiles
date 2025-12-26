-- ~/.config/nvim/lua/core/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ノーマルモード
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- 行移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- インサートモード
keymap("i", "jj", "<Esc>", opts)

