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
require("awful.hotkeys_popup.keys")
local bindings = require("bindings")

local mywidgetlayout = require("mywidgetlayout")
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
editor = "lvim"
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

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
  { "open terminal", terminal }
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
  menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
clockdayanddate = wibox.widget.textclock("%A ✦ %d/%m/%y")
clocktime = wibox.widget.textclock("%H:%M")
-- mytextclock.font = "Recursive Bold 11"

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
    gears.wallpaper.maximized("/home/joseoctavio/Pictures/wp1.jpg", s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget

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
      shape_border_color = '#bb97ee',
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
              margins = 2,
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
        id     = 'background_role',
        widget = wibox.container.background,
      },
      margins = 3,
      widget  = wibox.container.margin
    },
  }

  s.mywibox = awful.wibar({ position = "bottom", screen = s, bg = "#181a1c", height = 30 })

  local separator = wibox.widget.textbox(" ")

  local new_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
  end

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    -- mywidgetlayout(maitasklist, "#94E2D5")
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- wibox.widget.systray(),
      mywidgetlayout(clockdayanddate, "#fb617e"),
      separator,
      mywidgetlayout(clocktime, "#9ed06c")
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function() mymainmenu:toggle() end)
-- awful.button({}, 4, awful.tag.viewnext),
-- awful.button({}, 5, awful.tag.viewprev)
))
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
    properties = { tag = "1", switchtotag = true }
  },
  {
    rule = { class = "Code" },
    properties = { tag = "1", switchtotag = true }
  },
  {
    rule = { class = "Google-chrome" },
    properties = { tag = "2", switchtotag = true }
  },
  {
    rule = { class = "firefox" },
    properties = { tag = "2", switchtotag = true }
  },
  {
    rule = { class = "discord" },
    properties = { tag = "3", switchtotag = true }
  },
  {
    rule = { class = "Mailspring" },
    properties = { tag = "4", screen = 1 }
  },
  {
    rule = { class = "mpv" },
    properties = { tag = "5", switchtotag = false }
  },
  {
    rule = { class = "streamlink-twitch-gui" },
    properties = { tag = "5", screen = 1 }
  },
  {
    rule = { class = "chatterino" },
    properties = { tag = "5", screen = 1 }
  },
  -- }}}


  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
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

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  -- awful.titlebar(c):setup {
  --   { -- Left
  --     awful.titlebar.widget.iconwidget(c),
  --     buttons = buttons,
  --     layout  = wibox.layout.fixed.horizontal
  --   },
  --   { -- Middle
  --     { -- Title
  --       align  = "center",
  --       widget = awful.titlebar.widget.titlewidget(c)
  --     },
  --     buttons = buttons,
  --     layout  = wibox.layout.flex.horizontal
  --   },
  --   { -- Right
  --     awful.titlebar.widget.floatingbutton(c),
  --     awful.titlebar.widget.maximizedbutton(c),
  --     awful.titlebar.widget.stickybutton(c),
  --     awful.titlebar.widget.ontopbutton(c),
  --     awful.titlebar.widget.closebutton(c),
  --     layout = wibox.layout.fixed.horizontal()
  --   },
  --   layout = wibox.layout.align.horizontal
  -- }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = "#fb617e" end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

beautiful.notification_icon_size = 120
beautiful.notification_border_width = 1
beautiful.notification_border_color = '#F38BA8'
beautiful.notification_bg = '#1E1E2E'

beautiful.tasklist_bg_focus = '#bb97ee'
beautiful.tasklist_bg_normal = '#181a1c'
beautiful.tasklist_fg_normal = '#bb97ee'
beautiful.tasklist_fg_focus = '#252630'
beautiful.tasklist_font = "Recursive Bold 10"

beautiful.taglist_bg_focus = '#6dcae8'
beautiful.taglist_fg_focus = '#252630'
beautiful.taglist_fg_occupied = '#bb97ee'
beautiful.taglist_fg_empty = '#ffffff'
beautiful.taglist_bg_urgent = '#fb617e'
beautiful.taglist_font = "Recursive Bold 10"
beautiful.taglist_squares_sel = "/home/joseoctavio/Pictures/bar-sel.png"
beautiful.taglist_squares_unsel = "/home/joseoctavio/Pictures/bar-sel.png"

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
run_once("picom") -- picom -b cause display freeze
run_once("imwheel -b '45'")
run_once("xset r rate 180 38")

-- run_once("easystroke")
-- run_once("flameshot")
-- run_once("optimus-manager-qt")
-- run_once("mailspring")
-- run_once("streamlink-twitch-gui")
