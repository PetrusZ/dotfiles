" =====================================================================================
"
"       Filename:  plugin_list.vim
"
"    Description:  vim插件配置文件
"
"        Version:  2.0
"        Created:  2020-02-28 01:23
"
"         Author:  Petrus(silencly07@gmail.com)
"      Copyright:  Copyright (c) 2018, Petrus
"
" ====================================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    execute 'normal! :PlugInstall' | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" info is a dictionary with 3 fields
" - name:   name of the plugin
" - status: 'installed', 'updated', or 'unchanged'
" - force:  set on PlugInstall! or PlugUpdate!
function! BuildYCM(info) abort
  if a:info.status ==# 'installed' || a:info.status ==# 'updated' || a:info.force
    if filewritable('/home/petrus/.vim/plugged/YouCompleteMe/ycm_build') != 2
        !mkdir /home/petrus/.vim/plugged/YouCompleteMe/ycm_build
    endif
    execute 'cd ~/.vim/plugged/YouCompleteMe/ycm_build'
    !cmake -G "Unix Makefiles"  -DUSE_SYSTEM_BOOST=ON -DUSE_PYTHON2=OFF -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp
    !cmake --build . --target ycm_core -- -j9

    if filewritable('/home/petrus/.vim/plugged/YouCompleteMe/regex_build') != 2
        !mkdir /home/petrus/.vim/plugged/YouCompleteMe/regex_build
    endif
    execute 'cd ~/.vim/plugged/YouCompleteMe/regex_build'
    !cmake -G "Unix Makefiles" /home/petrus/.vim/plugged/YouCompleteMe/third_party/ycmd/third_party/cregex
    !cmake --build . --target _regex -j9
  endif
endfunction

function! BuildCCLS(info) abort
  if a:info.status ==# 'installed' || a:info.status ==# 'updated' || a:info.force
    execute 'cd ~/.vim/plugged/ccls/'
    !cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCLANG_LINK_CLANG_DYLIB=1 -DCMAKE_INSTALL_PREFIX="/home/petrus/.local"
    !cmake --build Release -j9
    !cmake --build Release --target install
  endif
endfunction

" for help tags
Plug 'junegunn/vim-plug'

" Fast navigation
Plug 'andymass/vim-matchup'
Plug 'easymotion/vim-easymotion'

" Fast editing
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
" Plug 'terryma/vim-multiple-cursors'

" IDE features
Plug 'Kris2k/A.vim'
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpen' }
Plug 'mbbill/undotree', { 'on': 'UndotreeShow' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTree' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTree' }
Plug 'liuchengxu/vista.vim'
Plug 'brglng/vim-sidebar-manager'
Plug 'ludovicchabant/vim-gutentags' | Plug 'skywind3000/gutentags_plus'| Plug 'skywind3000/vim-preview'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual', 'WhichKeyVisual!']}
Plug 'liuchengxu/vim-which-key'
Plug 'sbdchd/neoformat'
Plug 'dyng/ctrlsf.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/indentLine'
Plug 'Shougo/echodoc.vim'
" 需要配置
" Plug 'sheerun/vim-polyglot'
Plug 'francoiscabrol/ranger.vim'
Plug 'skywind3000/vim-terminal-help'
" Plug 'skywind3000/asyncrun.vim' | Plug 'skywind3000/asynctasks.vim'

" UI
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
" Plug 'edkolev/tmuxline.vim'

" git
Plug 'tpope/vim-fugitive'| Plug 'tpope/vim-rhubarb'| Plug 'junegunn/gv.vim'

" lsp
Plug 'w0rp/ale'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
" 'on': [] -> unload by default
Plug 'MaskRay/ccls', { 'on': [], 'do': function('BuildCCLS') }

" Other Util
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-obsession'
Plug 'bronson/vim-trailing-whitespace'
Plug 'skywind3000/asyncrun.vim'
Plug 'chrisbra/Colorizer'
Plug 'tyru/open-browser.vim'
Plug 'lilydjwg/fcitx.vim'
" Plug 'brglng/vim-im-select'
Plug 'yianwillis/vimcdoc'
" Vim sugar for the UNIX shell commands
Plug 'tpope/vim-eunuch'
Plug 'skywind3000/vim-cppman'
" Plug 'voldikss/vim-translator'

" vimwiki/Org-mode
Plug 'vimwiki/vimwiki'
Plug 'jceb/vim-orgmode'
" Plug 'tpope/vim-speeddating'
" Plug 'mattn/calendar-vim'
" Plug 'tpope/vim-repeat'
Plug 'chrisbra/NrrwRgn'

" colorscheme
" Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
" Plug 'junegunn/seoul256.vim'
" Plug 'KabbAmine/yowish.vim'
" Plug 'tomasr/molokai'
" Plug 'lifepillar/vim-solarized8'
" Plug 'romainl/flattened'

" use vim to write
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

" coc extensions list
let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-ecdict',
            \ 'coc-explorer',
            \ 'coc-git',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-leetcode',
            \ 'coc-marketplace',
            \ 'coc-pairs',
            \ 'coc-python',
            \ 'coc-snippets',
            \ 'coc-tabnine',
            \ 'coc-translator',
            \ 'coc-ultisnips',
            \ 'coc-vimlsp',
            \ 'coc-yank',
            \ ]
