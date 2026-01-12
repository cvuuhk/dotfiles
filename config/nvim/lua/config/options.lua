-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.relativenumber = false
vim.g.gruvbox_material_transparent_background = 1
vim.g.autoformat = false

vim.o.number = true -- 显示行号
-- vim.o.cursorline = true -- 突出显示当前行
vim.o.cursorcolumn = true
vim.o.termguicolors = true -- true color
vim.o.showmode = false     -- 隐藏当前模式
vim.o.tabstop = 2          -- 一个 \t 的宽度
vim.o.expandtab = true     -- 将 tab 转换为空格
vim.o.shiftwidth = 2       -- normal 模式下缩进时的宽度
vim.o.splitbelow = true    -- 新窗口位置
vim.o.splitright = true    -- 新窗口位置
-- vim.o.wrapscan = false -- 禁止循环搜索
vim.o.ignorecase = true
vim.o.smartcase = true                   -- 智能大小写敏感
vim.o.mouse = "a"                        -- 启用鼠标
vim.o.clipboard = "unnamedplus"          -- 设置系统剪贴板
vim.o.undofile = true                    -- 记录 undo 历史
vim.o.shortmess = vim.o.shortmess .. "c" -- 隐藏补全提示
vim.o.jumpoptions = "stack"
-- vim.g.mapleader = ","
-- vim.o.laststatus = 3
-- vim.o.relativenumber = true
-- 不开粘贴时自动缩进，防止以下场景
-- content
--     content
--         content
