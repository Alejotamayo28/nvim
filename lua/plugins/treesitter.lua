return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true, -- Instalación automática de parsers
      highlight = {
        enable = true,     -- Habilitar resaltado
        disable = { "cpp" }
      },
      incremental_selection = {
        enable = true,               -- Habilitar selección incremental
        keymaps = {
          init_selection = "gnn",    -- Iniciar selección
          node_incremental = "grn",  -- Incrementar selección
          scope_incremental = "grc", -- Incrementar ámbito
          node_decremental = "grm",  -- Decrementar selección
        },
      },
      indent = {
        enable = true, -- Habilitar indentación automática
      },
    })
  end,
}
