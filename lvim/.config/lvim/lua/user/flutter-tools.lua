local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutter_tools.setup {
  debugger = {
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    exception_breakpoints = {},
    register_configurations = function(paths)
      require("dap").configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch flutter",
          dartSdkPath = paths.dart_sdk,
          flutterSdkPath = paths.flutter_sdk,
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    },
  },
  fvm = true,
  widget_guides = {
    enabled = false,
    debug = false,
  },
  dev_log = {
    enabled = false,
  },
  dev_tools = {
    autostart = false,         -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    auto_open = false, -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    on_attach = require("lvim.lsp").common_on_attach,
    capabilities = require("lvim.lsp").common_capabilities,
    color = {
      -- show the derived colours for dart variables
      enabled = false,        -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false,     -- highlight the background
      foreground = false,     -- highlight the foreground
      virtual_text = true,    -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    settings = {
      showTodos = true,
      renameFilesWithClasses = 'prompt',
    },
  },
}
