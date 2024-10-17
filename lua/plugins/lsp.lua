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
					"cssls",
					"glsl_analyzer",
					"svelte",
					"tailwindcss",
          "ts_ls",
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

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

				-- setup lsp
				--[[ lspconfig.clangd.setup({ capabilities = capabilities })
				lspconfig.rust_analyzer.setup({ capabilities = capabilities })
				lspconfig.lua_ls.setup({ capabilities = capabilities })
				lspconfig.html.setup({ capabilities = capabilities })
				lspconfig.cssls.setup({ capabilities = capabilities })
				lspconfig.denols.setup({ capabilities = capabilities })
				lspconfig.jsonls.setup({ capabilities = capabilities })
				lspconfig.marksman.setup({ capabilities = capabilities })
				lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
				lspconfig.svelte.setup({ capabilities = capabilities })
				lspconfig.tailwindcss.setup({ capabilities = capabilities }) ]]

				-- keybinds
				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			end

			local servers = {
				"clangd",
				"rust_analyzer",
				"lua_ls",
				"html",
				"cssls",
				"jsonls",
				"marksman",
				"glsl_analyzer",
				"svelte",
				"tailwindcss",
        "ts_ls",
			}

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 150,
					},
				})
			end
		end,
	},
}
