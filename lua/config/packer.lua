-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Telescope (fuzzy finder)
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("benfowler/telescope-luasnip.nvim")

	-- Colorschemes
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Treesitter (syntax highlighting)
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Harpoon (quickly jump between files)
	use("ThePrimeagen/harpoon")

	-- UndoTree (visualize undo history)
	use("mbbill/undotree")

	-- Fugitive (Git wrapper)
	use("tpope/vim-fugitive")

	-- Copilot
	use("github/copilot.vim")

	-- Markdown
	use("jakewvincent/mkdnflow.nvim")
	use("dhruvasagar/vim-table-mode")

	-- Markdown Preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- LaTeX
	use("lervag/vimtex")

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required

			-- LSP UI
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	})

	-- Formatter
	use({ "stevearc/conform.nvim" })

	-- NvimTree (file explorer)
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})

	-- ToggleTerm (terminal)
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})

	-- Barbar (tabline)
	use("romgrk/barbar.nvim")

	-- DevIcons (icons)
	use("nvim-tree/nvim-web-devicons")

	-- Autopair (auto close brackets)
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- SnipRun (run code)
	use({ "michaelb/sniprun", run = "sh ./install.sh" })

	-- friendly Snippets
	use("rafamadriz/friendly-snippets")

	use({
		"smjonas/snippet-converter.nvim",
		-- SnippetConverter uses semantic versioning. Example: use version = "1.*" to avoid breaking changes on version 1.
		-- Uncomment the next line to follow stable releases only.
		-- tag = "*",
		config = function()
			local template = {
				-- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
				sources = {
					ultisnips = {
						-- Add snippets from (plugin) folders or individual files on your runtimepath...
						"./UltiSnips",
						-- ...or use absolute paths on your system.
						vim.fn.stdpath("config") .. "/UltiSnips",
					},
				},
				output = {
					-- Specify the output formats and paths
					vscode_luasnip = {
						vim.fn.stdpath("config") .. "/vscode_snippets",
					},
				},
			}

			require("snippet_converter").setup({
				templates = { template },
				-- To change the default settings (see configuration section in the documentation)
				-- settings = {},
			})
		end,
	})
end)
