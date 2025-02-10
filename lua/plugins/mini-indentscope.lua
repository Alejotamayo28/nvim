--[[return {
    'echasnovski/mini.indentscope',
  version = false,
  config = function()
    require('mini.indentscope').setup({
      symbol = '╎ ',
      draw = {
        delay = 100,
        animation = require('mini.indentscope').gen_animation.none(),
      },
      options = { indent_at_cursor = true,
        try_as_border = false
      }
    })
  end
}
--]]

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlight = {
      "white"
    }
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "white", { fg = "#a8aebf" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }

    require("ibl").setup {
      indent = {
        --char = "|"
      },
      scope = {
        --char = "|",
        highlight = highlight,
        show_start = false,
        --show_end = false
      }
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end
}
