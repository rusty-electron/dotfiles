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

-- contains quake and many utilities
local lain = require("lain")

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
    awesome.connect_signal("debug::error", function (err)
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
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default")
beautiful.init(theme_path)

beautiful.taglist_font = "Iosevka 11"

-- global quake dropdown terminals
local quakedd = lain.util.quake({
    app = "st",
    name = "quake-dd",
    argname = "-n %s",
    extra = " -e tmux",
    height = 0.7,
    width = 0.5,
    vert = "center",
    horiz = "center",
    followtag = true,
})

local quakemath = lain.util.quake({
    app = "st",
    name = "quake-math",
    argname = "-n %s",
    extra = "-f 'Anonymice Powerline:size=18' -e qalc",
    height = 0.3,
    width = 0.3,
    vert = "center",
    horiz = "center",
    followtag = true,
})

-- lain separators
local separators = lain.util.separators
local arrow = separators.arrow_left

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
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
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end)
                    -- disable tag switch when mouse scrolling on taglist
                    -- awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    -- awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- local function set_wallpaper(s)
--     -- Wallpaper
--     if beautiful.wallpaper then
--         local wallpaper = beautiful.wallpaper
--         -- If wallpaper is a function, call it with the screen
--         if type(wallpaper) == "function" then
--             wallpaper = wallpaper(s)
--         end
--         gears.wallpaper.maximized(wallpaper, s, true)
--     end
-- end

