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

	-- Comments
	use("numToStr/Comment.nvim")

	-- Markdown
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

	-- Friendly Snippets
	use("rafamadriz/friendly-snippets")

	-- Lualine (Status bar)
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- R
	use("jalvesaq/Nvim-R")
end)
