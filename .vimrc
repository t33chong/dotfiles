set nocompatible

syntax on
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
autocmd BufRead,BufNewFile *.py :Python2Syntax
autocmd BufRead,BufNewFile *.py inoremap # X<C-h>#
colorscheme tristan

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

inoremap <S-tab> <C-d>

"set colorcolumn=80

set noeb vb t_vb=

nnoremap \ :noh<CR>
