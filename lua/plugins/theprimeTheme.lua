return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      transparent_mode = false, -- ponlo en true si quieres fondo transparente
      italics = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
    })
    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
