--- @since 25.5.31
--- @sync entry

local M = {}

function M.setup(self, opts)
	-- 是否允许 open 作用于多个选中文件(smart-enter 选项)
	self.open_multi = opts.open_multi

	-- 覆盖 Entity:click:左/中/右三栏的文件行点击最终都会转发到这里,一处覆盖即可全部生效
	Entity.click = function(entity, event, up)
		-- 只处理按下瞬间,忽略松开事件和中键
		if up or event.is_middle then
			return
		end

		local file = entity._file
		if event.is_right then
			if file.cha.is_dir then
				-- 目录:直接 cd,等价于 enter 内部的 mgr:cd,但只有一次导航;
				-- 若用 reveal+enter,左/右栏会先导航到父目录再进入目标,造成闪烁
				ya.emit("cd", { file.url })
			else
				-- 文件:先 reveal 让光标落到被点文件,再 open
				ya.emit("reveal", { file.url })
				ya.emit("open", { hovered = not self.open_multi })
			end
		else
			-- 左键:维持内置行为,仅移动光标
			ya.emit("reveal", { file.url })
		end
	end
end

function M.entry(self)
	-- 键盘路径(o/<Enter>):读取当前 hovered 的文件
	local h = cx.active.current.hovered
	-- smart-enter 核心:目录 -> enter 进入,文件 -> open 打开,nil 时兜底 open
	ya.emit(h and h.cha.is_dir and "enter" or "open", { hovered = not self.open_multi })
end

return { entry = M.entry, setup = M.setup }
