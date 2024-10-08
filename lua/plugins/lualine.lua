return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local function nvimbattery()
			return require("battery").get_status_line()
		end

		require("lualine").setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 4,
					},
				},
				lualine_x = {
					{
						"datetime",
						style = "%H:%M",
					},
					nvimbattery
				},
				lualine_y = { "filetype" },
				lualine_z = { "progress", "location" },
			},

			extensions = {
				"neo-tree",
			},
		})
	end,
}
