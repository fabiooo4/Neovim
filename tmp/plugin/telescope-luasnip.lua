require("telescope").load_extension("luasnip")

vim.keymap.set("n", "<leader>pt", ":Telescope luasnip<CR>")
