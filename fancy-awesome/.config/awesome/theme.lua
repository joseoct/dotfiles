--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local spotify_widget     = require("awesome-wm-widgets.spotify-widget.spotify")
local brightness_widget  = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget      = require("awesome-wm-widgets.volume-widget.volume")
local calendar_widget    = require("awesome-wm-widgets.calendar-widget.calendar")
local fs_widget          = require("awesome-wm-widgets.fs-widget.fs-widget")
local todo_widget        = require("awesome-wm-widgets.todo-widget.todo")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/"
theme.wallpaper                                 = theme.confdir .. "/wall.png"
theme.font                                      = "JetBrainsMono Medium 10"
theme.taglist_font                              = "JetBrainsMono Medium 10"
theme.menu_bg_normal                            = "#000000"
-- bg = {
--   type = "linear",
--   from = { 0, 0, 0 },
--   to = { 1920, 55, 30 },
--   stops = { { 0, "#130634" }, { 0.5, "#ce0055" }, { 1, "#8d0060" } }
-- },
theme.bg_normal                                 = "#00000000"
theme.bg_focus                                  = "#00000000"
theme.bg_urgent                                 = "#00000000"
theme.bg_systray                                = "#001818AA"
theme.fg_normal                                 = "#ffffff"
theme.fg_focus                                  = "#cba5f7"
theme.fg_urgent                                 = "#ed8796"
theme.fg_minimize                               = "#aaaaaa"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#cba5f7"
theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 0
theme.menu_width                                = dpi(130)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ed8796"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.widget_temp                               = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.png"
theme.widget_note                               = theme.confdir .. "/icons/note.png"
theme.widget_note_on                            = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.png"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 0
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

local markup = lain.util.markup

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)

local mytextclock = wibox.widget.textclock(markup("#94E2D5", "%A %d/%m/%y ") ..
  markup("#b8c0e0", "???") .. markup("#f9e2af", " %H:%M "))
mytextclock.font = "JetBrainsMono medium 10"

local cw = calendar_widget({
  theme = 'outrun',
  start_sunday = true,
})

mytextclock:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then cw.toggle() end
  end)

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
  APPID = "2b20bb39693fb81dc14d36fbbd626180",
  city_id = 3461763, -- placeholder (London)
  notification_preset = { font = "Roboto regular 10", fg = theme.fg_normal },
  weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
  settings = function()
    descr = weather_now["weather"][1]["description"]:lower()
    units = math.floor(weather_now["main"]["temp"])
    widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "??C "))
  end
})

-- / fs
--[[ commented because it needs Gio/Glib >= 2.54
local fsicon = wibox.widget.imagebox(theme.widget_fs)
theme.fs = lain.widget.fs({
  partition = "/",
  notification_preset = { font = "Roboto Medium 10", fg = theme.fg_normal },
  settings            = function()
    widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
  end
})


-- Mail IMAP check
--[[ to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#89b4fa", cpu_now.usage .. "% "))
  end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#f5c2e7", coretemp_now .. "??C "))
  end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
  settings = function()
    local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

    if bat_now.ac_status == 1 then
      perc = perc .. " plug"
    end

    widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
  end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
  settings = function()
    if volume_now.status == "off" then
      volume_now.level = volume_now.level .. "M"
    end

    widget:set_markup(markup.fontfg(theme.font, "#8aadf4", volume_now.level .. "% "))
  end
})

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
  settings = function()
    if iface ~= "network off" and
        string.match(theme.weather.widget.text, "N/A")
    then
      theme.weather.update()
    end

    widget:set_markup(markup.fontfg(theme.font, "#ed8796", net_now.sent .. " "))
    netdowninfo:set_markup(markup.fontfg(theme.font, "#a6da95", net_now.received .. " "))
  end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#F9E2AF", mem_now.used .. "M "))
  end
})

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
  settings = function()
    mpd_notification_preset = {
      text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
        mpd_now.album, mpd_now.date, mpd_now.title)
    }

    if mpd_now.state == "play" then
      artist = mpd_now.artist .. " > "
      title  = mpd_now.title .. " "
      mpdicon:set_image(theme.widget_note_on)
    elseif mpd_now.state == "pause" then
      artist = "mpd "
      title  = "paused "
    else
      artist                 = ""
      title                  = ""
      --mpdicon:set_image() -- not working in 4.0
      mpdicon._private.image = nil
      mpdicon:emit_signal("widget::redraw_needed")
      mpdicon:emit_signal("widget::layout_changed")
    end
    widget:set_markup(markup.fontfg(theme.font, "#e54c62", artist) .. markup.fontfg(theme.font, "#b2b2b2", title))
  end
})

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({ app = awful.util.terminal })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(my_table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(19), bg = theme.bg_normal, fg = theme.fg_normal })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      -- s.mylayoutbox,
      s.mytaglist,
      s.mypromptbox,
      mpdicon,
      theme.mpd.widget,
      wibox.widget.textbox("     "),
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
    --s.mytasklist, -- Middle widget

    -- awful.titlebar.widget.iconwidget(c),
    mytextclock,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      --mailicon,
      --theme.mail.widget,
      theme.weather.icon,
      wibox.widget.textbox(" "),
      theme.weather.widget,
      netdownicon,
      netdowninfo,
      netupicon,
      netupinfo.widget,
      -- volicon,
      -- theme.volume.widget,
      memicon,
      memory.widget,
      cpuicon,
      cpu.widget,
      --fsicon,
      --theme.fs.widget,
      -- tempicon,
      -- temp.widget,
      baticon,
      bat.widget,
      todo_widget(),
      fs_widget({ mounts = { '/' } }),
      wibox.widget.textbox(" "),
      brightness_widget {
        type = 'arc',
        program = 'light',
        step = 5,
        timeout = 1,
      },
      wibox.widget.textbox(" "),
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
        font = 'Roboto medium 10',
        onlock = function() awful.spawn.with_shell('~/.config/i3/scripts/blur-lock') end
      },
      wibox.widget.textbox("  "),
    },
  }

  -- Create the bottom wibox
  s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20),
    bg = theme.bg_normal, fg = theme.fg_normal })

  -- Add widgets to the bottom wibox
  s.mybottomwibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
    },
  }
end

return theme
