return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
  tag = "0.10.0",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			auto_install = true,
			ignore_install = { "latex" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
