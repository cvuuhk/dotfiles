local pulseaudio = {}


local cmd = "pamixer"
local default_sink = ""

-- Run process and wait for it to end
local function run(command)
  local p = io.popen(command)
  local out = p:read("*a")
  p:close()
  return out
end


function pulseaudio:Create()
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.Volume = 0     -- volume of default sink
  o.Mute = false   -- state of the mute flag of the default sink

  local ds_output = run(cmd .. " --get-default-sink")
  default_sink = string.gmatch(ds_output, "(%d+)")()

  if default_sink then
    cmd = cmd .. " --sink " .. default_sink
  end

  -- retreive current state from Pulseaudio
  pulseaudio.UpdateState(o)

  return o
end


function pulseaudio:UpdateState()
  local cv_output = run(cmd ..  " --get-volume")
  self.Volume = tonumber(string.gmatch(cv_output, "(%d+)")() or 0)
  local mt_output = run(cmd .. " --get-mute")
  self.Mute = string.gmatch(mt_output, "(%a+)")() == 'true'
end


-- Sets the volume of the default sink to vol from 0 to 1.
function pulseaudio:SetVolume(vol)
  if vol > 100 then vol = 100 end
  if vol < 0 then vol = 0 end

  run(cmd .. " --set-volume " .. string.format('%i', vol))
  self:UpdateState()
end


function pulseaudio:ToggleMute()
  if self.Mute then run(cmd .. "  --unmute")
  else run(cmd .. "  --mute")
  end
  self:UpdateState()
end


return pulseaudio
