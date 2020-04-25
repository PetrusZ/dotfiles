" =====================================================================================
"
"       Filename:  vim-tiny.vim
"
"    Description:  vim-tiny配置文件
"
"        Version:  1.0
"        Created:  2018-05-10 14:58
"
"         Author:  Petrus(silencly07@gmail.com)
"      Copyright:  Copyright (c) 2018, Petrus
"
" ====================================================================================
"
"  < 选项设置 >"{{{
" -----------------------------------------------------------------------------
set nocompatible          " 设置不兼容vi
set expandtab             " 设置tab自动转为合适数量的空格
" set tabstop=8             "
set shiftwidth=4          " 设置tab的间隔
set softtabstop=4         " 四个空格代表一个tab
set showmatch             " 在输入括号时光标会短暂地跳到与之相匹配的括号处
set showcmd               " 命令模式下，在底部显示，当前键入的指令
set autoindent            " 设置自动缩进
set smartindent           " 设置智能缩进
set nowrap                " 不自动折行
set textwidth=500         " 文本行宽度超过500时自动加回车换回
set linebreak             " 不在单词中间进行换行
set number                " 设置是否显示行
" set guifont=Monospace\ 11 " 设置字体大小
set encoding=utf-8        " 设置编码为utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,GB18030,cp936,big5,euc-jp,euc-kr,latin1
set helplang=cn           " 帮助中文支持
set mouse=v               " 设置粘贴和复制
set ignorecase            " 设置搜索时忽略大小写
set hlsearch              " 高亮搜索结果
set clipboard=unnamedplus " 设置剪贴板
set foldmethod=marker     " 设置折叠方式为标记折叠
"set foldmethod=indent     " 设置折叠方式为缩进折叠
"set foldlevel=500        " 默认打开所有折叠
set confirm               " 关闭时如果存在未保存的文件出现提示
set scrolloff=5           " 距离顶部或底部还有5行的时候就开始滚动屏幕
set conceallevel=2        " 可隐藏文字等级
set concealcursor=c       " 在什么模式下光标所在行会被隐藏
set updatetime=100        " swp与CursorHold autocmd的更新时间，目前主要用于gitgutter插件更新速度
set wildmenu              " 在编辑命令行时，按补全键后，临时在状态栏位置显示补全提示
set autochdir             " 将当前路径自动切换到当前编辑的文件所在的目录
" set noshowmode            " 关闭mode在cmd中的提示，方便echodoc显示
" set complete-=k complete+=k     "将字典补全添加到默认补全列表中
set completeopt=longest,menu      " 使用弹出菜单来显示可能的补全并显示当前选择补全的额外信息
set timeout timeoutlen=1000 ttimeoutlen=50  " 设置映射延迟为1000ms，键码延迟为50ms

" set vim dir
" // 代表使用绝对路径，避免重名问题
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//

" set viminfo file location
set viminfo+=n~/.vim/.info/viminfo

" persistent undo
if has("persistent_undo")
    set undofile
    set undolevels=500 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer
endif

scriptencoding utf-8

syntax enable
filetype plugin indent on          "开启文件类型插件和缩进识别功能
" -----------------------------------------------------------------------------"}}}
"  < autocmd 配置 >{{{
" -----------------------------------------------------------------------------
" 手动折叠
"autocmd BufWinLeave .vimrc silent mkview      "vimrc文件自动保存折叠
"autocmd BufWinEnter .vimrc silent loadview    "vimrc自动载入折叠

" 设置只在特定的文件类型才折行
" autocmd FileType vimwiki set wrap
" autocmd BufEnter * if &filetype == "" | set wrap | endif
" autocmd BufEnter * if &filetype == "vimwiki" | set wrap | endif

augroup Petrus
    autocmd!

    " 设置文件类型
    autocmd BufRead,BufNewFile .vimperatorrc		set filetype=vim
    autocmd BufRead,BufNewFile *.cron		set filetype=crontab
    " autocmd BufRead,BufNewFile *.conf		set filetype=conf

    autocmd SourcePre $MYVIMRC echomsg 'Loading ' . expand('<afile>') . '!'

    " 可以自动切换到文件所在的目录
    " autocmd BufEnter * :lchdir %:p:h

    " 回到上次编辑的位置
    autocmd BufReadPost *
          \ if ! exists("g:leave_my_cursor_position_alone") |
          \     if line("'\"") > 0 && line ("'\"") <= line("$") |
          \         exe "normal! g'\"" |
          \     endif |
          \ endif
