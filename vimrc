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

inoremap <C-s> <ESC>:w<CR>a
nnoremap <C-s> :w<CR>

autocmd BufNewFile makefile 0r ~/.dotfiles/template/makefile
autocmd BufNewFile *.sh 0r ~/.dotfiles/template/bashScript

if (has("nvim"))
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
set termguicolors
endif

call plug#begin()
Plug 'rakr/vim-one'                                                      " 主题
Plug 'vim-airline/vim-airline'                                           " 强化状态栏
Plug 'yggdroot/indentline'                                               " 显示代码缩进线条

Plug 'lilydjwg/fcitx.vim'                                                " 输入法自动切换
Plug 'jiangmiao/auto-pairs'                                              " 括号自动补全
Plug 'dense-analysis/ale'                                                " 实时语法检查
Plug 'tpope/vim-fugitive'                                                " git 插件
Plug 'preservim/nerdtree'                                                " 文件管理
Plug 'tpope/vim-commentary',{'on':'Commentary'}                          " 一键注释
Plug 'junegunn/vim-easy-align',{'on':'<Plug>(EasyAlign)'}                " 一键对齐
Plug 'neoclide/coc.nvim', {'branch': 'release'}                          " 代码补全
" Plug 'cvuuhk/vim-snippets'                                               " 片段仓库
" 其他不错的主题{{{
" Plug 'kabbamine/yowish.vim'                                              " 主题
" Plug 'junegunn/seoul256.vim'                                             " 主题
Plug 'morhetz/gruvbox'                                                   " 主题
" }}}
call plug#end()

" gruvbox {{{
colorscheme gruvbox
" }}}
" vim-one {{{
" colorscheme one

" " call one#highlight('Normal','none','none','none')
" call one#highlight('Folded','5c6370','none','none')
" call one#highlight('DiffAdd','','none', '')
" call one#highlight('DiffChange','','none', '')
" call one#highlight('DiffDelete','','none', '')
" call one#highlight('DiffText','','none', '')
" call one#highlight('DiffAdded','','none', '')
" call one#highlight('DiffFile','','none', '')
" call one#highlight('DiffNewFile','','none', '')
" call one#highlight('DiffLine','','none', '')
" call one#highlight('DiffRemoved','','none', '')
" }}}
" vim-airline{{{
let g:airline_theme='one'
" }}}
" nerdtree{{{
nnoremap <leader>v :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.git$','\.pyc$','__pycache__$']
" }}}
" vim-commentary {{{
nnoremap <leader>c :Commentary<CR>
vnoremap <leader>c :Commentary<CR>
" }}}
" vim-gitgutter {{{
set updatetime=50 " 50ms，更新更及时
" }}}
" vim-easy-align {{{
xmap <leader>al <Plug>(EasyAlign)
nmap <leader>al <Plug>(EasyAlign)
" }}}
" coc.nvim {{{
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
" don't give |ins-completion-menu| messages.
set shortmess+=c
set signcolumn=yes " always show signcolumns
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
" }}}
" ale{{{
    " 配合 coc.nvim
    let g:ale_disable_lsp = 1
    " 自定义报错提示符
    let g:ale_sign_error = '×'
    let g:ale_sign_warning = '!'
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1
    " 开启 quickfix
    let g:ale_set_quickfix = 1
    " 自动跳转报错位置
    nmap <silent> <F2> <Plug>(ale_previous_wrap)
    nmap <silent> <F3> <Plug>(ale_next_wrap)
" }}}
