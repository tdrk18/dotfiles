local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ノーマルモード
keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write" })
keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })
keymap("n", "<Esc><Esc>", ":nohlsearch<CR>", opts)
keymap("n", "tc", ":tablast <bar> tabnew<CR>", opts)
keymap("n", "tx", ":tabclose<CR>", opts)
keymap("n", "tn", ":tabnext<CR>", opts)
keymap("n", "tp", ":tabprevious<CR>", opts)

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
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Commands" })

vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition" })
vim.keymap.set("n", "<leader>lc", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover documentation" })

vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>",  { desc = "Git commits" })
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>", { desc = "Buffer commits" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>",   { desc = "Git status" })
vim.keymap.set("n", "<leader>gS", "<cmd>Telescope git_stash<CR>",    { desc = "Git stash" })
