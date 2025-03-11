return {
  "catppuccin/nvim",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      color_overrides = {
        mocha = {
          base = "#000000"
        }
      }
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
