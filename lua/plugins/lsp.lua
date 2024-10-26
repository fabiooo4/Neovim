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
		opts = {
			setup = {
				rust_analyzer = function()
					return true
				end,
			},
		},
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

			vim.g.rustaceanvim = {
        tools = {
          test_executor = "background"
        },
				server = {
					cmd = function()
						local mason_registry = require("mason-registry")
						if mason_registry.is_installed("rust-analyzer") then
							-- This may need to be tweaked depending on the operating system.
							local ra = mason_registry.get_package("rust-analyzer")
							local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
							return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
						else
							-- global installation
							return { "rust-analyzer" }
						end
					end,

					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						local opts = { noremap = true, silent = true }
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader><F5>", "<cmd>RustLsp run<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ct", "<cmd>RustLsp testables<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>RustLsp codeAction<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>x", "<cmd>RustLsp explainError current<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rd", "<cmd>RustLsp openDocs<CR>", opts)
					end,
				},
			}
		end,
	},
	{
		-- Rust custom lsp
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}
