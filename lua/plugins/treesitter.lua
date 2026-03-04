return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "yaml",
        "json",
        "markdown",
      },
      auto_install = true, -- Instalación automática de parsers adicionales
      highlight = {
        enable = true, -- Habilitar resaltado
        disable = { "cpp", "dockerfile" } -- Desactivar para Dockerfiles (bug con instrucciones multi-línea)
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
