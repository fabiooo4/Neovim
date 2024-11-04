# 🖼️Preview

![Preview](/../assets/preview.png?raw=true "Preview")

🎨 **Color Schems**: 
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim)

# 💡 Features

- Plugin management with [Lazy](https://github.com/folke/lazy.nvim)
- File explorer with [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- Autocompletion with [Cmp](https://github.com/hrsh7th/nvim-cmp)
- AI code generation with [Copilot](https://github.com/github/copilot.vim)
- Project-wide fuzzy finding with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- Syntax highlighting with [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Open multiple tabs with [Barbar](https://github.com/romgrk/barbar.nvim)
- Faster matching pair insertion with [Autopairs](https://github.com/windwp/nvim-autopairs)
- Tab out of parenthesis with [Tabout](https://github.com/abecodes/tabout.nvim)
- Colored brackets with [Rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim)
- Formatting and Linting with [None-ls](https://github.com/nvimtools/none-ls.nvim)
- Language Server Protocol with [Mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
- LaTeX writing and previewing via [Vimtex](https://github.com/lervag/vimtex#snippets-and-templates) and [sioyek](https://sioyek.info/)
- Custom status line via [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- Battery status via [Battery.nvim](https://github.com/justinhj/battery.nvim)
- Image viewing with [Image.nvim](https://github.com/3rd/image.nvim) (Requires [Kitty](https://sw.kovidgoyal.net/kitty/))
- Custom snippets via [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- Smooth scrolling with [Neoscroll](https://github.com/karb94/neoscroll.nvim)
- Fast commenting with [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- Better web styling with [Tailwind-tools](https://github.com/luckasRanarison/tailwind-tools.nvim)
- Undo list with [UndoTree](https://github.com/mbbill/undotree)
- Enhanced navigation with [Flash](https://github.com/folke/flash.nvim)
- Fast parenthesis surrounding with [mini.surround](https://github.com/echasnovski/mini.surround)

# 🛠️ Requirements

- [Neovim 0.10+](https://github.com/neovim/neovim/releases/tag/stable)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) (Optional)
- A clipboard manager like [xclip](https://github.com/astrand/xclip) for system clipboard integration. (see [:help clipboard-tool](https://neovim.io/doc/user/provider.html#clipboard-tool))

# 📦 Installation

Clone this repository into your `~/.config/nvim` directory.

```bash
git clone https://github.com/fabiooo4/Neovim.git ~/.config/nvim
```

Open Neovim and Lazy will automatically install all the plugins. After installing all the plugins, you can restart Neovim and you are good to go.

# 📝 Configuration

You can configure the basic configuration files like vim remaps, sets, and Lazy in the [lua/config](./lua/config) directory.

To configure the plugins, you can edit the existing files in the [lua/plugins](./lua/plugins) directory or create a new file for the plugin you want to
configure. The basic configuration for each plugin must be a return table with the configuration options, like this:

```lua
return {
    "short-plugin/name",
    config = function()
        -- Your configuration here
    end
}
```

To install the LSP servers, you can run the following command:

```lua
:Mason
```

and select the language server you want to install. You then have to add the configuration for the language server in the [lua/plugins/lsp.lua](./lua/plugins/lsp.lua) file.

With Mason you can also install formatters and linters. You then have to add the configuration for the formatter and linter in the [lua/plugins/none-ls.lua](./lua/plugins/none-ls.lua) file.
