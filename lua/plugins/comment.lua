return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()
		local ft = require("Comment.ft")

		ft.asm = "#%s"
	end,
}
