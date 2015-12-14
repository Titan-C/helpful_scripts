set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages Vundle
Plugin 'VundleVim/Vundle.vim'

" bundles installed here
Plugin 'tpope/vim-fugitive'
"Plugin 'klen/python-mode'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'jceb/vim-orgmode'
Plugin 'itchyny/calendar.vim'
Plugin 'vimwiki/vimwiki'

call vundle#end()
filetype plugin indent on

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc
syntax on				" syntax hightlight
autocmd BufWritePre * :%s/\s\+$//e	" clear trailing whitespace
set number
colorscheme delek
set t_Co=256
let mapleader = "\<Space>"

" autocompletion
set wildmode=longest,list,full
set wildmenu

" python configs
" I'm prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" powerline activate
set laststatus=2

let g:calendar_google_calendar = 1
let g:calendar_google_tast = 1

" vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]
let g:vimwiki_use_calendar = 1

set smartcase       " ignore case if search pattern is all lowercase
set hlsearch        " highlight search
set history=1000    " rememeber commands

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" remap to dvorak movements
no r h
no t k
no n j
no s l
