local theme = "gruvbox"
vim.cmd("colorscheme " .. theme)

-- Remove background color from number line
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- Remove fillchars from number line
vim.opt.fillchars = { eob = " " }

-- Disable background color from colorscheme
-- vim.cmd('highlight Normal guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE')