-- scan directory, and optionally filter outputs
function scandir(directory, filter)
    local i, t, popen = 0, {}, io.popen
    if not filter then
        filter = function(s) return true end
    end
    print(filter)
    for filename in popen('ls -a "'..directory..'"'):lines() do
        if filter(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end

local function set_wallpaper(s)
    wp_path = "/home/pritom/myfiles/wallpapers/"
    wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
    wp_files = scandir(wp_path, wp_filter)
    -- set random seed
    math.randomseed(os.time())

    -- set wallpaper to current index for all screens
      for s = 1, screen.count() do
        wp_index = math.random(1, #wp_files)
        gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
      end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- set specific layouts for each tag
local l = awful.layout.suit
local layouts = { l.tile, l.tile, l.tile, l.floating, l.floating, l.max, l.max, l.magnifier, l.floating }

-- set tagnames
local tagnames = { "1 爵 ", "2  ", "3  ", "4  ", "5  ", "6  ", "7  ", "8 辶 ", "9  " }

-- {{{ awesome widgets

local battery_widget = require("awesome-wm-widgets.battery-widget.battery")

local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

-- by lain

local lainmem = lain.widget.mem({
    settings = function()
        widget:set_markup(" RAM: " .. mem_now.perc .. "% ")
    end
})

local laintemp = lain.widget.temp({
    format = "%.0f",
    settings = function()
        widget:set_markup(" CPU: " .. coretemp_now .. "°C")
    end
})
--- }}}


awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(tagnames, s, layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox = wibox.container.margin(s.mylayoutbox, 5, 5, 5, 5)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 0,
            -- arrow("alpha", beautiful.cairo1),
            wibox.container.background(
                wibox.widget{
                    markup = '  ',
                    align  = 'center',
                    valign = 'center',
                    widget = wibox.widget.textbox,
                },
                beautiful.cairo1
            ),
            wibox.container.background(
                mykeyboardlayout, beautiful.cairo1
            ),
            arrow(beautiful.cairo1, beautiful.cairo6),
            wibox.container.background(
                volume_widget({
                    widget_type = 'horizontal_bar',
                    with_icon = true,
                    mute_color = '#000',
                    main_color = "#fff",
                }),
                beautiful.cairo6
            ),
            arrow(beautiful.cairo6, beautiful.cairo5),
            wibox.container.background(
                wibox.widget{
                    markup = ' BAT:',
                    align  = 'center',
                    valign = 'center',
                    widget = wibox.widget.textbox,
                },
                beautiful.cairo5
            ),
            wibox.container.background(
                battery_widget({
                    show_current_level = true,
                    font = "UbuntuMono Nerd Font 12",
                    margin_right = 8,
                }),
                beautiful.cairo5
            ),
            arrow(beautiful.cairo5, beautiful.cairo4),
            -- wibox.container.background(
            --     wibox.widget{
            --         markup = 'CPU:',
            --         align  = 'center',
            --         valign = 'center',
            --         widget = wibox.widget.textbox,
            --     },
            --     beautiful.cairo4
            -- ),
            wibox.container.background(
                    wibox.widget { laintemp.widget, layout = wibox.layout.align.horizontal },
                beautiful.cairo4
            ),
            wibox.container.background(
                wibox.container.margin(
                    cpu_widget({
                        width = 30,
                        color = "#fff",
                    }), 3, 3, 3, 3
                    ),
                beautiful.cairo4
            ),
            arrow(beautiful.cairo4, beautiful.cairo3),
            -- wibox.container.background(
            --     wibox.widget{
            --         markup = 'RAM:',
            --         align  = 'center',
            --         valign = 'center',
            --         widget = wibox.widget.textbox,
            --     },
            --     beautiful.cairo3
            -- ),
            wibox.container.background(wibox.container.margin(lainmem.widget, 0, 0), beautiful.cairo3),
            arrow(beautiful.cairo3, beautiful.cairo2),
            wibox.widget.systray(),
            arrow(beautiful.cairo2, beautiful.cairo1),
            wibox.container.background(wibox.container.margin(mytextclock, 0, 0), beautiful.cairo1),
            arrow(beautiful.cairo1, "alpha"),
            s.mylayoutbox
            -- wibox.container.margin(mylauncher, 5, 5, 5, 5)
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- disable mouse scroll to change workspace
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
              -- TODO: go back but across the two monitor screens
    awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey, }, "u", function () quakedd:toggle() end,
              {description = "toggle quake-dd term", "quake"}),
    awful.key({ modkey, }, ",", function () quakemath:toggle() end,
              {description = "toggle quake-math term", "quake"}),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,  }, "h", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,  }, "l", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "g", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "a",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    -- awful.key({ modkey, "Ctrl"   }, "k", awesome.quit,
    --           {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Shift" }, "Right",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift" }, "Left",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Control"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "e", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Control"   }, "e", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "d",     function () awful.util.spawn("dmenu_run") end,
              {description = "run dmenu prompt", group = "launcher"}),

    -- Browser
    awful.key({ modkey },            "b",     function () awful.util.spawn("google-chrome-stable") end,
              {description = "run web browser", group = "applications"})

    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run {
    --                 prompt       = "Run Lua code: ",
    --                 textbox      = awful.screen.focused().mypromptbox.widget,
    --                 exe_callback = awful.util.eval,
    --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
    --               }
    --           end,
    --           {description = "lua execute prompt", group = "awesome"}),
    -- -- Menubar
    -- awful.key({ modkey }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Control" }, "Right",      function (c) c:move_to_screen()               end,
              {description = "move to right screen", group = "client"}),
    awful.key({ modkey, "Control" }, "Left",      function (c) c:move_to_screen(c.screen.index - 1)               end,
              {description = "move to left screen", group = "client"}),
              -- TODO: implement this
    -- awful.key({ modkey, "Shift" }, "w",      function (c) c:move_to_screen(c.screen.index - 1)               end,
    --           {description = "swap this screen with next", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          -- "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Gcolor3",
          "Pavucontrol",
          "JDownloader 2",
          "qutebrowser",
          -- "[Ss]potify", -- doesn't work
          "Gnome-pomodoro",
          "qBittorrent",
          "imagewriter",
          "ark",
          "OneDriveGUI",
      },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = { -- first value in xprop
          "Event Tester",  -- xev.
          "mpv-mini",
          "flameshot",
          "Picture in picture",
          "kdeconnect-app",
          "Cisco Secure Client"
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },

    -- Set Ferdi to open in tag 9
    { rule = { class = "[fF]erdium" },
      properties = { screen = 1, tag = tagnames[9] } },

    -- Set Rambox to open in tag 9
    { rule = { class = "[rR]ambox" },
      properties = { screen = 1, tag = tagnames[9] } },

    -- Set OneDriveGUI to open in tag 9
    { rule = { class = "OneDriveGUI" },
      properties = { screen = 1, tag = tagnames[8] } },

    -- TODO: disable titlebars in quake terminals
    -- { rule = { role = "quake-dd" },
    --     properties = { titlebars_enabled = false } },
    { rule = { class = "albert" },
        properties = { titlebars_enabled = false, border_width = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
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
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- {{{ USER ADDED }}}
local hide_title_list = { 'quake-math' }

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

client.connect_signal("property::floating", function(c)
    if c.floating and not has_value(hide_title_list, c.class) then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

client.connect_signal("manage", function(c)
    if (c.floating or c.first_tag.layout.name == "floating") and not has_value(hide_title_list, c.class) then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for k,c in pairs(clients) do
        if c.floating or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end
    end
end)

--- TODO: try to add this feature
-- Hide the menu when the mouse leaves it
--[[
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
    if not awful.util.mymainmenu.active_child or
       (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
       awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
        function()
            if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
                awful.util.mymainmenu:hide()
            end
        end)
    end
end)
--]]


-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized or c.fullscreen then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Spotify window workaround
client.connect_signal("property::class", function(c)
   if c.class == "Spotify" then
      c:move_to_tag(screen[1].tags[9])
      if not c.floating then
          c.floating = true
      end
   end
end)

-- combat memory leaks
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function() collectgarbage() end
}

--[[ TODO:
* a function that moves all windows of current tag in current screen to the same tag in the other screen
--]]

-- Save and restore tags, when monitor setup is changed
local naughty = require("naughty")
local tag_store = {}
tag.connect_signal("request::screen", function(t)
  local fallback_tag = nil

  -- find tag with same name on any other screen
  for other_screen in screen do
    if other_screen ~= t.screen then
      fallback_tag = awful.tag.find_by_name(other_screen, t.name)
      if fallback_tag ~= nil then
        break
      end
    end
  end

  -- no tag with same name exists, chose random one
  if fallback_tag == nil then
    fallback_tag = awful.tag.find_fallback()
  end

  if not (fallback_tag == nil) then
    local output = next(t.screen.outputs)

    if tag_store[output] == nil then
      tag_store[output] = {}
    end

    clients = t:clients()
    tag_store[output][t.name] = clients

    for _, c in ipairs(clients) do
      c:move_to_tag(fallback_tag)
    end
  end
end)

screen.connect_signal("added", function(s)
  local output = next(s.outputs)
  naughty.notify({ text = output .. " Connected" })

  tags = tag_store[output]
  if not (tags == nil) then
    naughty.notify({ text = "Restoring Tags" })

    for _, tag in ipairs(s.tags) do
      clients = tags[tag.name]
      if not (clients == nil) then
        for _, client in ipairs(clients) do
          client:move_to_tag(tag)
        end
      end
    end
  end
end)
