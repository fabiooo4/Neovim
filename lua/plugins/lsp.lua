return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- LSP
          "clangd",
          "rust_analyzer",
          "lua_ls",
          "html",
          "cssls",
          "jsonls",
          "marksman",
          "r_language_server",
          "tsserver",
          "ltex",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- setup lsp
      lspconfig.clangd.setup({})
      lspconfig.rust_analyzer.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.marksman.setup({})
      lspconfig.r_language_server.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.ltex.setup({})

      -- keybinds
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
