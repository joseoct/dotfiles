vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    vim.cmd "hi NvimTreeFolderName guibg=none"
    vim.cmd "hi NvimTreeGitDirty guifg=#76cce0"
    vim.cmd "hi NvimTreeGitStaged guibg=#a7df78"
    vim.cmd "hi NvimTreeSpecialFile gui=bold,underline guifg=#d79921"
    vim.cmd "hi NvimTreeFolderName guifg=#b39df3"
    vim.cmd "hi NvimTreeOpenedFolderName guifg=#b39df3"
  end,
})
