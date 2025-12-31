local opt = vim.opt

-- 表示
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"

-- インデント
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- 編集体験
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.mouse = "a"

-- クリップボード
opt.clipboard = "unnamedplus"

-- ファイル
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.autoread = true
