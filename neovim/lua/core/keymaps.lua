local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ノーマルモード
keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write" })
keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- 行移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- インサートモード
keymap("i", "jj", "<Esc>", opts)

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help" })

vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition" })
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
