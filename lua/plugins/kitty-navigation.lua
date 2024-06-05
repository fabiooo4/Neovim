return {
	"knubie/vim-kitty-navigator",
	config = function()
		vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
		vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
		vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
		vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
	end,
}
