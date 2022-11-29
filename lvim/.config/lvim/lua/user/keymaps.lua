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
-- lvim.keys.normal_mode["*"] = "*N"

-- Visual mode
lvim.keys.visual_mode["<C-n>"] = [["sy:let @w='\<'.expand('<cword>').'\>' <bar> let @/=@s<CR>cgn]]
