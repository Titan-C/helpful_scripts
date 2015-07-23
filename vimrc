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

call vundle#end()
filetype plugin indent on

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc
syntax on				" syntax hightlight
autocmd BufWritePre * :%s/\s\+$//e	" clear trailing whitespace
set number
colorscheme delek
set t_Co=256

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
