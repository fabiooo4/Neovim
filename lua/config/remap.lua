vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Remap insert mode ctrl-w to ctrl-backspace
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })

-- Pane navigation
--[[ vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>") ]]

-- Execute the binary with the same name as the current file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "asm,c,cpp",
	command = [[
    nnoremap <leader><F5> :TermExec cmd='./%:r'<CR> <C-w>ji
  ]],
})

-- Neovide
if vim.g.neovide then
	vim.keymap.set("n", "<C-v>", '"+p') -- Paste normal mode
	vim.keymap.set("v", "<C-v>", '"+p') -- Paste visual mode
	vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-v>", '<ESC>"+pla') -- Paste insert mode
	vim.keymap.set("t", "<C-v>", '<C-\\><C-n>"+pi') -- Paste terminal mode

	-- Scale neovide
	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)
end

-- Paste with C-v
vim.keymap.set("i", "<C-v>", '<ESC>"+pla')
vim.keymap.set("t", "<C-v>", '<C-\\><C-n>"+pi')
