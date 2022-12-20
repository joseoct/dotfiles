local wibox = require("wibox")
local gears = require("gears")
local spawn = require("awful.spawn")
local awful = require("awful")

local new_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 4)
end

local mywidgetlayout = function(bg)

  local m = wibox.widget {
    {
      {
        {
          {
            image = "/home/joseoctavio/.config/awesome/widgets/icons/brightness.svg",
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
    spawn.easy_async("light -G", function(out)
      widget:set_value(string.format("%.0f", out))
    end)
  end

  local on_init = function()
    spawn.easy_async("light -S 50", function()
      update_widget(m)
    end)
  end

  function m:inc()
    spawn.easy_async("light -A 10", function()
      update_widget(m)
    end)
  end

  function m:dec()
    spawn.easy_async("light -U 10", function()
      update_widget(m)
    end)
  end

  m.widget:buttons(
    awful.util.table.join(
      awful.button({}, 1, function() m:inc() end),
      awful.button({}, 3, function() m:dec() end)
    )
  )

  on_init()

  return m;
end

return mywidgetlayout
