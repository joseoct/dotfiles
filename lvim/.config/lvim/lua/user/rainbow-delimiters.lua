local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    commonlisp = rainbow_delimiters.strategy['local'],
    html = nil
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterBlue',
    -- 'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
    -- 'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
  },
}
