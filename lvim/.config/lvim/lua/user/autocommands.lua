vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    vim.cmd "hi NvimTreeFolderName guibg=none"
    vim.cmd "hi NvimTreeGitDirty guifg=#76cce0"
    vim.cmd "hi NvimTreeGitStaged guibg=#a7df78 guifg=#000000"
    vim.cmd "hi NvimTreeGitNew guifg=#b3ffb3"
    vim.cmd "hi NvimTreeSpecialFile gui=bold,underline guifg=#d79921"
    vim.cmd "hi NvimTreeFolderName guifg=#b39df3"
    vim.cmd "hi NvimTreeOpenedFolderName guifg=#b39df3 gui=italic"
    vim.cmd "hi IndentBlanklineContextChar guifg=#b39df3"
    vim.cmd "hi @tag.delimiter guifg=#a9a9a9"
    vim.cmd "hi @keyword gui=italic guifg=#fb617e" -- COLORSCHEME SONOKAI
    vim.cmd "hi @keyword.return gui=italic guifg=#fb617e" -- COLORSCHEME SONOKAI
    vim.cmd "hi IlluminatedWordText gui=underline"
    vim.cmd "hi IlluminatedWordRead gui=underline"
    vim.cmd "hi IlluminatedWordWrite gui=underline"
  end,
})

-- HACK: Remove highlight after pressing any key other than * / ? n N <CR> #
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    vim.opt.hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")
