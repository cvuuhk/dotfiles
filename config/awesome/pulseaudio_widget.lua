local awful = require("awful")
local wibox = require("wibox")
local pulseaudio = require('pulseaudio'):Create()

local widget = wibox.widget.textbox("", false)
widget:set_align("center")

local function refresh_widget()
  pulseaudio:UpdateState()
  local prefix = "音量("
  local suffix = ")"
  if pulseaudio.Mute then
    prefix = "静音("
  end
  widget.markup = prefix .. pulseaudio.Volume .. suffix
end

local step = 2
function widget.Up()
  pulseaudio:SetVolume(pulseaudio.Volume + step)
  refresh_widget()
end

function widget.Down()
  pulseaudio:SetVolume(pulseaudio.Volume - step)
  refresh_widget()
end

function widget.ToggleMute()
  pulseaudio:ToggleMute()
  refresh_widget()
end

function widget.Refresh()
  refresh_widget()
end

widget:buttons(awful.util.table.join(
  awful.button({ }, 1, widget.ToggleMute),
  awful.button({ }, 3, widget.Refresh),
  awful.button({ }, 4, widget.Up),
  awful.button({ }, 5, widget.Down)
)
)

refresh_widget()
return widget
