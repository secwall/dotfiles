set tabstop=4
set shiftwidth=4
set smarttab
set et

set wrap
set showbreak=\ \ \ \ \ \ >
hi NonText guifg=#0030ff ctermfg=green

set ai
set cin

set backspace=2
set wrapmargin=5

set statusline=%t\ %y%m%r[%{&fileencoding}]%<[%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P
set laststatus=2

set foldenable
set foldmethod=indent

set showmatch
set hlsearch
set incsearch
set ignorecase

set listchars=tab:··
set list

if has("gui_running")
    colorscheme grb256

    set guioptions-=T
    set guioptions-=m
    set guioptions-=l
    set guioptions-=r
    set guioptions-=b

    set guifont=Monospace\ 10
else
    colorscheme evening
endif
set colorcolumn=80

set pastetoggle=<F2>

set number
syntax on

filetype on
filetype plugin on
