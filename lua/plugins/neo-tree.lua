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
            -- Grupos principales
            vim.cmd("highlight NeoTreeNormal guibg=NONE")
            vim.cmd("highlight NeoTreeNormalNC guibg=NONE")

            -- Corrige fondo negro en buffers vacíos
            vim.cmd("highlight Normal guibg=NONE")
            vim.cmd("highlight NormalNC guibg=NONE")
            vim.cmd("highlight EndOfBuffer guibg=NONE guifg=NONE")

            vim.cmd("highlight EndOfBuffer guibg=NONE guifg=NONE")
            vim.cmd("highlight NeoTreeEndOfBuffer guibg=NONE guifg=NONE")

            -- Asegura transparencia en floating windows (si algún día usas float)
            vim.cmd("highlight NeoTreeFloatNormal guibg=NONE")

            -- Otras protecciones
            vim.cmd("highlight StatusLine guibg=NONE")
            vim.cmd("highlight StatusLineNC guibg=NONE")
          end
        }
      }
    })
    vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "NONE", fg = "NONE" })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal current toggle<CR>", {});
  end,
}
