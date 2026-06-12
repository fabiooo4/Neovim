return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	tag = "v0.10.0",
	lazy = false,
	build = ":TSUpdate",
	init = function()
		vim.filetype.add({
			extension = {
				sj = "sj",
			},
		})
	end,
	config = function()
		-- Custom sj treesitter
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

		-- Inline queries for sj
		vim.treesitter.query.set(
			"sj",
			"highlights",
			[[
        [ "let" "fn" "if" "else" "while" "return" "break" "exit" ] @keyword
        [ "print" "to_str" ] @function.call
        (primitive_type) @type.builtin
        (array_type) @type
        (identifier) @variable
        (function_declaration name: (identifier) @function)
        (function_call name: (identifier) @function.call)
        (function_call_statement name: (identifier) @function.call)
        (number) @number
        (boolean) @boolean
        (string) @string
        (char) @string
        (escape_sequence) @string.escape
        (comment) @comment
        [ "=" "+" "-" "*" "/" "%" "^" "==" "!=" "<" "<=" ">" ">=" "&&" "||" "!" "!&" "!|" "::" "+=" "-=" "*=" "/=" "->" "?" ":" "++" "--" ] @operator
        [ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket
        [ "," ";" ":" ] @punctuation.delimiter
      ]]
		)

		vim.treesitter.query.set(
			"sj",
			"folds",
			[[
        [ (block) (function_declaration) ] @fold
      ]]
		)

		vim.treesitter.query.set(
			"sj",
			"indents",
			[[
        ((block) @indent.begin)
        "}" @indent.branch
      ]]
		)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sj",
			callback = function()
				vim.opt_local.smartindent = false
				vim.opt_local.shiftwidth = 4
				vim.opt_local.tabstop = 4
				vim.opt_local.softtabstop = 4
				vim.opt_local.expandtab = true
				vim.treesitter.start()
			end,
		})
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
