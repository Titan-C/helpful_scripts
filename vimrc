set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Vundle manages Vundle
Plugin 'VundleVim/Vundle.vim'

" bundles installed here
Plugin 'tpope/vim-fugitive'
Plugin 'klen/python-mode'


call vundle#end()
filetype plugin indent on

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc


syntax on				" syntax hightlight
autocmd BufWritePre * :%s/\s\+$//e	" clear trailing whitespace

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
