vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

vim.opt.nu = false
vim.opt.relativenumber = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"
vim.g.mapleader = " "

-- Terminal colors
--  black
vim.g.terminal_color_0 = "#45475A"
vim.g.terminal_color_8 = "#585B70"

--  red
vim.g.terminal_color_1 = "#F38BA8"
vim.g.terminal_color_9 = "#F38BA8"

--  green
vim.g.terminal_color_2 = "#A6E3A1"
vim.g.terminal_color_10 = "#A6E3A1"

--  yellow
vim.g.terminal_color_3 = "#F9E2AF"
vim.g.terminal_color_11 = "#F9E2AF"

--  blue
vim.g.terminal_color_4 = "#89B4FA"
vim.g.terminal_color_12 = "#89B4FA"

--  magenta
vim.g.terminal_color_5 = "#F5C2E7"
vim.g.terminal_color_13 = "#F5C2E7"

--  cyan
vim.g.terminal_color_6 = "#94E2D5"
vim.g.terminal_color_14 = "#94E2D5"

--  white
vim.g.terminal_color_7 = "#BAC2DE"
vim.g.terminal_color_15 = "#A6ADC8"

-- Set makeprg for asm files to compile with as and ld
vim.api.nvim_create_autocmd("FileType", {
	pattern = "asm",
	command = [[setlocal makeprg=as\ --32\ -gstabs\ -o\ %:p:r.o\ %:p\ &&\ ld\ -m\ elf_i386\ -o\ %:p:r\ %:p:r.o]],
})

-- Set makeprg for c files to compile with gcc
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	command = [[setlocal makeprg=gcc\ -o\ %:p:r\ %:p\ -g\ -std=c99\ -W\ -Wall\ -lm]],
})

-- Set makeprg for c++ files to compile with g++
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	command = [[setlocal makeprg=g++\ -o\ %:p:r\ %:p\ -g\ -W\ -Wall\ -lm]],
})

-- Set colorcolumn for different filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rmd",
	command = [[ setlocal colorcolumn=73 ]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "r",
	command = [[ setlocal colorcolumn=73 ]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	command = [[ setlocal colorcolumn=91 ]],
})
