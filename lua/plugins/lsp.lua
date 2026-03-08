return {
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
		lazy = false,
		priority = 53,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0",
		lazy = false,
		priority = 52,
		config = function()
			local ensure_installed = {
				"clangd",
				"lua_ls",
				"html",
				"cssls",
				"jsonls",
				"cssls",
        "marksman",
				"glsl_analyzer",
				"svelte",
				"tailwindcss",
				"ts_ls",
				"eslint",
				"jedi_language_server",
				"matlab_ls",
				"nil_ls",
			}

      -- If on nixos ensure_installed should be empty
      -- lsp are installed via nix
      if vim.fn.executable("nixos-rebuild") == 1 then
        ensure_installed = {}
      end

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})
		end,
	},
	{
		-- Rust custom lsp
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		-- Flutter custom lsp
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = true,
	},
	--[[ {
    -- Java custom lsp
    "nvim-java/nvim-java",
  }, ]]
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
			--[[ require("java").setup({
        -- load java debugger plugins
        java_debug_adapter = {
          enable = true,
        },
        notifications = {
          -- disable 'Configuring DAP' & 'DAP configured' messages on start up
          dap = false,
        },
      }) ]]

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(_, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

				-- keybinds
				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			end

			local servers = {
				"lua_ls",
				"html",
				"cssls",
				"jsonls",
				"marksman",
				"glsl_analyzer",
				"svelte",
				"tailwindcss",
				"ts_ls",
				"eslint",
				"jedi_language_server",
				"matlab_ls",
			}

			for _, lsp in ipairs(servers) do
				vim.lsp.config(lsp, {
					on_attach = on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 50,
					},
				})
				vim.lsp.enable(lsp)
			end

			if
				vim.fn.executable("nixd") == 1
				and vim.fn.executable("nil") == 1
				and vim.fn.executable("alejandra") == 1
				and vim.fn.executable("nixos-rebuild") == 1
			then
				local nixos_expr =
					'(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.nixos.options'
				local home_manager_expr =
					'(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.fabibo.options.home-manager.users.type'
				-- local nixpkgs_expr = 'import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }';
				local nixpkgs_expr = "import <nixpkgs> { }"
				local flake_path = os.getenv("FLAKE")

				local hostname = vim.fn.trim(vim.fn.system("hostname"))
				if flake_path then
					nixos_expr = '(builtins.getFlake ("git+file://'
						.. flake_path
						.. '")).nixosConfigurations.'
						.. hostname
						.. ".options"
					home_manager_expr = '(builtins.getFlake ("git+file://'
						.. flake_path
						.. '")).nixosConfigurations.'
						.. hostname
						.. ".options.home-manager.users.type"
				end

				local nixd_on_attach = function(client, bufnr)
					on_attach(client, bufnr)

					-- Disable everything EXCEPT completions and highlighting, since I use
					-- both nixd and nil, and nil is better at everything else
					client.server_capabilities.codeActionProvider = nil
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.documentFormattingProvider = true
					client.server_capabilities.documentSymbolProvider = false
					client.server_capabilities.documentHighlightProvider = false
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.inlayHintProvider = false
					client.server_capabilities.referencesProvider = false
					client.server_capabilities.renameProvider = false
				end

				local nil_on_attach = function(client, bufnr)
					on_attach(client, bufnr)

					-- Get completion from nixd, and everything else from nil
					client.server_capabilities.completionProvider = nil
					client.server_capabilities.semanticTokensProvider = nil
					client.server_capabilities.documentFormattingProvider = false
				end

				vim.lsp.config("nil_ls", {
					on_attach = nil_on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 150,
					},
				})
				vim.lsp.enable("nil_ls")

				vim.lsp.config("nixd", {
					on_attach = nixd_on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 150,
					},
					cmd = { "nixd" },
					settings = {
						nixd = {
							single_file = true,
							nixpkgs = {
								expr = nixpkgs_expr,
							},
							formatting = {
								command = { "alejandra" },
							},
							options = {
								nixos = {
									expr = nixos_expr,
								},
								home_manager = {
									expr = home_manager_expr,
								},
							},
						},
					},
				})
				vim.lsp.enable("nixd")
			end

			vim.g.rustaceanvim = {
				tools = {
					test_executor = "background",
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
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"<leader>x",
							"<cmd>RustLsp explainError current<CR>",
							opts
						)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rd", "<cmd>RustLsp openDocs<CR>", opts)
					end,
				},
			}

			-- Check if the ESP-IDF environment variable is set
			local esp_idf_path = os.getenv("IDF_PATH")
			local home = os.getenv("HOME")
			if esp_idf_path then
				-- for esp-idf
				vim.lsp.config("clangd", {
					-- Useful .clangd config to remove errors
					-- CompileFlags:
					--   Remove: [-fno-tree-switch-conversion, -fno-shrink-wrap, -mtext-section-literals, -mlongcalls, -fstrict-volatile-bitfields, -march=rv32imac_zicsr_zifencei]
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = {
						home .. "/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd",
						"--background-index",
						"--query-driver=**",
					},
					--[[ root_dir = function()
            -- leave empty to stop nvim from cd'ing into ~/ due to global .clangd file
          end, ]]
				})
				vim.lsp.enable("clangd")
			else
				-- clangd config
				vim.lsp.config("clangd", {
					on_attach = on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 150,
					},
				})
				vim.lsp.enable("clangd")
			end
		end,
	},
}
