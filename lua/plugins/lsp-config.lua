return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Servidores con configuración por defecto
			local servers = { "yamlls", "lua_ls", "terraformls", "pyright" }
			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
				})
				vim.lsp.enable(server)
			end

			-- clangd con configuración específica
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
			})
			vim.lsp.enable("clangd")

			-- ts_ls con configuración específica
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
			})
			vim.lsp.enable("ts_ls")

			-- Configuración de diagnósticos
			vim.diagnostic.config({
				virtual_text = false,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = false,
			})

			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focusable = false })
				end,
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
