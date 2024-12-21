vim.o.number = true -- 显示行号
-- vim.o.cursorline = true -- 突出显示当前行
vim.o.cursorcolumn = true
vim.o.termguicolors = true -- true color
vim.o.showmode = false -- 隐藏当前模式
vim.o.tabstop = 4 -- 一个 \t 的宽度
vim.o.expandtab = true -- 将 tab 转换为空格
vim.o.shiftwidth = 4 -- normal 模式下缩进时的宽度
vim.o.splitbelow = true -- 新窗口位置
vim.o.splitright = true -- 新窗口位置
-- vim.o.wrapscan = false -- 禁止循环搜索
vim.o.ignorecase = true
vim.o.smartcase = true -- 智能大小写敏感
vim.o.mouse = "a" -- 启用鼠标
vim.o.clipboard = "unnamedplus" -- 设置系统剪贴板
vim.o.undofile = true -- 记录 undo 历史
vim.o.shortmess = vim.o.shortmess .. "c" -- 隐藏补全提示
vim.o.jumpoptions = "stack"
vim.g.mapleader = ','

local noremap = function (mode, key, mapped) vim.keymap.set(mode, key, mapped, {noremap = true}) end
local silnoremap = function (mode, key, mapped) vim.keymap.set(mode, key, mapped, {noremap = true, silent = true}) end

-- noremap('', '<C-h>', '<C-w>h')
-- noremap('', '<C-j>', '<C-w>j')
-- noremap('', '<C-k>', '<C-w>k')
-- noremap('', '<C-l>', '<C-w>l')

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

silnoremap('n', '<BackSpace>', ':nohl<CR>')
silnoremap('n', '<leader><Enter>', ':cd %:h<CR>')
silnoremap('n', '<leader>t', ':tabnew +term<CR>')

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

vim.cmd([[autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif]])
vim.cmd([[autocmd TermOpen * startinsert]])

function _G.get_diagnostics()
  local function count(s) return vim.diagnostic.get(0, {severity = s}) end

  local error = count(vim.diagnostic.severity.ERROR)
  local warn = count(vim.diagnostic.severity.WARN)
  local info = count(vim.diagnostic.severity.INFO)
  local hint = count(vim.diagnostic.severity.HINT)
  return string.format("E:%d W:%d I:%d H:%d", #(error), #(warn), #(info), #(hint))
end

function _G.get_mode_icon(mode)
  local map = {
    ['n'] = 'Normal',
    ['v'] = 'Visual',
    ['V'] = 'VisualLine',
    [''] = 'VisualBlock',
    ['s'] = 'Select',
    ['S'] = 'SelectLine',
    [''] = 'SelectBlock',
    ['i'] = 'Insert',
    ['R'] = 'Replace',
    ['c'] = 'Command',
    ['r'] = 'Prompt',
    ['!'] = 'Shell',
    ['t'] = 'Terminal'
  }
  return map[mode]
end

function _G.get_buffer_name()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return path end

  return '[' .. path:match('[^/]*.$') .. ']'
end

vim.o.statusline = '[%{v:lua.get_mode_icon(mode())}]%{v:lua.get_buffer_name()}%r%m %{v:lua.get_diagnostics()}%=%y[%{&fileformat}] [%l/%L,%v]'
