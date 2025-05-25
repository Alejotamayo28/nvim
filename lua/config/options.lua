-- Tecla líder
vim.g.mapleader = " "

-- Configuración de wrap
vim.opt.textwidth = 60
vim.opt.wrap = true -- Activa wrap
vim.opt.linebreak = true -- Rompe líneas en palabras
vim.opt.breakindent = true -- Mantiene la indentación en líneas wrapeadas
vim.opt.showbreak = "↪ " -- Muestra un símbolo al inicio de líneas wrapeadas

-- Configuración de indentación
vim.opt.expandtab = true -- Convierte tabs en espacios
vim.opt.tabstop = 2      -- Número de espacios que un tab representa
vim.opt.softtabstop = 2  -- Número de espacios que un tab representa al editar
vim.opt.shiftwidth = 2   -- Número de espacios para indentación automática

-- Números de línea
vim.opt.number = true         -- Muestra números de línea absolutos
vim.opt.relativenumber = true -- Muestra números de línea relativos

-- Altura de la línea de comandos
vim.opt.cmdheight = 0     -- Altura de la línea de comandos

vim.opt.hlsearch = true   -- Resalta todas las coincidencias después de presionar Enter

vim.opt.ignorecase = true -- Ignora mayúsculas y minúsculas en la búsqueda
vim.opt.smartcase = true  -- Distingue mayúsculas y minúsculas solo si la búsqueda contiene mayúsculas
