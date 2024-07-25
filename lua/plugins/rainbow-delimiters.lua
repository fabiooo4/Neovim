return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    require('rainbow-delimiters.setup').setup({
      highlight = {
        'RainbowDelimiterCyan',
        'RainbowDelimiterViolet',
        'RainbowDelimiterOrange',
        'RainbowDelimiterBlue',
        'RainbowDelimiterYellow',
        'RainbowDelimiterGreen',
        'RainbowDelimiterRed',
      },
    });
  end,
}
