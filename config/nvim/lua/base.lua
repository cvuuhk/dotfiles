vim.o.number = true -- 显示行号
-- vim.o.cursorline = true -- 突出显示当前行
vim.o.cursorcolumn = true
vim.o.termguicolors = true -- true color
vim.o.showmode = false -- 隐藏当前模式
vim.o.tabstop = 2 -- 一个 \t 的宽度
vim.o.expandtab = true -- 将 tab 转换为空格
vim.o.shiftwidth = 2 -- normal 模式下缩进时的宽度
vim.o.splitbelow = true -- 新窗口位置
vim.o.splitright = true -- 新窗口位置
-- vim.o.wrapscan = false -- 禁止循环搜索
vim.o.ignorecase = true
vim.o.smartcase = true -- 智能大小写敏感
vim.o.mousemodel = 'extend'
vim.o.clipboard = "unnamedplus" -- 设置系统剪贴板
vim.o.undofile = true -- 记录 undo 历史
-- vim.o.shortmess = vim.o.shortmess .. "c" -- 隐藏补全提示
vim.o.jumpoptions = "stack"
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.o.laststatus = 3
-- vim.o.relativenumber = true
-- 不开粘贴时自动缩进，防止以下场景
-- content
--     content
--         content
vim.o.winborder = 'rounded'

local noremap = function (mode, key, mapped) vim.keymap.set(mode, key, mapped, {noremap = true}) end
local silnoremap = function (mode, key, mapped) vim.keymap.set(mode, key, mapped, {noremap = true, silent = true}) end

noremap('n', '<A-j>', 'gt')
noremap('n', '<A-k>', 'gT')

noremap('n', 'k', 'gk')
noremap('n', 'gk', 'k')
noremap('n', 'j', 'gj')
noremap('n', 'gj', 'j')

noremap('n', '/', '/\\v')
noremap('i', 'jj', '<Esc>')
noremap('c', 'qq', 'qa!')
noremap('c', 'ww', "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!")

silnoremap('n', '<C-h>', '<C-w>h')
silnoremap('n', '<C-j>', '<C-w>j')
silnoremap('n', '<C-k>', '<C-w>k')
silnoremap('n', '<C-l>', '<C-w>l')
silnoremap('n', '<leader><Enter>', ':cd %:h<CR>')
silnoremap('v', 'H', ":m '>+1<CR>gv=gv")
silnoremap('v', 'L', ":m '<-2<CR>gv=gv")
-- 注意终端是否正确处理信号
silnoremap('i', '<S-CR>', '<Esc>o')

-- lsp
silnoremap('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
silnoremap('n', '<F2>', ':lua vim.diagnostic.goto_prev()<CR>')
silnoremap('n', '<F3>', ':lua vim.diagnostic.goto_next()<CR>')
silnoremap('n', '<leader>.', ':lua vim.lsp.buf.code_action()<CR>')
silnoremap('n', '<leader>r', ':lua vim.lsp.buf.rename()<CR>')
silnoremap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
silnoremap('n', 'gs', ':lua vim.lsp.buf.signature_help()<CR>')
silnoremap('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
silnoremap('n', '<C-A-l>', ':w<CR>:Format<CR>')
silnoremap('i', '<C-A-l>', '<Esc>:w<CR>:Format<CR>')

-- 每次打开使用新的 jumplist
vim.cmd([[autocmd VimEnter * :clearjumps]])
-- 打开文件时跳回上次离开的位置
vim.cmd([[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]])
-- normal 模式下从注释行 o 的时候不要插入注释头
vim.cmd([[autocmd BufEnter * :set formatoptions=jcrql]])
