set nu!                              				" 显示行号
set tabstop=4                        				" 设置tab键的宽度
set shiftwidth=4                     				" 换行时行间交错使用4个空格
set expandtab                                       " 将tab转换为空格
set cursorline                       				" 突出显示当前行
filetype plugin indent on                           " vim 自动按类型加载相关设置
set clipboard=unnamedplus  							" 设置系统剪贴板
set nobackup             							" 不需要备份文件
set noswapfile  	       							" 不创建临时交换文件
set nowritebackup        							" 不需要备份文件
set noundofile           							" 不创建撤销文件
set ignorecase smartcase 							" 智能大小写敏感
set nrformats=										" 00x增减数字时使用十进制
set foldmethod=marker								" 设置折叠方式
set smartindent                                     " 智能缩进
set mouse=a                                         " 启用鼠标
set undofile                                        " 持久历史
set undodir=~/.config/nvim/undo_history             " 设置undo目录

" 打开文件总是定位到上次编辑的位置
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"<space>" |
  \ endif

let mapleader=','
:nnoremap / /\v
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
inoremap jj <Esc>
cnoremap qq q!
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

autocmd BufNewFile makefile 0r ~/.dotfiles/template/makefile
autocmd BufNewFile *.sh 0r ~/.dotfiles/template/bashScript

call plug#begin()
Plug 'rakr/vim-one'                                                      " 主题
Plug 'octol/vim-cpp-enhanced-highlight',{ 'for': ['c', 'cpp'] }          " C 系高亮
Plug 'vim-airline/vim-airline'                                           " 强化状态栏
Plug 'yggdroot/indentline'                                               " 显示代码缩进线条

Plug 'lilydjwg/fcitx.vim'                                                " 输入法自动切换
Plug 'scrooloose/nerdtree',{'on':['NERDTreeToggle','NERDTreeFind']}      " 文件目录管理
Plug 'easymotion/vim-easymotion',{'on':'<Plug>(easymotion-s2)'}          " 屏幕内跳转
Plug 'tpope/vim-commentary',{'on':'Commentary'}                          " 一键注释
Plug 'tpope/vim-surround'                                                " 成对操作
Plug 'majutsushi/tagbar',{'on':'TagbarToggle'}                           " 代码大纲
Plug 'tpope/vim-fugitive',{'on':'Gblame'}                                " 集成 git 命令
Plug 'airblade/vim-gitgutter'                                            " 显示 git 文件变动
Plug 'neoclide/coc.nvim', {'branch': 'release'}                          " 代码补全

Plug 'junegunn/vim-easy-align',{'on':'<Plug>(EasyAlign)'}                " 一键对齐
Plug 'cvuuhk/vim-snippets'                                               " 片段仓库
" 其他不错的主题{{{
" Plug 'kabbamine/yowish.vim'                                              " 主题
" Plug 'junegunn/seoul256.vim'                                             " 主题
" Plug 'morhetz/gruvbox'                                                   " 主题
" }}}
call plug#end()

" colorscheme {{{
colorscheme one
if (has("nvim"))
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
set termguicolors
endif

" call one#highlight('Normal','none','none','none')
call one#highlight('Folded','5c6370','none','none')
call one#highlight('DiffAdd','','none', '')
call one#highlight('DiffChange','','none', '')
call one#highlight('DiffDelete','','none', '')
call one#highlight('DiffText','','none', '')
call one#highlight('DiffAdded','','none', '')
call one#highlight('DiffFile','','none', '')
call one#highlight('DiffNewFile','','none', '')
call one#highlight('DiffLine','','none', '')
call one#highlight('DiffRemoved','','none', '')
" }}}
" vim-airline{{{
let g:airline_theme='one'
" }}}
" nerdtree{{{
nnoremap <leader>v :NERDTreeFind<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.git$','\.pyc$','__pycache__$']
" }}}
" easymotion {{{
nmap <leader>s <Plug>(easymotion-s2)
vmap <leader>s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1
" }}}
" vim-commentary {{{
nnoremap <leader>c :Commentary<CR>
vnoremap <leader>c :Commentary<CR>
" }}}
" tagbar {{{
nnoremap <leader>t :TagbarToggle<CR>
" }}}
" vim-fugitive {{{
noremap <leader>gb :Gblame<CR>
" }}}
" vim-gitgutter {{{
set updatetime=50 " 50ms，更新更及时
" }}}
" coc.nvim {{{
set hidden " if hidden is not set, TextEdit might fail.
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
" don't give |ins-completion-menu| messages.
set shortmess+=c
set signcolumn=yes " always show signcolumns
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')

" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>}}}
" python-mode {{{
"开启警告
let g:pymode_warnings = 0
"保存文件时自动删除无用空格
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
"显示允许的最大长度的列
let g:pymode_options_colorcolumn = 0
"设置QuickFix窗口的最大，最小高度
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 10
"使用python3
let g:pymode_python = 'python3'
"使用PEP8风格的缩进
let g:pymode_indent = 1
"取消代码折叠
let g:pymode_folding = 0
"开启python-mode定义的移动方式
let g:pymode_motion = 1
"启用python-mode内置的python文档，使用K进行查找
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
"自动检测并启用virtualenv
let g:pymode_virtualenv = 1
"不使用python-mode运行python代码
let g:pymode_run = 1
"let g:pymode_run_bind = '<Leader>r'
"不使用python-mode设置断点
let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_bind = '<leader>b'
"启用python语法检查
let g:pymode_lint = 1
"修改后保存时进行检查
let g:pymode_lint_on_write = 0
"编辑时进行检查
let g:pymode_lint_on_fly = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
"发现错误时不自动打开QuickFix窗口
let g:pymode_lint_cwindow = 0
"侧边栏不显示python-mode相关的标志
let g:pymode_lint_signs = 0
"let g:pymode_lint_todo_symbol = 'WW'
"let g:pymode_lint_comment_symbol = 'CC'
"let g:pymode_lint_visual_symbol = 'RR'
"let g:pymode_lint_error_symbol = 'EE'
"let g:pymode_lint_info_symbol = 'II'
"let g:pymode_lint_pyflakes_symbol = 'FF'
"启用重构
let g:pymode_rope = 0
"不在父目录下查找.ropeproject，能提升响应速度
let g:pymode_rope_lookup_project = 0
"光标下单词查阅文档
let g:pymode_rope_show_doc_bind = '<C-c>d'
"项目修改后重新生成缓存
let g:pymode_rope_regenerate_on_write = 1
"开启补全，并设置<C-Tab>为默认快捷键
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion_bind = '<C-Tab>'
"<C-c>g跳转到定义处，同时新建竖直窗口打开
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_rope_goto_definition_cmd = 'vnew'
"重命名光标下的函数，方法，变量及类名
let g:pymode_rope_rename_bind = '<C-c>rr'
"重命名光标下的模块或包
let g:pymode_rope_rename_module_bind = '<C-c>r1r'
"开启python所有的语法高亮
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
"高亮缩进错误
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"高亮空格错误
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" }}}
" vim-easy-align {{{
xmap <leader>al <Plug>(EasyAlign)
nmap <leader>al <Plug>(EasyAlign)
" }}}
