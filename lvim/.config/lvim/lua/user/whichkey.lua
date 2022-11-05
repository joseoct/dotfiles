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