return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Colores personalizados que coinciden con el tema de tmux
    local colors = {
      bg = '#1a1b26',
      fg = '#c0caf5',
      yellow = '#e0af68',
      cyan = '#7dcfff',
      darkblue = '#7aa2f7',
      green = '#9ece6a',
      orange = '#ff9e64',
      violet = '#bb9af7',
      magenta = '#bb9af7',
      blue = '#7aa2f7',
      red = '#f7768e'
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end
    }

    local config = {
      options = {
        theme = {
          normal = {
            a = {fg = colors.fg, bg = colors.bg},
            b = {fg = colors.fg, bg = colors.bg},
            c = {fg = colors.fg, bg = colors.bg},
            z = {fg = colors.fg, bg = colors.bg},
          },
          insert = {a = {fg = colors.green, bg = colors.bg}},
          visual = {a = {fg = colors.violet, bg = colors.bg}},
          replace = {a = {fg = colors.red, bg = colors.bg}},
        },
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {
          {
            'mode',
            color = function()
              local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.violet,
                ['␖'] = colors.blue,
                V = colors.violet,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                ['␓'] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red
              }
              return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { left = 1, right = 1 },
          }
        },
        lualine_b = {
          {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
          },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1,
            symbols = {
              modified = '●',
              readonly = '',
              unnamed = '[Sin nombre]',
            }
          }
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
              color_error = { fg = colors.red },
              color_warn = { fg = colors.yellow },
              color_info = { fg = colors.cyan },
            },
          },
          { 'encoding' },
          { 'fileformat' },
          { 
            'filetype',
            colored = true,
            icon_only = false,
          }
        },
        lualine_y = {
          {
            'progress',
            color = { fg = colors.fg, gui = 'bold' },
          }
        },
        lualine_z = {
          {
            'location',
            color = { fg = colors.fg, gui = 'bold' },
          }
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
    require('lualine').setup(config)
  end,
}
