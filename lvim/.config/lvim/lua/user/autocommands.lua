vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")

lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = "#f0f0f0" })
        vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = "#b39df3" })
        vim.api.nvim_set_hl(0, '@text', { fg = "#ffffff" })
      end,
    },
  },
}
