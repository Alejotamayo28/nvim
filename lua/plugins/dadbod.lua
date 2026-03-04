return {
  {
    "tpope/vim-dadbod",
    lazy = false,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_winwidth = 35
    end,
    config = function()
      vim.keymap.set("n", "<C-d>c", ":DBUIAddConnection<CR>", { desc = "Add DB Connection" })
      vim.keymap.set("v", "<C-m>", ":DB<CR>", { desc = "Execute selected query" })
      vim.keymap.set("n", "<C-m>", ":.DB<CR>", { desc = "Execute current line as query" })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
}
