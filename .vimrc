set nocompatible
filetype off

" BEGIN VUNDLE
let VundleNotInstalled=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let VundleNotInstalled=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/syntastic'
Bundle 'justone/remotecopy', {'rtp': 'vim/'}
Bundle 'vim-scripts/matchit.zip'
Bundle 'kchmck/vim-coffee-script'

if VundleNotInstalled == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
" END VUNDLE

filetype plugin indent on
syntax on
autocmd FileType py set ft=python
autocmd FileType python set syntax=python
autocmd FileType python let python_highlight_all=1
autocmd FileType python :Python2Syntax
autocmd FileType python inoremap # X<C-h>#
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType rb set ft=ruby
autocmd FileType ruby set syntax=ruby
autocmd BufRead,BufNewFile *.txt set linebreak

colorscheme tristan

set gfn=Menlo:h12
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set smartindent
set autoindent

set hlsearch
set incsearch
set showmatch

set number

inoremap <S-tab> <C-d>

set colorcolumn=80

set noeb vb t_vb=

nnoremap \ :noh<CR>

let &t_Co=256

set ls=2
set ruler

set pastetoggle=<F6>
let mapleader=","

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_html_checkers=['']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_ruby_checkers=['rubocop']

nnoremap <C-w>e :SyntasticCheck<CR>

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

nnoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
vnoremap <silent> [i <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]i <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
onoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
