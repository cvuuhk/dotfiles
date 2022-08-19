vim.o.number = true -- 显示行号
vim.o.cursorline = true -- 突出显示当前行
vim.o.termguicolors = true -- true color
vim.o.showmode = false -- 隐藏当前模式
vim.o.tabstop = 2 -- 一个 \t 的宽度
vim.o.expandtab = true -- 将 tab 转换为空格
vim.o.shiftwidth = 2 -- normal 模式下缩进时的宽度
vim.o.splitbelow = true -- 新窗口位置
vim.o.splitright = true -- 新窗口位置
vim.o.wrapscan = false -- 禁止循环搜索
vim.o.ignorecase = true
vim.o.smartcase = true -- 智能大小写敏感
vim.o.mouse = "a" -- 启用鼠标
vim.o.foldmethod = "marker" -- 设置折叠方式
vim.o.clipboard = "unnamedplus" -- 设置系统剪贴板
vim.o.undofile = true -- 记录 undo 历史
vim.o.shortmess = vim.o.shortmess .. "c" -- 隐藏补全提示
vim.g.mapleader = ','

-- 打开文件时跳回上次离开的位置
vim.cmd([[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]])
-- 自动关闭最后一个 nvim-tree 窗口
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

function DIAG()
  local function count(s) return vim.diagnostic.get(0, {severity = s}) end

  local error = count(vim.diagnostic.severity.ERROR)
  local warn = count(vim.diagnostic.severity.WARN)
  local info = count(vim.diagnostic.severity.INFO)
  local hint = count(vim.diagnostic.severity.HINT)
  return string.format("E:%d W:%d I:%d H:%d", #(error), #(warn), #(info), #(hint))
end

vim.o.statusline = '[%t]%r%m %{v:lua.DIAG()}%=[%{&fileformat}][%{&fileencoding}] [%l/%L,%v]'

local map = vim.api.nvim_set_keymap

map('', '<C-h>', '<C-w>h', {noremap = true})
map('', '<C-j>', '<C-w>j', {noremap = true})
map('', '<C-k>', '<C-w>k', {noremap = true})
map('', '<C-l>', '<C-w>l', {noremap = true})

map('n', 'k', 'gk', {noremap = true})
map('n', 'gk', 'k', {noremap = true})
map('n', 'j', 'gj', {noremap = true})
map('n', 'gj', 'j', {noremap = true})

map('n', '/', '/\\v', {noremap = true})
map('i', 'jj', '<Esc>', {noremap = true})
map('c', 'qq', 'qa!', {noremap = true})
map('c', 'ww', " execute 'silent! write !sudo tee % >/dev/null' <bar> edit!", {noremap = true})
map('n', '<BackSpace>', ':nohl<CR>', {noremap = true})
map('n', '<Enter>', ':cd %:h<CR>', {noremap = true})
map('n', '<leader>pc', ':PackerCompile<CR>', {noremap = true})
map('n', '<leader>ps', ':PackerSync<CR>', {noremap = true})
map('n', '<leader>w', 'gg/\\v\\s+$<CR>', {noremap = true})

-- lsp
local opt = {noremap = true, silent = true}
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opt)
map('n', '<F2>', ':lua vim.diagnostic.goto_prev()<CR>', opt)
map('n', '<F3>', ':lua vim.diagnostic.goto_next()<CR>', opt)
map('n', '<leader>.', ':lua vim.lsp.buf.code_action()<CR>', opt)
map('n', '<leader>r', ':lua vim.lsp.buf.rename()<CR>', opt)
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opt)
map('n', 'gs', ':lua vim.lsp.buf.signature_help()<CR>', opt)
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opt)
map('n', '<C-A-l>', ':Format<CR>', opt)
map('i', '<C-A-l>', '<Esc>:Format<CR>', opt)
