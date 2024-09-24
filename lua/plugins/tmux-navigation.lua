local enabled = false
if vim.env.TMUX then
	enabled = true
end

return {
	"christoomey/vim-tmux-navigator",
	enabled = enabled,
	lazy = true,
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
	},
	keys = {
		{ "<c-h>", ":TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	},
}
