local wibox = require("wibox")
local gears = require("gears")
local spawn = require("awful.spawn")
local awful = require("awful")
local naughty = require("naughty")

local mywidgetlayout = function()
    local m = wibox.widget {
        {
            {
                widget = wibox.widget.textbox,
                text = 'v '
            },
            {
                id = 'txt',
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.horizontal
        },
        set_value = function(self, value)
          if value == nil then
            self:get_children_by_id('txt')[1]:set_text("50%")
          else
            self:get_children_by_id('txt')[1]:set_text(value)
          end
        end,
        widget = wibox.container.margin
    }

  local update_widget = function(widget)
    spawn.easy_async_with_shell("amixer sget Master", function(out)
      widget:set_value(string.match(out, "%[(%d+%%)%]"))
    end)
  end

  local on_init = function()
    spawn.easy_async_with_shell("amixer set Master 50%", function()
      update_widget(m)  
    end)
  end

  function m:inc()
    spawn.easy_async_with_shell("amixer set Master 10%+", function()
      update_widget(m)
    end)
  end

  function m:dec()
    spawn.easy_async_with_shell("amixer set Master 10%-", function()
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
