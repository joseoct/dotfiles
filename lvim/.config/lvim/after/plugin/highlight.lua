vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { link = "Purple" })
vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { link = "Blue" })
vim.api.nvim_set_hl(0, 'NvimTreeGitStaged', { link = "Green", fg = "#000000" })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { link = "Red" })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { link = "Yellow" })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { link = "Green" })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { link = "Blue" })
vim.api.nvim_set_hl(0, '@keyword', { italic = true, fg = "#fb4934" }) -- gruvbox
vim.api.nvim_set_hl(0, '@tag.attribute', { italic = true })
-- vim.api.nvim_set_hl(0, '@keyword.return', { link = "Keyword" })
vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = "#a9a9a9" })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = "#b39df3" })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { underline = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { underline = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { underline = true })

-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--   callback = function()
--     vim.cmd "hi NvimTreeFolderName guibg=none"
--     vim.cmd "hi NvimTreeGitDirty guifg=#76cce0"
--     vim.cmd "hi NvimTreeGitStaged guibg=#a7df78 guifg=#000000"
--     vim.cmd "hi NvimTreeGitNew guifg=#b3ffb3"
--     vim.cmd "hi NvimTreeSpecialFile gui=bold,underline guifg=#d79921"
--     vim.cmd "hi NvimTreeFolderName guifg=#b39df3"
--     vim.cmd "hi NvimTreeOpenedFolderName guifg=#b39df3 gui=italic"
--     vim.cmd "hi IndentBlanklineContextChar guifg=#b39df3"
--     vim.cmd "hi @tag.delimiter guifg=#a9a9a9"
--     -- vim.cmd "hi @keyword gui=italic guifg=#fb617e" -- COLORSCHEME SONOKAI
--     -- vim.cmd "hi @keyword.return gui=italic guifg=#fb617e" -- COLORSCHEME SONOKAI
--     -- vim.cmd "hi @tag.attribute gui=italic guifg=#9ed06c" -- COLORSCHEME SONOKAI
--     vim.cmd "hi Identifier gui=italic" -- COLORSCHEME LUNAR (same as @tag.attribute)
--     -- vim.cmd "hi DiagnosticVirtualTextError guifg=#fb5170 guibg=#21222c" -- COLORSCHEME SONOKAI
--     vim.cmd "hi IlluminatedWordText gui=underline"
--     vim.cmd "hi IlluminatedWordRead gui=underline"
--     vim.cmd "hi IlluminatedWordWrite gui=underline"
--   end,
-- })