augroup END

" 高亮当前位置(too slow)
" autocmd WinLeave * set nocursorline nocursorcolumn
" autocmd WinEnter * set cursorline nocursorcolumn
" set cursorline "cursorcolumn
" -----------------------------------------------------------------------------"}}}
"  < 键盘映射 配置 >"{{{
" -----------------------------------------------------------------------------
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-c> <c-w>c

" emacs shortcut
inoremap <C-c> <ESC>
inoremap <C-a> <HOME>
inoremap <C-e> <END>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <expr> <C-d> col('.')>strlen(getline('.'))?"\<Lt>C-d>":"\<Lt>Del>"
inoremap <M-f> <S-Right>
inoremap <M-b> <S-Left>
inoremap <M-d> <C-O>dw
inoremap <M-n> <Down>
inoremap <M-p> <Up>

cnoremap <C-a> <HOME>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <expr> <C-d> getcmdpos()>strlen(getcmdline())?"\<Lt>C-d>":"\<Lt>Del>"
cnoremap <M-d> <S-Right><C-W>

" original key
cnoremap <C-X><C-a> <C-a>
cnoremap <C-X><C-f> <C-f>

" w!!强制sudo存储
cmap w!! %!sudo tee >/dev/null %

" set <Leader> key
let g:mapleader="\<space>"
" set <localleader> key
" let localleader="."

" imap <C-l> /*
imap jk <Esc>

" no highlight
map <silent> <leader>h :nohlsearch<CR>

" 快速编辑/重载vimrc
nmap <silent> <leader>ev :edit $MYVIMRC<CR>
nmap <silent> <leader>sv :source $MYVIMRC<CR>
" -----------------------------------------------------------------------------"}}}
"  < 修复功能键 配置 >"{{{
" -----------------------------------------------------------------------------
"execute "set <xUp>=\e[1;*A"
"execute "set <xDown>=\e[1;*B"
"execute "set <xRight>=\e[1;*C"
"execute "set <xLeft>=\e[1;*D"
"execute "set <xHome>=\e[1;*H"
"execute "set <xEnd>=\e[1;*F"
"execute "set <PageUp>=\e[5;*~"
"execute "set <PageDown>=\e[6;*~"
execute "set <F1>=\eOP"
execute "set <F2>=\eOQ"
execute "set <F3>=\eOR"
execute "set <F4>=\eOS"
execute "set <xF1>=\eO1;*P"
execute "set <xF2>=\eO1;*Q"
execute "set <xF3>=\eO1;*R"
execute "set <xF4>=\eO1;*S"
execute "set <F5>=\e[15;*~"
execute "set <F6>=\e[17;*~"
execute "set <F7>=\e[18;*~"
execute "set <F8>=\e[19;*~"
execute "set <F9>=\e[20;*~"
execute "set <F10>=\e[21;*~"
execute "set <F11>=\e[23;*~"
execute "set <F12>=\e[24;*~"

" for i in range(65,90) + range(97,122)
  " let c = nr2char(i)
  " exec "map \e".c." <M-".c.">"
  " exec "map! \e".c." <M-".c.">"
" endfor

function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

command! -nargs=0 -bang VimMetaInit call Terminal_MetaMode(<bang>0)
call Terminal_MetaMode(0)

" A-Z(65-90) and a-z(97-122)
" for UseAlt in range (65 , 90) + range (97 , 122)
        " exe "set <M-" .nr2char(UseAlt).">=\<Esc>" .nr2char(UseAlt)
" endfor
" -----------------------------------------------------------------------------"}}}
" < colorscheme 配置 >"{{{
" -----------------------------------------------------------------------------
set termguicolors         " support true color terminal
set background=dark

" colorscheme tango
" colorscheme yowish
" colorscheme solarized8
" colorscheme flattened_dark

" let g:molokai_original = 1
" let g:rehash256 = 1
" colorscheme molokai

" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox
"
" let g:seoul256_background = 234
" colorscheme seoul256

" 设置背景透明
" highlight Normal guibg=NONE ctermbg=NONE
" -----------------------------------------------------------------------------
