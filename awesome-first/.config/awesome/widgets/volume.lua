local wibox = require("wibox")
local gears = require("gears")
local spawn = require("awful.spawn")
local awful = require("awful")
local naughty = require("naughty")

local new_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 4)
end

local mywidgetlayout = function(bg)

  local m = wibox.widget {
    {
      {
        {
          {
            image = "/home/joseoctavio/.config/awesome/widgets/icons/volume.svg",
            resize = true,
            widget = wibox.widget.imagebox
          },
          top = 4,
          bottom = 4,
          left = 7,
          widget = wibox.container.margin
        },
        {
          {
            id = 'txt',
            font = 'Recursive Bold 10',
            widget = wibox.widget.textbox
          },
          top = 4,
          bottom = 5,
          left = 4,
          right = 7,
          widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal,
      },
      bg     = bg,
      fg     = "#252630",
      shape  = new_shape,
      widget = wibox.container.background
    },
    set_value = function(self, value)
      self:get_children_by_id('txt')[1]:set_text(value)
    end,
    margins   = 3,
    widget    = wibox.container.margin
  }

  local update_widget = function(widget)
    spawn.easy_async("amixer sget Master", function(out)
      widget:set_value(string.match(out, "%[(%d+%%)%]"))
    end)
  end

  local on_init = function()
    spawn.easy_async("amixer set Master 50%", function()
      update_widget(m)
    end)
  end

  function m:inc()
    spawn.easy_async("amixer set Master 10%+", function()
      update_widget(m)
    end)
  end

  function m:dec()
    spawn.easy_async("amixer set Master 10%-", function()
      update_widget(m)
    end)
  end

  m.widget:buttons(
    awful.util.table.join(
      awful.button({}, 4, function() m:inc() end),
      awful.button({}, 5, function() m:dec() end)
    )
  )

  on_init()

  local only_on_primary = awful.widget.only_on_screen(m, awful.screen.primary)

  return only_on_primary
end

return mywidgetlayout
