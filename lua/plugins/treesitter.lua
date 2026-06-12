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
        [
          (block)
          (list)
          (parenthesized_expression)
          (formal_params)
          (actual_params)
          (binary_expression)
          (conditional_expression)
        ] @indent.begin

        [
          "}"
          "]"
          ")"
        ] @indent.branch @indent.end

        "else" @indent.branch
      ]]
		)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sj",
			callback = function()
				vim.bo.shiftwidth = 4
				vim.bo.tabstop = 4
				vim.bo.softtabstop = 4
				vim.bo.expandtab = true
				vim.bo.autoindent = true
				vim.bo.smartindent = false
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
