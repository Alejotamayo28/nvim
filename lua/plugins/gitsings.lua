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
      vim.keymap.set("n", "<leader>gk", gs.reset_hunk,
        { desc = "Git reset hunk (undo changes)", buffer = buffer })

      -- Diferencias pasado presente
      vim.keymap.set("n", "<leader>gp", gs.diffthis,
        { desc = "Git diff", buffer = buffer })

      vim.keymap.set("n", "]h", gs.next_hunk,
        { desc = "Next hunk", buffer = buffer })

      vim.keymap.set("n", "[h", gs.prev_hunk,
        { desc = "Previous hunk", buffer = buffer })

      vim.keymap.set("n", "<leader>gc", function()
        require('telescope.builtin').git_commits({
          attach_mappings = function(_, map)
            -- Sobrescribir Enter para mostrar el commit en un buffer temporal
            map('i', '<CR>', function(prompt_bufnr)
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)

              -- Crear buffer temporal con el diff del commit
              local commit_hash = selection.value
              local output = vim.fn.systemlist('git show ' .. commit_hash)

              -- Abrir en split vertical
              vim.cmd('vsplit')
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
              vim.api.nvim_win_set_buf(0, buf)
              vim.bo[buf].filetype = 'git'
              vim.bo[buf].bufhidden = 'wipe'
            end)

            map('n', '<CR>', function(prompt_bufnr)
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)

              local commit_hash = selection.value
              local output = vim.fn.systemlist('git show ' .. commit_hash)

              vim.cmd('vsplit')
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
              vim.api.nvim_win_set_buf(0, buf)
              vim.bo[buf].filetype = 'git'
              vim.bo[buf].bufhidden = 'wipe'
            end)

            return true
          end,
        })
      end, { desc = "Git commits (view only)" })

      -- Commits del archivo actual
      vim.keymap.set("n", "<leader>gv", function()
        require('telescope.builtin').git_bcommits({
          attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)

              local commit_hash = selection.value
              local output = vim.fn.systemlist('git show ' .. commit_hash)

              vim.cmd('vsplit')
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
              vim.api.nvim_win_set_buf(0, buf)
              vim.bo[buf].filetype = 'git'
              vim.bo[buf].bufhidden = 'wipe'
            end)

            map('n', '<CR>', function(prompt_bufnr)
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)

              local commit_hash = selection.value
              local output = vim.fn.systemlist('git show ' .. commit_hash)

              vim.cmd('vsplit')
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
              vim.api.nvim_win_set_buf(0, buf)
              vim.bo[buf].filetype = 'git'
              vim.bo[buf].bufhidden = 'wipe'
            end)

            return true
          end,
        })
      end, { desc = "Git commits (current file)" })
    end,
  },
}
