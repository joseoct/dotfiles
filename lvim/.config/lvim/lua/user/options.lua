lvim.colorscheme = "oxocarbon"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.illuminate.active = false
lvim.builtin.bufferline.active = true
lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.cmdline.enable = false
lvim.builtin.cmp.window.documentation = false
lvim.builtin.cmp.window.completion = {
  border = "rounded",
  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
}
lvim.builtin.which_key.setup.plugins.presets = {
  g = true,
  z = true
}
-- lvim.transparent_window = true

--{{{ Vim options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.timeoutlen = 500
vim.opt.termguicolors = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "getline(v:foldstart).'...'.trim(getline(v:foldend))"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 0
vim.opt.wrap = true
vim.opt.laststatus = 3
vim.opt.fillchars = {
  fold = " ", -- remove folding chars
}
vim.opt.foldnestmax = "3"
vim.opt.foldminlines = "1"
--}}}
