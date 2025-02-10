local keymap = vim.keymap

keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close current buffer" })

vim.keymap.set('v', 'y', '"+y', { noremap = true })
vim.keymap.set('n', 'p', '"+p', { noremap = true })
