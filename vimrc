set nocompatible

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
" I prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" powerline activate
set laststatus=2

set smartcase       " ignore case if search pattern is all lowercase
set hlsearch        " highlight search
set history=1000    " rememeber commands

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" remap to dvorak movements
noremap r j
noremap t k
noremap n h
noremap s l
