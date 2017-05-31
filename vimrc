set tabstop=4
set shiftwidth=4
set smarttab
set et

set noesckeys

" Vundle setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdcommenter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-powerline'

call vundle#end()
filetype plugin indent on

set wrap
set showbreak=\ \ \ \ \ \ >
hi NonText guifg=#0030ff ctermfg=green

set ai
set cin

set backspace=2
set wrapmargin=5

set laststatus=2

set foldenable
set foldmethod=indent

set showmatch
set hlsearch
set incsearch
set ignorecase

set listchars=tab:..
set list

if isdirectory(expand("~/.vim/bundle/vim-colors-solarized"))
    set background=dark
    colorscheme solarized
    set t_Co=256
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
endif

set colorcolumn=80

set pastetoggle=<F2>

set number
syntax on
