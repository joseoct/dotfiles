reload "user.plugins"
reload "user.keymaps"
reload "user.options"
reload "user.whichkey"
reload "user.leap"
reload "user.lualine"
reload "user.treesitter"
reload "user.copilot"
reload "user.autocommands"
reload "user.gitsigns"
reload "user.cmd"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- {
  --   command = "prettier",
  --   extra_args = { "--print-width", "100" },
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
  -- {
  --   command = "eslint_d",
  --   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  -- }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
}
