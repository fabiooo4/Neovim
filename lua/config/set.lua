vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

vim.opt.nu = true
vim.opt.relativenumber = true

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

-- Set makeprg for java files to compile with javac
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	command = [[setlocal makeprg=javac\ %:p\ ]],
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
