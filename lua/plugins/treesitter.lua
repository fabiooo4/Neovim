return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"rust",
			"c",
			"javascript",
			"lua",
			"java",
			"gitcommit",
			"git_rebase",
			"diff",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(ev.match)
				local available_langs = require("nvim-treesitter").get_available()
				local is_available = vim.tbl_contains(available_langs, lang)
				if is_available then
					local installed_langs = require("nvim-treesitter").get_installed()
					local installed = vim.tbl_contains(installed_langs, lang)
					if not installed then
						require("nvim-treesitter").install(lang):wait()
					end

					-- Highlights
					vim.treesitter.start()

					-- Folds
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"

					-- Indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
