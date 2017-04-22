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
Plugin 'nvie/vim-flake8'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rust-lang/rust.vim'
Plugin 'fatih/vim-go'

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

if isdirectory(expand("~/.vim/bundle/YouCompleteMe"))
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_rust_src_path="/Users/secwall/Documents/dev/repos/rust/src"
endif

set colorcolumn=80

set pastetoggle=<F2>

set number
syntax on
