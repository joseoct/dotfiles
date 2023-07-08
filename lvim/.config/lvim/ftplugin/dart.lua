local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  C = {
    name = "Flutter",
    R = { "<cmd>FlutterRun<cr>", "Run" },
    r = { "<cmd>FlutterRestart<cr>", "Restart" },
    e = { "<cmd>FlutterEmulators<cr>", "Emulators" },
    q = { "<cmd>FlutterQuit<cr>", "Quit" },
    o = { "<cmd>FlutterOutlineToggle<cr>", "Outline" },
    l = { "<cmd>FlutterLspRestart<cr>", "Restart LSP" },
  },
}

which_key.register(mappings, opts)
