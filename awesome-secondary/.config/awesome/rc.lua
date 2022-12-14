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

-- My Widgets
local fs_widget          = require("awesome-wm-widgets.fs-widget.fs-widget")
local spotify_widget     = require("awesome-wm-widgets.spotify-widget.spotify")
local volume_widget      = require("awesome-wm-widgets.volume-widget.volume")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local brightness_widget  = require("awesome-wm-widgets.brightness-widget.brightness")
local batteryarc_widget  = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local bindings = require("bindings")

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
editor = os.getenv("EDITOR") or "lvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
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
  -- awful.layout.suit.corner.se,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock('%d/%m/%y ??? %H:%M')
mytextclock.font = "JetBrainsMono medium 9"

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
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- No borders when client is maximized
screen.connect_signal("arrange", function(s)
  local only_one = #s.tiled_clients == 1
  for _, c in pairs(s.clients) do
    if c.maximized or c.fullscreen then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)


awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "dev", "web", "chat", "mail", "ttv", "games" }, s, awful.layout.layouts[1])

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
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }
  beautiful.taglist_font = "JetBrainsMono medium 9"

  beautiful.systray_icon_spacing = 2

  local my_round_systray = wibox.widget {
    {
      wibox.widget.systray(),
      top    = 3,
      bottom = 3,
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = tasklist_buttons,
    style           = {
      shape = gears.shape.rounded_bar,
    },
    layout          = {
      spacing = 10,
      layout  = wibox.layout.flex.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
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
        left   = 10,
        right  = 10,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  }
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "bottom", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      wibox.widget.textbox("     "),
      spotify_widget({
        play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
        pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
        dim_when_paused = true,
        dim_opacity = 0.5,
        max_length = -1,
        show_tooltip = false,
      }),

    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      my_round_systray,
      wibox.widget.textbox("   "),
      mytextclock,
      wibox.widget.textbox("   "),
      fs_widget({ mounts = { '/' } }),
      wibox.widget.textbox("   "),
      batteryarc_widget({
        show_current_level = false,
        arc_thickness = 2,
      }),
      wibox.widget.textbox("  "),
      brightness_widget {
        type = 'arc',
        program = 'light',
        step = 5,
        timeout = 1,
      },
      wibox.widget.textbox("  "),
      volume_widget {
        mixer_cmd = 'pavucontrol',
        widget_type = 'arc',
        main_color = '#8BD5CA',
        bg_color = '#1e252c',
        mute_color = '#e54c62',
        size = 20,
      },
      wibox.widget.textbox("  "),
      logout_menu_widget {
        font = 'JetBrainsMono medium 9',
        onlock = function() awful.spawn.with_shell('~/.config/i3/scripts/blur-lock') end
      },
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
-- root.buttons(gears.table.join(
--   awful.button({}, 3, function() mymainmenu:toggle() end),
--   awful.button({}, 4, awful.tag.viewnext),
--   awful.button({}, 5, awful.tag.viewprev)
-- ))
-- }}}

root.keys(bindings.globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = 1,
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

  -- My rules
  {
    rule = { class = "mpv" },
    properties = { tag = "ttv", switchtotag = false }
  },
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
    properties = { tag = "web" }
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
    rule = { class = "streamlink-twitch-gui" },
    properties = { tag = "ttv", screen = 1 }
  },
  {
    rule = { class = "chatterino" },
    properties = { tag = "ttv", screen = 1 }
  },


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
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = "#cba5f7" end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--beautiful.useless_gap = 3
beautiful.notification_icon_size = 120
beautiful.notification_border_width = 1
beautiful.notification_border_color = '#F38BA8'
beautiful.notification_bg = '#1E1E2E'
beautiful.bg_minimize = '#00000000'
beautiful.bg_urgent = '#F38BA8'
beautiful.fg_urgent = '#000000'
beautiful.bg_normal = '#362b42'
beautiful.bg_focus = '#cba5f7'
beautiful.fg_focus = '#000000'

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

run_once("xrandr --output DP-0 --rate 144.00 --primary --mode 1920x1080 --pos 1280x0 --rotate normal --output DP-1 --off --output eDP-1-1 --rate 60.02 --mode 1280x720 --pos 0x360 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off --output HDMI-1-2 --off")
run_once("sleep 1s && nitrogen --restore")
run_once("picom")
run_once("imwheel -b '45'")
run_once("xset r rate 180 38")

run_once("easystroke")
run_once("flameshot")
run_once("optimus-manager-qt")
run_once("mailspring")
run_once("streamlink-twitch-gui")
