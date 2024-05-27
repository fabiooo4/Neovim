return {
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"rust_analyzer",
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
					"marksman",
					"r_language_server",
					"tsserver",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- setup lsp
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.marksman.setup({ capabilities = capabilities })
			lspconfig.r_language_server.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })
			lspconfig.ltex.setup({ capabilities = capabilities })

			-- keybinds
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
