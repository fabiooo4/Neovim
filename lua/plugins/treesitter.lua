return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	tag = "v0.10.0",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Custom sj treesitter
		vim.filetype.add({
			extension = {
				sj = function()
					vim.opt_local.smartindent = false
					vim.opt_local.shiftwidth = 4
					vim.opt_local.tabstop = 4
					vim.opt_local.softtabstop = 4
					vim.opt_local.expandtab = true
					return "sj"
				end,
			},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.sj = {
			install_info = {
				url = vim.fn.expand("~/.config/nvim/parsers/tree-sitter-sj"),
				files = { "src/parser.c" },
				generate_requires_npm = false,
				requires_generate_from_grammar = false,
			},
			filetype = "sj",
		}
    -- Custom sj tresitter

		-- Main setup
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ignore_install = { "latex" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
