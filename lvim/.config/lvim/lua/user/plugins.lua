lvim.plugins = {
  -- {{{ Themes
  { "sainnhe/gruvbox-material" },
  { "sainnhe/sonokai" },
  { "catppuccin/nvim", as = "catppuccin" },
  -- }}}
  { "svban/YankAssassin.vim" },
  { "pantharshit00/vim-prisma" },
  { "mxsdev/nvim-dap-vscode-js" },
  { "nvim-treesitter/playground" },
  { "github/copilot.vim" },
  { "tpope/vim-surround" },
  { "ThePrimeagen/harpoon" },
  { "p00f/nvim-ts-rainbow" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({})
    end,
  },
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
        },
      })
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
      vim.keymap.del({ 'x', 'o' }, 'x')
    end
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "typescript", "lua" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
}
