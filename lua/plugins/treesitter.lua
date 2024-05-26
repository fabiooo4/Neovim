return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "javascript",
        "html",
        "css",
        "asm",
        "bash",
        "rust",
        "latex",
        "markdown"
      },
      highlight = { enable = true },
      indent = { enable = true },  
    })
  end
}
