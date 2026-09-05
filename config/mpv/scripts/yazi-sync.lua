-- yazi-sync: 在 mpv 切换上下集(或开始播放新文件)时, 把当前播放的文件实时
-- 报告给启动它的 yazi 实例, 使 yazi 的光标跟随当前播放的集数。
--
-- mpv 内部通过 playlist(如 autoload.lua + playlist-next/prev)切换上下集,
-- 播放过程中 yazi 无法得知当前播放的是哪个文件。每次有文件开始播放时
-- (file-loaded 事件, path 属性此时已就绪), 把该文件路径以 "mpv-file" 消息
-- 发布给父级 yazi(通过 YAZI_ID 环境变量定位实例)。yazi 侧插件仅当该文件
-- 位于 yazi 当前目录时, 才把光标移过去。
--
-- 不用 end-file/observe path 的原因: 换集时 path 会先清空再更新, 而
-- file-loaded 只在新文件真正开始播放时触发一次; 此刻 mpv 正常运行,
-- utils.subprocess 即可可靠地发出消息, 无需像退出时那样用 os.execute。

local msg = require "mp.msg"
local utils = require "mp.utils"

local id = os.getenv("YAZI_ID")

mp.register_event("file-loaded", function()
	if not id or id == "" then
		return -- 非 yazi 启动的 mpv, 直接忽略
	end

	local path = mp.get_property("path")
	if not path or path == "" or path:find("://") then
		return -- 网络流等非本地路径
	end

	-- yazi 以文件所在目录为工作目录启动 opener, 相对路径需拼成绝对路径
	if not path:find("^/") then
		local dir = mp.get_property("working-directory") or os.getenv("PWD") or ""
		if dir == "" then
			return
		end
		path = dir .. "/" .. path
	end

	msg.info(("yazi-sync: publishing `%s`"):format(path))
	utils.subprocess({ args = { "ya", "pub-to", id, "mpv-file", "--list", path } })
end)
