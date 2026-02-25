require("config")

vim.o.autoread = true

vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif"
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("Archivo modificado externamente. Recargado automáticamente.", vim.log.levels.INFO, { title = "Auto-reload" })
  end
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.updatetime = 300
vim.opt.rtp:prepend(lazypath)

vim.opt.fillchars = { eob = " " }


require("lazy").setup("plugins")
