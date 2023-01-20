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

require 'nvim-web-devicons'.set_icon({
  ["ts"] = {
    icon = "ﯤ",
    color = "#4db8ff",
    name = "TypeScript"
  },
  ["js"] = {
    icon = "",
    color = "#f7df1e",
    name = "JavaScript"
  },
  [".prettierrc"] = {
    icon = "",
    color = "#ff8c00",
    name = "prettier",
  },
  [".eslintrc.js"] = {
    icon = "ﯶ",
    color = "#4db8ff",
    name = "eslint",
  },
})
