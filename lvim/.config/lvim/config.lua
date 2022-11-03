lvim.colorscheme = "gruvbox"
vim.g.gruvbox_invert_selection = 0

vim.g.sonokai_style = "andromeda"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.builtin.cmp.confirm_opts.select = true

lvim.leader = "space"
lvim.builtin.telescope.defaults.file_ignore_patterns = { "node_modules" }
vim.opt.relativenumber = true

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- which key
lvim.builtin.which_key.mappings["a"] = {
  name = "+Harpoon",
  a = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Add mark" },
  m = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "View marks" },
  ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Go to previous mark" },
  [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Go to next mark" },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings["w"] = {
  name = "+Windows split",
  ["j"] = { "<C-w>s", "Split" },
  ["l"] = { "<C-w>v", "VSplit" },
}

lvim.builtin.which_key.mappings["<leader>"] = {
  ":w<cr>", "Save"
}

lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- indent-blank sera que abro uma issue?
lvim.builtin.indentlines = {
  active = true,
  on_config_done = nil,
  options = {
    enabled = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "text",
    },
    char = lvim.icons.ui.LineLeft,
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = false,
    show_current_context = true,
  },
}

-- lualine config
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }

-- How to import anothers config files
-- vim.cmd('source ~/.config/lvim/lua/user/lualine.lua')

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- {
  -- PRETTIER -> DETECTA O TIPO DE CONFIGURAÇÃO DO ARQUIVO E FORMATA
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettier",
  --   --........arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-width", "100" },
  --   -- -speci.............fy which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = {
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --     "html",
  --     "json",
  --     "tsx",
  --     "jsx",
  --     "css",
  --   },
  --   condition = function(utils)
  --     vim.g.formatting_enabled = utils.root_has_file({
  --       ".prettierrc.json",
  --       ".prettierrc.js",
  --       "prettier.config.js",
  --       ".prettierrc",
  --     })
  --     return true
  --   end,
  --   prefer_local = "node_modules/.bin",
  -- },
  -- ISSO DAQUI EQUIVALE AO --FIX
  -- {
  --   command = "eslint_d",
  --   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  -- }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
}

lvim.plugins = {
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
  -- { "justinmk/vim-sneak" },
  { "github/copilot.vim" },
  { "tpope/vim-surround" },
  { "ThePrimeagen/harpoon" },
  { "p00f/nvim-ts-rainbow" },
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
  -- themes
  { "getomni/neovim" },
  { "gruvbox-community/gruvbox" },
}

-- Setup to html works on jsx, tsx files
require('luasnip').filetype_extend("javascriptreact", { "html" })
require('luasnip').filetype_extend("typescriptreact", { "html" })

-- Setup copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_node_command = "/usr/local/n/versions/node/16.15.0/bin/node"

local cmp = require "cmp"

lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end
