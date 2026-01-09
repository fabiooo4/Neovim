return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = true,
  opts = {
    -- Remove transparent mode if running neovide
    transparent_mode = not vim.g.neovide
  }
}
