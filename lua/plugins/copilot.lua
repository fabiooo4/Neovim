return {
	"github/copilot.vim",
	config = function()
		vim.cmd(":Copilot disable")
		vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.g.copilot_no_tab_map = true
		vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-word)")
	end,
}
