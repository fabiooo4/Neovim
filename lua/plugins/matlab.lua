return {
  "marcusfschmidt/vim-matlab",
  build = ":UpdateRemotePlugins",
  init = function()
    -- Open matlab cli
    -- ~/.local/share/nvim/lazy/vim-matlab/scripts/vim-matlab-server.py <workspace directory>
    vim.g.matlab_auto_mappings = 1
    vim.g.matlab_window_id = 0 -- Suppress no vim terminal found error
  end,
}
