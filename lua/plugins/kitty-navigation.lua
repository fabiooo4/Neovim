if not vim.env.TMUX then
return {
	"knubie/vim-kitty-navigator",
	config = function()
		vim.keymap.set("n", "<A-H>", ":wincmd h<CR>")
		vim.keymap.set("n", "<A-J>", ":wincmd j<CR>")
		vim.keymap.set("n", "<A-K>", ":wincmd k<CR>")
		vim.keymap.set("n", "<A-L>", ":wincmd l<CR>")
	end,
}
else return {} end
