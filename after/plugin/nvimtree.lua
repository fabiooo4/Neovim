-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- custom mappings
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<CR>")

-- pass to setup along with your other options
require("nvim-tree").setup({
	view = {
		side = "right",
	},
})
