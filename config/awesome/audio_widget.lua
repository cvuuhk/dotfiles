local function run(command)
  local p = io.popen(command)
  local out = p:read("*a")
  p:close()
  return out
end

local core = { volume = 0, mute = false }

function core:update()
  local cv_output = run("wpctl get-volume @DEFAULT_SINK@")
  self.volume = tonumber(string.gmatch(cv_output, "(%d+.%d+)")() or 0) * 100
  self.mute = cv_output:find("MUTED") ~= nil
end

function core:adjust(offset)
  self.volume = self.volume + offset
  if self.volume > 100 then self.volume = 100 end
  if self.volume < 0 then self.volume = 0 end

  run("wpctl set-volume @DEFAULT_SINK@ " .. self.volume .. "%")
end

function core:toggle()
  self.mute = not self.mute
  local s = self.mute and "1" or "0"
  run("wpctl set-mute @DEFAULT_SINK@ " .. s)
end


local step = 2
local awful = require("awful")
local wibox = require("wibox")
local widget = wibox.widget.textbox("", false)

function widget.update()
  local prefix = core.mute and "静音(" or "音量("
  local suffix = ")"
  widget.markup = prefix .. core.volume .. suffix
end

function widget.increase()
  core:adjust(step)
  widget.update()
end

function widget.decrease()
  core:adjust(-1 * step)
  widget.update()
end

function widget.mute()
  core:toggle()
  widget.update()
end

function widget.init()
  core:update()
  widget.update()
end

widget:set_align("center")
widget:buttons(
  awful.util.table.join(
  awful.button({ }, 1, widget.mute),
  -- awful.button({ }, 3, widget.update),
  awful.button({ }, 4, widget.increase),
  awful.button({ }, 5, widget.decrease)
  )
)
return widget
