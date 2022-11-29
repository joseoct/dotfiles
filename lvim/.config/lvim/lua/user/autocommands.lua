vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    vim.cmd "hi NvimTreeFolderName guibg=none"
    vim.cmd "hi NvimTreeGitDirty guifg=#76cce0"
    vim.cmd "hi NvimTreeGitStaged guibg=#a7df78 guifg=#000000"
    vim.cmd "hi NvimTreeSpecialFile gui=bold,underline guifg=#d79921"
    vim.cmd "hi NvimTreeFolderName guifg=#b39df3"
    vim.cmd "hi NvimTreeOpenedFolderName guifg=#b39df3"
    vim.cmd "hi IndentBlanklineContextChar guifg=#b39df3"
    vim.cmd "hi @tag.delimiter guifg=#a9a9a9"
    vim.cmd "hi Keyword gui=italic"
    vim.cmd "hi @keyword.return gui=italic"
    vim.cmd "hi @tag.attribute.tsx gui=italic"
  end,
})
