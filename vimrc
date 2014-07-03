set tabstop=4
set shiftwidth=4
set smarttab
set et

" Vundle setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdcommenter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
Bundle 'nvie/vim-flake8'
Bundle 'wlangstroth/vim-haskell'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'jimenezrick/vimerl'

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

if isdirectory(expand("~/.vim/bundle/supertab"))
    let g:SuperTabDefaultCompletionType = "context"
    let g:SuperTabContextDefaultCompletionType = "<c-p>"
endif

if isdirectory(expand("~/.vim/bundle/vimerl"))
    let g:erlangManPath="/usr/local/opt/erlang/lib/erlang/man"
    autocmd BufNewFile,BufRead *.erl let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endif

set colorcolumn=80

set pastetoggle=<F2>

set number
syntax on
