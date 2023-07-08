-------------------------------------------------
-- Spotify Widget for Awesome Window Manager
-- Shows currently playing song on Spotify for Linux client
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/spotify-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local gears = require("gears")

local function ellipsize(text, length)
  -- utf8 only available in Lua 5.3+
  if utf8 == nil then
    return text:sub(0, length)
  end
  return (utf8.len(text) > length and length > 0)
      and text:sub(0, utf8.offset(text, length - 2) - 1) .. '...'
      or text
end

local spotify_widget = {}

local new_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 4)
end

local function worker(user_args)

  local args = user_args or {}

  local bg = args.bg
  local play_icon = args.play_icon or '/usr/share/icons/Arc/actions/24/player_play.png'
  local pause_icon = args.pause_icon or '/usr/share/icons/Arc/actions/24/player_pause.png'
  local font = args.font or 'Recursive Bold 10'
  local dim_when_paused = args.dim_when_paused == nil and false or args.dim_when_paused
  local dim_opacity = args.dim_opacity or 0.2
  local max_length = args.max_length or 50
  local timeout = args.timeout or 1
  local sp_bin = args.sp_bin or 'sp'

  local GET_SPOTIFY_STATUS_CMD = sp_bin .. ' status'
  local GET_CURRENT_SONG_CMD = sp_bin .. ' current'

  spotify_widget = wibox.widget
  {
    {
      {
        {
          {
            id = 'artistw',
            font = font,
            widget = wibox.widget.textbox,
          },
          left = 7,
          right = 4,
          widget = wibox.container.margin
        },
        {
          {
            id = "icon",
            resize = true,
            widget = wibox.widget.imagebox,
          },
          top = 4,
          bottom = 4,
          widget = wibox.container.margin
        },
        {
          {
            layout = wibox.container.scroll.horizontal,
            max_size = 100,
            step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
            speed = 40,
            {
              id = 'titlew',
              font = 'Recursive 10',
              widget = wibox.widget.textbox
            }
          }, right = 7,
          left = 4,
          widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal,
      },
      bg     = bg,
      fg     = "#252630",
      shape  = new_shape,
      widget = wibox.container.background
    },
    margins    = 3,
    widget     = wibox.container.margin,
    set_status = function(self, is_playing)
      self:get_children_by_id('icon')[1]:set_image(is_playing and play_icon or pause_icon)
      if dim_when_paused then
        self:get_children_by_id('icon')[1]:set_opacity(is_playing and 1 or dim_opacity)

        self:get_children_by_id('titlew')[1]:set_opacity(is_playing and 1 or dim_opacity)
        self:get_children_by_id('titlew')[1]:emit_signal('widget::redraw_needed')

        self:get_children_by_id('artistw')[1]:set_opacity(is_playing and 1 or dim_opacity)
        self:get_children_by_id('artistw')[1]:emit_signal('widget::redraw_needed')
      end
    end,
    set_text   = function(self, artist, song)
      local artist_to_display = ellipsize(artist, max_length)
      if self:get_children_by_id('artistw')[1]:get_markup() ~= artist_to_display then
        self:get_children_by_id('artistw')[1]:set_markup(artist_to_display)
      end
      local title_to_display = ellipsize(song, max_length)
      if self:get_children_by_id('titlew')[1]:get_markup() ~= title_to_display then
        self:get_children_by_id('titlew')[1]:set_markup(title_to_display)
      end
    end
  }

  local update_widget_icon = function(widget, stdout, _, _, _)
    stdout = string.gsub(stdout, "\n", "")
    widget:set_status(stdout == 'Playing' and true or false)
  end

  local update_widget_text = function(widget, stdout, _, _, _)
    if string.find(stdout, 'Error: Spotify is not running.') ~= nil then
      widget:set_text('', '')
      widget:set_visible(false)
      return
    end

    local escaped = string.gsub(stdout, "&", '&amp;')
    local album, _, artist, title =
    string.match(escaped, 'Album%s*(.*)\nAlbumArtist%s*(.*)\nArtist%s*(.*)\nTitle%s*(.*)\n')

    if album ~= nil and title ~= nil and artist ~= nil then
      cur_artist = artist
      cur_title = title
      cur_album = album

      widget:set_text(artist, title)
      widget:set_visible(true)
    end
  end

  watch(GET_SPOTIFY_STATUS_CMD, timeout, update_widget_icon, spotify_widget)
  watch(GET_CURRENT_SONG_CMD, timeout, update_widget_text, spotify_widget)

  --- Adds mouse controls to the widget:
  --  - left click - play/pause
  --  - scroll up - play next song
  --  - scroll down - play previous song
  spotify_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 2) then
      awful.spawn("sp play", false) -- left click
    elseif (button == 1) then
      awful.spawn("sp next", false) -- scroll up
    elseif (button == 3) then
      awful.spawn("sp prev", false) -- scroll down
    end
    awful.spawn.easy_async(GET_SPOTIFY_STATUS_CMD, function(stdout, stderr, exitreason, exitcode)
      update_widget_icon(spotify_widget, stdout, stderr, exitreason, exitcode)
    end)
  end)

  local only_on_primary = awful.widget.only_on_screen(spotify_widget, awful.screen.primary)

  return only_on_primary
end

return setmetatable(spotify_widget, { __call = function(_, ...)
  return worker(...)
end })
