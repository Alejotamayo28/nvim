return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
sources = {
			-- Formatter: Biome
			null_ls.builtins.formatting.biome,
			-- Diagnostics (linting): Biome
			null_ls.builtins.diagnostics.biome,
			-- Formatter: Ruff
			null_ls.builtins.formatting.ruff,
			-- Diagnostics: Ruff
			null_ls.builtins.diagnostics.ruff,
		},
    })

    -- Formatear con LSP (Biome)
    vim.keymap.set("n", "<C-s>", function()
      vim.lsp.buf.format({ async = false })
    end, {})
  end,
}
