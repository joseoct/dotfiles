local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local client = _G.client
local awesome = _G.awesome

local menubar = require("menubar")
local modkey = "Mod1"
local altgr = "Mod5"
local bindings = {}

local function changeToTag(index)
  return function()
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
      tag:view_only()
    end
  end
end

bindings.globalkeys = gears.table.join(

-- Sound
  awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause") end),
  awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next") end),
  awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous") end),
  awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer -D pulse sset Master '5%+'") end),
  awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer -D pulse sset Master '5%-'") end),
  awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer -D pulse sset Master toggle") end),

  -- Roffi power-menu
  awful.key({ modkey, }, "=",
    function() awful.spawn.with_shell("$HOME/.config/rofi/scripts/powermenu_t1") end),

  -- {{{ User programs
  -- Google chrome
  -- awful.key({ modkey }, "c", function() awful.util.spawn("google-chrome-stable") end,
  --   { description = "run google chrome", group = "applications" }),

  awful.key({ altgr }, "a", changeToTag(1), { description = "change to back tag", group = "awesome" }),
  awful.key({ altgr }, "s", changeToTag(2), { description = "change to front tag", group = "awesome" }),
  awful.key({ altgr }, "d", changeToTag(3), { description = "change to mobile tag", group = "awesome" }),
  awful.key({ altgr }, "f", changeToTag(4), { description = "change to web tag", group = "awesome" }),
  awful.key({ altgr }, "g", changeToTag(5), { description = "change to database tag", group = "awesome" }),
  awful.key({ altgr }, "h", changeToTag(6), { description = "change to git tag", group = "awesome" }),
  awful.key({ altgr }, "j", changeToTag(7), { description = "change to files tag", group = "awesome" }),
  awful.key({ altgr }, "k", changeToTag(8), { description = "change to any tag", group = "awesome" }),
  awful.key({ altgr }, "l", changeToTag(9), { description = "change to mail tag", group = "awesome" }),
  awful.key({ altgr }, "ç", changeToTag(10), { description = "change to ttv tag", group = "awesome" }),

  -- Change to tag front
  awful.key({ altgr }, "a",
    function()
      local screen = awful.screen.focused()
      local tag = screen.tags[1]
      if tag then
        tag:view_only()
      end
    end,
    { description = "change to front tag", group = "awesome" }),

  -- Change to tag back
  awful.key({ altgr }, "s",
    function()
      local screen = awful.screen.focused()
      local tag = screen.tags[2]
      if tag then
        tag:view_only()
      end
    end,
    { description = "change to back tag", group = "awesome" }),

  -- Change to tag back
  awful.key({ altgr }, "d",
    function()
      local screen = awful.screen.focused()
      local tag = screen.tags[3]
      if tag then
        tag:view_only()
      end
    end,
    { description = "change to web tag", group = "awesome" }),

  -- Change to tag mobile
  awful.key({ altgr }, "f",
    function()
      local screen = awful.screen.focused()
      local tag = screen.tags[4]
      if tag then
        tag:view_only()
      end
    end,
    { description = "change to mobile tag", group = "awesome" }),

  -- Change to tag dbeaver
  awful.key({ altgr }, "g",
    function()
      local screen = awful.screen.focused()
      local tag = screen.tags[5]
      if tag then
        tag:view_only()
      end
    end,
    { description = "change to dbeaver tag", group = "awesome" }),

  -- Change to tag git
  awful.key({ altgr }, "h",
    function()
      local screen = awful.screen.focused()
      local tag = screen.tags[6]
      if tag then
        tag:view_only()
      end
    end,
    { description = "change to git tag", group = "awesome" }),

  -- Firefox
  awful.key({ modkey }, "c",
    function() awful.spawn("brave --wm-window-animations-disabled --animation-duration-scale=0") end,
    { description = "run google chrome", group = "applications" }),

  -- Thunar
  awful.key({ modkey }, "F2", function() awful.spawn("thunar") end,
    { description = "run thunar", group = "launcher" }),

  -- Ranger with terminal
  awful.key({ modkey }, "e", function() awful.spawn(terminal .. " -e ranger") end,
    { description = "run ranger", group = "launcher" }),

  -- LunarVim
  awful.key({ modkey }, "v", function() awful.spawn("code") end,
    { description = "run vscode", group = "launcher" }),

  -- Flameshot
  awful.key({ "Mod4", "Shift" }, "s", function() awful.spawn("flameshot gui") end,
    { description = "run flameshot", group = "applications" }),

  -- }}}
  awful.key({ "Mod4", }, "h", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),
  awful.key({ modkey, "Control" }, "h", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ modkey, "Control" }, "l", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),

  -- Better navigation of layout
  awful.key({ modkey }, "j",
    function()
      awful.client.focus.global_bydirection("down")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus down", group = "client" }),
  awful.key({ modkey }, "k",
    function()
      awful.client.focus.global_bydirection("up")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus up", group = "client" }),
  awful.key({ modkey }, "h",
    function()
      awful.client.focus.global_bydirection("left")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus left", group = "client" }),
  awful.key({ modkey }, "l",
    function()
      awful.client.focus.global_bydirection("right")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus right", group = "client" }),

  -- Layout manipulation
  awful.key({ modkey, }, ",", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, }, ".", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),

  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),

  -- awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
  --   { description = "increase the number of master clients", group = "layout" }),

  -- awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
  --   { description = "decrease the number of master clients", group = "layout" }),

  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Shift" }, "s",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
        )
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Menubar
  -- awful.key({ modkey }, "p",
  --   function() awful.util.spawn("rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi") end,
  --   { description = "show the menubar", group = "launcher" })
  -- awful.key({ modkey }, "p", function() menubar.show() end,
  --   { description = "show the menubar", group = "launcher" })
  awful.key({ modkey }, "p",
    function() awful.spawn.with_shell("rofi -show drun -theme Arc-Dark") end,
    { description = "rofi drun", group = "launcher" })
)

bindings.clientkeys = gears.table.join(
  awful.key({ modkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }),
  -- awful.key({ modkey, }, "w", awful.client.floating.toggle,
  --   { description = "toggle floating", group = "client" }),
  awful.key({ modkey, }, "m", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey, }, "s",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),
  awful.key({ modkey, }, "a",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift" }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  bindings.globalkeys = gears.table.join(bindings.globalkeys,
    -- View tag only.
    -- awful.key({ modkey }, "#" .. i + 9,
    --   function()
    --     local screen = awful.screen.focused()
    --     local tag = screen.tags[i]
    --     if tag then
    --       tag:view_only()
    --     end
    --   end,
    --   { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

bindings.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

return bindings
