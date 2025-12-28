return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- navigation
        map("n", "]c", gs.next_hunk, "Next hunk")
        map("n", "[c", gs.prev_hunk, "Prev hunk")

        -- actions
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gn", gs.next_hunk, "Next hunk")
        map("n", "<leader>gb", gs.blame_line, "Blame line")
      end,
    },
  },
}
