lvim.leader = "space"

-- Insert mode
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.insert_mode["<C-h>"] = "<ESC><cmd>lua require'luasnip'.jump(-1)<CR>"
lvim.keys.insert_mode["<C-l>"] = "<ESC><cmd>lua require'luasnip'.jump(1)<CR>"

-- Normal mode
lvim.keys.normal_mode["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- lvim.keys.normal_mode["<S-l>"] = "<cmd>lua require('harpoon.ui').nav_next()<CR>"
-- lvim.keys.normal_mode["<S-h>"] = "<cmd>lua require('harpoon.ui').nav_prev()<CR>"
lvim.keys.normal_mode["<F8>"] = [[yiw:%s/<C-r>"//g<Left><Left>]]
lvim.keys.normal_mode["<C-n>"] = "*``cgn"
lvim.keys.normal_mode["<C-.>"] = ":CodeActionMenu<CR>"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zzzH"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zzzH"

-- HACK: Nn and nN in the end to turn back n key to use in vim.on_key / zzzv to keep cursor in the middle
lvim.keys.normal_mode["n"] = "nzzzvNn"
lvim.keys.normal_mode["N"] = "NzzzvnN"

lvim.keys.normal_mode["<F1>"] = ":Calendar<CR>"
lvim.keys.normal_mode["<F2>"] = ":Calendar -view=week<CR>"

-- Visual mode
lvim.keys.visual_mode["<C-n>"] = [["sy:let @w='\<'.expand('<cword>').'\>' <bar> let @/=@s<CR>cgn]]
