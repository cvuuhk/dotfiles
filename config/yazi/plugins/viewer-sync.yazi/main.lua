--- @since 25.5.31

-- viewer-sync: 响应播放器/看图器发布的消息, 把光标移到最后查看的文件。
--
-- 数据源:
--   "mpv-file"  — mpv 的 scripts/yazi-sync.lua 在每次开始播放新文件(切集)时发布;
--   "imv-ended" — imv 的 imv-quit 脚本(q 键绑定)在退出时发布。
--
-- 仅当目标文件与 yazi 当前目录同级时, 才把光标移到该文件上;
-- 若用户在播放期间已浏览到其他目录, 则不打扰, 也不做跨目录跳转。

local M = {}

local function on_file(path)
	if type(path) ~= "string" or path == "" then
		return
	end

	-- 目标文件必须位于当前目录, 否则忽略
	local cwd = tostring(cx.active.current.cwd)
	local dir = path:match("^(.*)/[^/]+$")
	if not dir or dir ~= cwd then
		return
	end

	-- 已是选中文件时无需重复 reveal
	local h = cx.active.current.hovered
	if h and tostring(h.url) == path then
		return
	end

	ya.emit("reveal", { path })
end

function M.setup(self)
	ps.sub_remote("mpv-file", function(t)
		on_file(t[1])
	end)
	ps.sub_remote("imv-ended", function(t)
		on_file(t[1])
	end)
end

return { setup = M.setup }
