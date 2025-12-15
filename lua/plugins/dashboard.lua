return {
--[[ 	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = function(_, opts)
		opts.preview = opts.preview or {}

		-- Check if the user has lolcat installed
		if vim.fn.executable("lolcat") == 0 then
			opts.preview.command = "tail -z"
		else
			if vim.fn.has("mac") == 1 then
        opts.preview.command = "lolcat -a -d 1"
			else
        opts.preview.command = "lolcat -x -v 1 -h 0 -o 17"
			end
		end

		opts.preview.file_path = "~/.config/nvim/lua/plugins/dashboard.txt"
		opts.preview.file_width = 69
		opts.preview.file_height = 17

		opts.theme = "hyper"
		opts.config = {
			shortcut = {
				{ desc = "󰊳 Update Plugins ", group = "WarningMsg", action = "Lazy update", key = "u" },
				{ desc = " Update LSPs ", group = "DashboardShortCut", action = "MasonUpdate", key = "m" },
				{ desc = " New File ", group = "Number", action = "enew", key = "n" },
				{ desc = " Files ", group = "DiagnosticInfo", action = "Neotree", key = "<leader>e" },
				{
					desc = " Quit ",
					group = "DiagnosticHint",
					action = function()
						vim.api.nvim_input("<cmd>qa<cr>")
					end,
					key = "q",
				},
			},
			packages = { enable = false },
			project = {
				enable = true,
				limit = 4,
				icon = "󰏓 ",
				label = "Recent projects",
				action = "Telescope find_files cwd=",
			},
			mru = { enable = true, limit = 4, icon = " ", label = "Recent files", cwd_only = false },
			footer = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return { "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
			end,
		}
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } }, ]]
}
