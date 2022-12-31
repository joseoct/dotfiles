-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

-- USER {{{
require("awful.hotkeys_popup.keys")
local bindings = require("bindings")
local brightness_widget = require("widgets.brightness")
local volume_widget = require("widgets.volume")
local clock_widget = require("widgets.clock")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,}
}
-- }}}

-- Create a textclock widget
clockdate = wibox.widget.textclock("%A %d/%m/%y")
clocktime = wibox.widget.textclock("%H:%M")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 2, function(c)
    c:kill()
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized("/home/joseoctavio/Pictures/wp3.png", s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "dev", "web", "chat", "mail", "files" }, s, awful.layout.layouts[1])

  local new_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
  end

  s.mytaglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    buttons         = taglist_buttons,
    style           = {
      shape = new_shape
    },
    widget_template =
    {
      {
        {
          {
            {
              id     = 'text_role',
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
          },
          left   = 7,
          right  = 7,
          widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
      },
      margins = 3,
      widget  = wibox.container.margin
    },
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = tasklist_buttons,
    style           = {
      shape_border_width = 1,
      -- shape_border_color = '#89DCEB',
      shape              = new_shape
    },
    widget_template =
    {
      {
        {
          {
            {
              {
                id     = 'icon_role',
                widget = wibox.widget.imagebox,
              },
              margins = 4,
              widget  = wibox.container.margin,
            },
            {
              id     = 'text_role',
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
          },
          left   = 7,
          right  = 7,
          widget = wibox.container.margin
        },
        id = 'background_role',
        forced_width = 260,
        widget = wibox.container.background,
      },
      margins = 3,
      widget  = wibox.container.margin
    },
  }

  s.mywibox = awful.wibar({ position = "bottom", screen = s, bg = "#1E1E2E", height = 30 })


  local new_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
  end

  -- for screen_name, _ in pairs(s.outputs) do
  --   if screen_name == "DP-0" then
  --     s.mywibox:setup {
  --       layout = wibox.layout.align.horizontal,
  --       s.mytaglist,
  --       s.mytasklist,
  --     }
  --   end
  -- end
  --
  local separator = wibox.widget.textbox("      ")

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      separator,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      separator,
      layout = wibox.layout.fixed.horizontal,
      -- wibox.widget.systray(),
      brightness_widget("#A6E3A1"),
      volume_widget("#f9e2af"),
      clock_widget(clockdate, "/home/joseoctavio/.config/awesome/widgets/icons/calendar.svg", "#F38BA8"),
      clock_widget(clocktime, "/home/joseoctavio/.config/awesome/widgets/icons/time.svg", "#CBA6F7"),
    },
  }
end)
-- }}}

-- Key bindings
root.keys(bindings.globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = bindings.clientkeys,
      buttons = bindings.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"
    },



    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester", -- xev.
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "ConfigManager", -- Thunderbird's about:config.
      "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true } },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" }
  }, properties = { titlebars_enabled = true }
  },

  -- {{{ My rules
  {
    rule = { class = "Alacritty" },
    properties = { tag = "dev", switchtotag = true }
  },
  {
    rule = { class = "Code" },
    properties = { tag = "dev", switchtotag = true }
  },
  {
    rule = { class = "Google-chrome" },
    properties = { tag = "web", switchtotag = true }
  },
  {
    rule = { class = "firefox" },
    properties = { tag = "web", switchtotag = true }
  },
  {
    rule = { class = "discord" },
    properties = { tag = "chat", switchtotag = true }
  },
  {
    rule = { class = "Mailspring" },
    properties = { tag = "mail", screen = 1 }
  },
  {
    rule = { class = "Evolution" },
    properties = { tag = "mail", screen = 1 }
  },
  {
    rule = { class = "Thunar" },
    properties = { tag = "files", screen = 1, switchtotag = true }
  },
  {
    rule = { class = "mpv" },
    properties = { tag = "files", switchtotag = false }
  },
  {
    rule = { class = "streamlink-twitch-gui" },
    properties = { tag = "files", screen = 1 }
  },
  {
    rule = { class = "chatterino" },
    properties = { tag = "files", screen = 1 }
  },
  -- }}}
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = "#65659a" end)
client.connect_signal("unfocus", function(c) c.border_color = "#1e1e2e" end)
-- }}}

beautiful.notification_icon_size = 120
beautiful.notification_border_width = 1
beautiful.notification_border_color = '#F38BA8'
beautiful.notification_bg = '#1E1E2E'

beautiful.tasklist_bg_focus = '#47476c'
beautiful.tasklist_fg_focus = '#c1c1d7'
beautiful.tasklist_bg_normal = '#1E1E2E'
beautiful.tasklist_fg_normal = '#47476c'
beautiful.tasklist_bg_minimize = '#d1d1e1'
beautiful.tasklist_fg_minimize = '#47476c'
beautiful.tasklist_shape_border_color_focus = '#47476c'
beautiful.tasklist_shape_border_color = '#47476c'
beautiful.tasklist_font = "Recursive Bold 10"

beautiful.taglist_bg_focus = '#B4BEFE'
beautiful.taglist_fg_focus = '#1E1E2E'
beautiful.taglist_fg_occupied = '#F5C2E7'
beautiful.taglist_bg_occupied = '#28283e'
beautiful.taglist_fg_empty = '#ffffff'
beautiful.taglist_bg_urgent = '#F38BA8'
beautiful.taglist_font = "Recursive Bold 10"
beautiful.taglist_squares_sel = "/home/joseoctavio/.config/awesome/bar.png"
beautiful.taglist_squares_unsel = "/home/joseoctavio/.config/awesome/bar.png"

local function run_once(command)
  local args_start = string.find(command, " ")
  local pgrep_name = args_start and command:sub(0, args_start - 1) or command

  local command = "pgrep -u $USER -x " .. pgrep_name .. " > /dev/null || (" .. command .. ")"

  awful.spawn.easy_async_with_shell(
    command,
    function(stdout, stderr, exitreason, exitcode)
      if exitcode ~= 0 then
        naughty.notify({
          preset = naughty.config.presets.critical,
          text   = string.format("%s\n\n%s\n%s\n%s\n%s",
            command,
            stdout,
            stderr,
            exitreason,
            exitcode)
        })
      end
    end)
end

run_once("xrandr --output DP-0 --rate 144.00 --primary --mode 1920x1080 --pos 1280x0 --rotate normal --output DP-1 --off --output eDP-1-1 --rate 60.02 --mode 1280x720 --pos 0x360 --rotate normal --output DP-1-1 --off --output HDMi-1-1 --off --output HDMI-1-2 --off")
-- run_once("sleep 1s && nitrogen --restore")
run_once("picom &") -- picom -b cause display freeze
run_once("imwheel -b '45'")
run_once("xset r rate 180 38")
run_once("evolution")

-- run_once("easystroke")
-- run_once("flameshot")
-- run_once("optimus-manager-qt")
-- run_once("mailspring")
-- run_once("streamlink-twitch-gui")
