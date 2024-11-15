return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			-- make a group to be able to delete it later
			group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
			callback = function()
				local f = vim.fn.expand("%:p")
				if vim.fn.isdirectory(f) ~= 0 then
					vim.cmd("Neotree current dir=" .. f)
					-- neo-tree is loaded now, delete the init autocmd
					vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
				end
			end,
		})
		-- keymaps
		vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle right<CR>", {})
	end,
	opts = {},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				hijack_netrw_behavior = "open_current",
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_by_name = {
						'.git',
						-- '.DS_Store',
						-- 'thumbs.db',
					},
					never_show = {},
				},
			},
			window = {
				position = "current",
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
				},
			},
		})
	end,
}
