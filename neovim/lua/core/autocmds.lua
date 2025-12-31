local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 例：保存時に行末スペース削除（後で有効化してもOK）
-- augroup("TrimWhitespace", { clear = true })
-- autocmd("BufWritePre", {
--   group = "TrimWhitespace",
--   command = "%s/\\s\\+$//e",
-- })

