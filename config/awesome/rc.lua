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

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 4
beautiful.wallpaper = os.getenv("HOME") .. "/.wallpaper.png"
beautiful.font = "PingFang SC 12"

-- This is used later as the default terminal and editor to run.
local terminal = "alacritty"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Create a textclock widget
os.setlocale(os.getenv("LANG"))
local mytextclock = wibox.widget.textclock("%Y年%m月%d日 周%a %H:%M:%S", 1)

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
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal( "request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

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

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"日", "拱", "一", "卒", "功", "不", "唐", "捐"}, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
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

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 2,
            s.mytaglist,
        },
        -- Middle widget
        awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        },
        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
local switch_in_tag = function ()
    awful.client.focus.history.previous()
    if client.focus then client.focus:raise()
    end
end

local restore_from_minimize = function ()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        c:emit_signal( "request::activate", "key.unminimize", {raise = true})
    end
end

local toggle_topbar = function()
    local myscreen = awful.screen.focused()
    myscreen.mywibox.visible = not myscreen.mywibox.visible
end

local global_keys = gears.table.join(
    awful.key({},                  "XF86AudioRaiseVolume",  function() awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%") end, {description="增加音量",        group="系统"}),
    awful.key({},                  "XF86AudioLowerVolume",  function() awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%") end, {description="降低音量",        group="系统"}),
    awful.key({},                  "Print",                 function() awful.spawn("flameshot gui") end,                                       {description="截屏",            group="系统"}),
    awful.key({ modkey, "Shift" }, "l",                     function() awful.spawn.with_shell("xset dpms force off") end,                      {description="熄屏",            group="系统"}),
    awful.key({ modkey, },         "s",                     hotkeys_popup.show_help,                                                           {description="显示快捷键",      group="系统"}),
    awful.key({ modkey },          "p",                     function() awful.spawn.with_shell("rofi -show drun -show-icons") end,              {description="打开 App 启动器", group="系统"}),

    awful.key({ modkey, }, "Left",  awful.tag.viewprev,        {description = "上一个 tag", group = "tag"}),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,        {description = "下一个 tag", group = "tag"}),
    awful.key({ modkey, }, "Tab",   awful.tag.history.restore, {description = "切换 tag",   group = "tag"}),

    awful.key({ modkey,         }, "u",      awful.client.urgent.jumpto,                   {description = "跳转到激活的 client",  group = "client"}),
    awful.key({ modkey,         }, "Escape", switch_in_tag,                                {description = "tag 内切换 client",    group = "client"}),
    awful.key({ modkey,         }, "j",      function () awful.client.focus.byidx( 1) end, {description = "下一个 client",        group = "client"}),
    awful.key({ modkey,         }, "k",      function () awful.client.focus.byidx(-1) end, {description = "上一个 client",        group = "client"}),
    awful.key({ modkey, "Shift" }, "j",      function () awful.client.swap.byidx(  1) end, {description = "和下一个 client 交换", group = "client"}),
    awful.key({ modkey, "Shift" }, "k",      function () awful.client.swap.byidx( -1) end, {description = "和上一个 client 交换", group = "client"}),
    awful.key({ modkey, "Shift" }, "n",      restore_from_minimize,                        {description = "取消最小化",           group = "client"}),

    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,  {description = "打开终端", group = "程序启动"}),
    awful.key({ modkey, }, "space",  function () awful.spawn("firefox") end, {description = "打开火狐", group = "程序启动"}),

    awful.key({ modkey, "Shift" }, "r", awesome.restart, {description = "应用 awesome 配置", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,    {description = "退出 awesome",      group = "awesome"}),
    awful.key({ modkey,         }, "b", toggle_topbar,   {description = "开关 topbar",       group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05) end, {description = "增加主分区宽度", group = "布局"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05) end, {description = "减少主分区宽度", group = "布局"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(1) end,        {description = "使用下一个分区", group = "布局"})
)

local client_keys = gears.table.join(
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    awful.key({ modkey,           }, "n",      function (c) c.minimized = true end,                      {description = "最小化",            group = "client"}),
    awful.key({ modkey,    },        "q",      function (c) c:kill() end,                                {description = "关闭当前 client",   group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,                             {description = "切换浮动模式",      group = "client"}),
    awful.key({ modkey, "Shift"   }, "Return", function (c) c:swap(awful.client.getmaster()) end,        {description = "移至主分区",        group = "client"}),
    awful.key({ modkey,           }, "m",      function (c) c.maximized = not c.maximized c:raise() end, {description = "最大化/取消最大化", group = "client"})
)

-- Bind all key numbers to tags.
for i = 1, 8 do
    global_keys = gears.table.join(global_keys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "跳转到 tag "..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "开关 tag " .. i, group = "tag"}),
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
                  {description = "移动 client 到 tag "..i, group = "tag"})
    )
end

client_keys = gears.table.join(
    client_keys,
    awful.button({},         1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.resize(c) end)
)

-- Set keys
root.keys(global_keys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = {},
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = client_keys,
                     buttons = client_keys,
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
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}

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

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal c.opacity=1 end)
