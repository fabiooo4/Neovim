return {
	"github/copilot.vim",
	config = function()
		vim.cmd(":Copilot disable")
		vim.cmd([[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]])
	end,
}
