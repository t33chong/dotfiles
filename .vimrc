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
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'easymotion/vim-easymotion'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mattn/emmet-vim'
Bundle 'AndrewRadev/splitjoin.vim'
" Bundle 'terryma/vim-multiple-cursors'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'raimondi/delimitmate'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'justone/remotecopy', {'rtp': 'vim/'}
Bundle 'vim-scripts/matchit.zip'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-endwise'
Bundle 'elzr/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'fatih/vim-go'
Bundle 'pangloss/vim-javascript'
Bundle 'mustache/vim-mustache-handlebars'

if VundleNotInstalled == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
" END VUNDLE

filetype plugin indent on
syntax on

colorscheme tristan

set gfn=Menlo:h12
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set smartindent
set autoindent
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set backspace=indent,eol,start

set number

set foldmethod=indent
set nofoldenable

set showcmd

inoremap <S-tab> <C-d>

set colorcolumn=80

set noeb vb t_vb=

set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

set clipboard=unnamed

nnoremap <silent> \ :noh<CR>

nnoremap ' `
vnoremap ' `

" Retain cursor position after yanking a visual block
vmap y ygv<Esc>

let &t_Co=256

set ls=2
set ruler

set pastetoggle=<F6>
let mapleader=","

map <Leader> <Plug>(easymotion-prefix)

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" This eliminates the hit-enter prompt caused by a long swap file path
set cmdheight=3
autocmd BufEnter * set cmdheight=1

" When editing a file, always jump to the last known cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd FileType py set ft=python
autocmd FileType python set syntax=python
autocmd FileType python let python_highlight_all=1
autocmd FileType python :Python2Syntax
autocmd FileType python inoremap # X<C-h>#
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType rb set ft=ruby
autocmd FileType ruby set syntax=ruby
autocmd BufRead,BufNewFile *.txt,*.md set linebreak

function! RubyMethodFold(line)
  let line_is_method_or_end = synIDattr(synID(a:line,1,0), 'name') == 'rubyMethodBlock'
  let line_is_def = getline(a:line) =~ '\s*def '
  return line_is_method_or_end || line_is_def
endfunction

autocmd FileType ruby set foldexpr=RubyMethodFold(v:lnum)
autocmd FileType ruby set foldmethod=expr

autocmd BufRead,BufNewFile *.jbuilder set ft=ruby

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_html_checkers=['']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

nnoremap <leader>l :SyntasticCheck<CR>
nnoremap <leader>L :SyntasticToggle<CR>

function! SetTagbarWidth()
  let g:tagbar_width = winwidth('%') - 85
endfunction
nnoremap <leader>t :call SetTagbarWidth()<CR>:TagbarToggle<CR>

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

au FileType qf call AdjustWindowHeight(1, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ack_autoclose = 1
let g:ackhighlight = 1
let g:ackpreview = 1

func CheckSwap()
  swapname
  if v:statusmsg =~ '\.sw[^p]$'
    set ro
  endif
endfunc

if &swf
  set shm+=A
  au BufReadPre * call CheckSwap()
endif

set cursorline
highlight cursorline ctermbg=235

" vim-indent-guides configuration
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237

noremap <leader>p :YRShow<CR>

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

imap <C-@> <Plug>delimitMateS-Tab
imap <C-_> <Plug>delimitMateJumpMany

let g:mustache_abbreviations = 1
let g:vim_json_syntax_conceal = 0

nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gvdiff<CR>
command Greview :Git! diff --staged
nnoremap <leader>go :Gread<CR>
nnoremap <leader>gr :Greview<CR>
nnoremap <leader>gs :Gstatus<CR>

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-l> :wincmd l<cr>
hi StatusLine ctermbg=yellow
hi StatusLineNC ctermbg=white

nnoremap <leader>d :vsplit<CR>
nnoremap <leader>D :split<CR>
