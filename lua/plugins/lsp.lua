return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		priority = 53,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		priority = 52,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"rust_analyzer",
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
					"marksman",
					"tsserver",
					"bibtex-tidy",
					"cssls",
					"glsl_analyzer",
					"ltex",
					"svelte",
					"tailwindcss",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		priority = 51,
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
			lspconfig.tsserver.setup({ capabilities = capabilities })
			lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
			lspconfig.svelte.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({ capabilities = capabilities })

			-- keybinds
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- convert to lua
			-- vim.cmd([[
			--      map <leader>d :lua vim.diagnostic.open_float(0, {scope="line"})<CR>
			--    ]])
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
		end,
	},
}
