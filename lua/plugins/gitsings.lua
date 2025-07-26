return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    signs = {
      add    = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "┃" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      -- Autor, fecha y ultimo cambio
      vim.keymap.set("n", "<leader>gi", gs.blame_line,
        { desc = "Git blame line", buffer = buffer })

      -- Info chunk
      vim.keymap.set("n", "<leader>go", gs.preview_hunk,
        { desc = "Preview hunk changes", buffer = buffer })

      -- Undo chunk
      vim.keymap.set("n", "<leader>gr", gs.reset_hunk,
        { desc = "Git reset hunk (undo changes)", buffer = buffer })

      -- Diferencias pasado presente
      vim.keymap.set("n", "<leader>gp", gs.diffthis,
        { desc = "Git diff", buffer = buffer })

      vim.keymap.set("n", "]h", gs.next_hunk,
        { desc = "Next hunk", buffer = buffer })

      vim.keymap.set("n", "[h", gs.prev_hunk,
        { desc = "Previous hunk", buffer = buffer })

      vim.keymap.set("n", "<leader>gc", require('telescope.builtin').git_commits, { desc = "Git commits" })
    end,
  },
}
