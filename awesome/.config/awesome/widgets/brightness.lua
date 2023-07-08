local wibox = require("wibox")
local gears = require("gears")
local spawn = require("awful.spawn")
local awful = require("awful")

local new_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 4)
end

local mywidgetlayout = function()

  local m = wibox.widget {
    {
      {
        widget = wibox.widget.textbox,
        text = 'b '
      },
      {
        id = 'txt',
        widget = wibox.widget.textbox
      },
      layout = wibox.layout.fixed.horizontal,
    },
    set_value = function(self, value)
      self:get_children_by_id('txt')[1]:set_text(value .. '%')
    end,
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
      awful.button({}, 4, function() m:inc() end),
      awful.button({}, 5, function() m:dec() end)
    )
  )

  on_init()

  local only_on_primary = awful.widget.only_on_screen(m, awful.screen.primary)

  return only_on_primary
end

return mywidgetlayout
