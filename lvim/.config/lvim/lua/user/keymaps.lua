lvim.leader = "space"

-- Insert mode
lvim.keys.insert_mode["jk"] = "<ESC>"

-- Normal mode
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
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
