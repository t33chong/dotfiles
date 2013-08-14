set nocompatible

syntax on
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
autocmd BufRead,BufNewFile *.py inoremap # X<C-h>#
colorscheme candycode

set gfn=Menlo:h12
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smartindent
set autoindent

set hlsearch
set incsearch
set showmatch

set number

filetype on
filetype plugin on

autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <C-space> <C-x><C-o>

inoremap <S-tab> <C-d>

"set colorcolumn=80

set noeb vb t_vb=

nnoremap <S-esc> :noh<CR>

"let current_file = expand('%:p')
"autocmd BufRead,BufNewFile * ! 'echo -ne "\033]0;' . current_file . '\007"'<CR>
