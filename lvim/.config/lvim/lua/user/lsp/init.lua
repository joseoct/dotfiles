-- require "user.lsp.languages.rust"
-- require "user.lsp.languages.go"
require "user.lsp.languages.python"
require "user.lsp.languages.js-ts"
-- require "user.lsp.languages.sh"

-- if you don't want all the parsers change this to a table of the ones you want
-- lvim.builtin.treesitter.ensure_installed = {
--   "java",
-- }

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

require("lvim.lsp.manager").setup("angularls")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettierd", filetypes = { "json", "css", "scss", "html", "yaml", "markdown" } },
}

lvim.lang.html.lsp.setup = {
  cmd = { "vscode-html-languageserver", "--stdio" },
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
  },
  root_dir = function(fname)
    return lvim.lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end,
}

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "jsonlint", filetypes = { "json" } },
-- }
