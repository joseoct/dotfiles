local ok, flutter_tools = pcall(require, "flutter-tools")
if not ok then
  return
end

flutter_tools.setup {
  closing_tags = {
    enabled = false,
  },
  widget_guides = {
    enabled = true,
  },
  dev_log = {
    open_cmd = "tabedit",
  },
  outline = {
    open_cmd = "30vnew",
  },
  lsp = {
    color = {
      -- show the derived colours for dart variables
      enabled = true,        -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = true,     -- highlight the background
      background_color = nil,
      foreground = false,    -- highlight the foreground
      virtual_text_str = "", -- the virtual text character to highlight
    },
  }
}
