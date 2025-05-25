local keymap = vim.keymap

keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close current buffer" })

keymap.set('v', '<S-y>', '"+y', { noremap = true }) -- Copiar al portapapeles en modo visual
keymap.set('n', '<S-p>', '"+p', { noremap = true }) -- Pegar desde el portapapeles en modo normal

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

