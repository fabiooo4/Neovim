local enabled = false
if not vim.env.TMUX then
	enabled = true
end

return {
	"knubie/vim-kitty-navigator",
	enabled = enabled,
	config = function()
		vim.g.kitty_navigator_no_mappings = 1

		vim.keymap.set("n", "<A-H>", "<cmd>KittyNavigateLeft<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-J>", "<cmd>KittyNavigateDown<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-K>", "<cmd>KittyNavigateUp<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-L>", "<cmd>KittyNavigateRight<cr>", { noremap = true, silent = true })
	end,
}
