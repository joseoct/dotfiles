reload "user.options"
reload "user.plugins"
reload "user.whichkey"
reload "user.leap"
reload "user.lualine"
reload "user.treesitter"
reload "user.copilot"
reload "user.autocommands"
reload "user.gitsigns"
reload "user.cmd"
reload "user.lsp"
reload "user.keymaps"
reload "user.todo-comments"
reload "user.cmp"

local banner = require "user.banners"

lvim.builtin.alpha.dashboard.section.header = {
  val = banner.dashboard(),
}
