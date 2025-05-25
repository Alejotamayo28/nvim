return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    signs = {
      add    = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "▁" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "<leader>gp", gs.preview_hunk,
      { desc = "Preview hunk changes", buffer = buffer })

      vim.keymap.set("n", "<leader>gb", gs.blame_line,
        { desc = "Git blame line", buffer = buffer })
      vim.keymap.set("n", "<leader>gd", gs.diffthis,
        { desc = "Git diff", buffer = buffer })


      vim.keymap.set("n", "]h", gs.next_hunk,
        { desc = "Next hunk", buffer = buffer })
      vim.keymap.set("n", "[h", gs.prev_hunk,
        { desc = "Previous hunk", buffer = buffer })
    end,
  },
}
