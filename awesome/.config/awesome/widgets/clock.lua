local wibox = require("wibox")
local gears = require("gears")
local spawn = require("awful.spawn")
local awful = require("awful")

local new_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 4)
end

local mywidgetlayout = function(clockwidget, icon, bg)

  clockwidget.font = "Recursive Bold 10"
  local m = wibox.widget {
    {
      {
        {
          {
            image = icon,
            resize = true,
            widget = wibox.widget.imagebox
          },
          top = 4,
          bottom = 4,
          left = 7,
          widget = wibox.container.margin
        },
        {
          clockwidget,
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

  return m;
end

return mywidgetlayout
