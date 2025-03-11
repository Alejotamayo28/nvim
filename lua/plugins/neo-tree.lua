return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      default_component_configs = {
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("highlight NeoTreeNormal guibg=#000000")
            vim.cmd("highlight NeoTreeNormalNC guibg=#000000")
            vim.cmd("highlight NeoTreeEndOfBuffer guibg=#000000 guifg=#000000")
          end
        }
      }
    })
    vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#3B4252", fg = "none" })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal current toggle<CR>", {});
  end,
}
