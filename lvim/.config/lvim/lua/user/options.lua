lvim.colorscheme = "gruvbox"
-- vim.g.gruvbox_invert_selection = 0
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.alpha.active = true
lvim.builtin.illuminate.active = false
lvim.builtin.bufferline.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- lvim.builtin.breadcrumbs.active = true
-- lvim.builtin.treesitter.highlight.enabled = true
-- lvim.builtin.dap.active = true
lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.cmdline.enable = false
lvim.builtin.cmp.window.documentation = false
lvim.builtin.cmp.window.completion = {
  border = "rounded",
  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
}
-- lvim.builtin.cmp.formatting.source_names = {
--   nvim_lsp = "",
--   emoji = "",
--   path = "",
--   calc = "",
--   cmp_tabnine = "",
--   vsnip = "",
--   luasnip = "",
--   buffer = "",
--   tmux = "",
--   copilot = "",
--   treesitter = "",
-- }
-- -- vim.g.netrw_browse_split = 0
-- -- vim.g.netrw_banner = 0
-- -- vim.g.netrw_winsize = 25
-- vim.opt.showtabline = 0

local options = {
  -- backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  -- cmdheight = 0, -- more space in the neovim command line for displaying messages
  -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  -- conceallevel = 0, -- so that `` is visible in markdown files
  -- fileencoding = "utf-8", -- the encoding written to a file
  -- hlsearch = true, -- highlight all matches on previous search pattern
  -- ignorecase = true, -- ignore case in search patterns
  -- mouse = "a", -- allow the mouse to be used in neovim
  -- pumheight = 10, -- pop up menu height
  -- showmode = false, -- we don't need to see things like -- INSERT -- anymore
  -- showtabline = 0, -- always show tabs
  -- smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  -- splitbelow = true, -- force all horizontal splits to go below current window
  -- splitright = true, -- force all vertical splits to go to the right of current window
  -- swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  -- timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  -- undofile = true, -- enable persistent undo
  -- updatetime = 100, -- faster completion (4000ms default)
  -- writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  -- expandtab = true, -- convert tabs to spaces
  -- shiftwidth = 2, -- the number of spaces inserted for each indentation
  -- tabstop = 2, -- insert 2 spaces for a tab
  -- cursorline = true, -- highlight the current line
  -- number = true, -- set numbered lines
  -- laststatus = 3,
  -- showcmd = false,
  -- ruler = false,
  relativenumber = true, -- set relative numbered lines
  -- numberwidth = 4, -- set number column width to 2 {default 4}
  -- signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  -- wrap = false, -- display lines as one long line
  -- scrolloff = 0,
  -- sidescrolloff = 8,
  -- guifont = "monospace:h17", -- the font used in graphical neovim applications
  -- title = true,
  -- colorcolumn = "80",
  -- colorcolumn = "120",
}

-- extend some types
require('luasnip').filetype_extend("javascriptreact", { "html" })
require('luasnip').filetype_extend("typescriptreact", { "html" })

vim.g.gruvbox_invert_selection = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
  vim.opt[k] = v
end
