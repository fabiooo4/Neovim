-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope (fuzzy finder)
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Colorschemes
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Treesitter (syntax highlighting)
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- Harpoon (quickly jump between files)
    use('ThePrimeagen/harpoon')

    -- UndoTree (visualize undo history)
    use('mbbill/undotree')

    -- Fugitive (Git wrapper)
    use('tpope/vim-fugitive')

    -- Copilot
    use('github/copilot.vim')

    -- Neorg (org-mode)
    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    }

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required

            -- LSP UI
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    -- NvimTree (file explorer)
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- ToggleTerm (terminal)
    use {
        "akinsho/toggleterm.nvim", tag = '*'
    }

    -- Barbar (tabline)
    use 'romgrk/barbar.nvim'

    -- DevIcons (icons)
    use 'nvim-tree/nvim-web-devicons'
end)