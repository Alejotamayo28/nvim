return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
      vim.keymap.set("n", "<C-p>", function()
        builtin.find_files({
          cwd = vim.fn.getcwd(),
          file_ignore_patterns = { "node_modules" }, -- Ignora el directorio node_modules
        })
      end, {})
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search diagnostics" })
      vim.keymap.set("n", "<C-o>", function()
        builtin.buffers(require("telescope.themes").get_dropdown({
          previewer = false,
          layout_config = { width = 0.5 },
          sort_lastused = true,
          show_all_buffers = true,
          ignore_current_buffer = true,
          prompt_title = "Buffers Activos",
          path_display = { "smart" },
        }))
      end, { noremap = true, silent = true })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        override = {
          ['Dockerfile'] = {
            icon = "",
            color = "#0db7ed",
            cterm_color = "74",
            name = "Dockerfile"
          },
          ['docker-compose.yml'] = {
            icon = "",
            color = "#0db7ed",
            cterm_color = "74",
            name = "docker-compose"
          }
        },
        default = true,
      })
    end
  }
}
