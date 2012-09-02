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

colorscheme evening
set colorcolumn=80

set pastetoggle=<F2>

set number
syntax on

filetype on
filetype plugin on

let ropevim_vim_completion = 1
let ropevim_extended_complete = 1
imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>
imap <Nul> <C-R>=RopeCodeAssistInsertMode()<CR>
