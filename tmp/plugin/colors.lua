function ApplyTheme(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
end

ApplyTheme()
