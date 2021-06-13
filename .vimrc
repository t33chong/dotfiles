set nocompatible
filetype plugin indent on
syntax on

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
set colorcolumn=80
set noeb vb t_vb=
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set clipboard+=unnamed
set diffopt+=vertical
set updatetime=250
set ls=2
set ruler
set cursorline

" This eliminates the hit-enter prompt caused by a long swap file path
set cmdheight=3
autocmd BufEnter * set cmdheight=1

let &t_Co=256
let mapleader="\<Space>"

colorscheme tristan
highlight ColorColumn ctermbg=235
highlight CursorLine ctermbg=235
highlight StatusLine ctermbg=white ctermfg=black
highlight StatusLineNC ctermbg=240 ctermfg=white

" http://ivanbrennan.nyc/blog/2014/10/26/vim-key-mappings/
" http://aperiodic.net/phil/archives/Geekery/term-function-keys.html
" Shift-Enter
set  <F13>=[25~
map  <F13> <S-CR>
map! <F13> <S-CR>

" Alt-/
set  <F14>=[27~
map  <F14> <M-/>
map! <F14> <M-/>

" Alt-Shift-;
set  <F15>=[29~
map  <F15> <M-\>
map! <F15> <M-\>

" Alt-Esc - not currently in use
set  <F16>=[30~
map  <F16> <M-ESC>
map! <F16> <M-ESC>

" Ctrl-Enter
set  <F17>=[31~
map  <F17> <C-CR>
map! <F17> <C-CR>

" Alt-,
set  <F18>=[32~
map  <F18> <M-,>
map! <F18> <M-,>

" Alt-Shift-,
set  <F19>=[33~
map  <F19> <M-`>
map! <F19> <M-`>

" Alt-;
set  <F20>=[34~
map  <F20> <M-;>
map! <F20> <M-;>

" Shift-Tab
set  <F21>=[16~
map  <F21> <S-TAB>
map! <F21> <S-TAB>

" Ctrl-Shift-Tab
set  <F22>=[22~
map  <F22> <C-S-TAB>
map! <F22> <C-S-TAB>

" Ctrl-Tab
set  <F23>=[35~
map  <F23> <C-TAB>
map! <F23> <C-TAB>

nnoremap <silent> \ :noh<CR>
nnoremap <silent> \| :set noro<CR>

nnoremap ' `
vnoremap ' `

" Retain cursor position after yanking a visual block
vmap y ygv<Esc>
nnoremap , :
vnoremap , :

nnoremap J j<C-e>
nnoremap K k<C-y>
vnoremap J j<C-e>
vnoremap K k<C-y>
noremap <Leader>J J
noremap <Leader>K K

nnoremap G Gzb
vnoremap G Gzb

nnoremap <C-f> <C-f>Lzb``
vnoremap <C-f> <C-f>Lzb``

" Autocomplete text
inoremap <S-TAB> <C-n>
inoremap <C-S-TAB> <C-p>
inoremap <C-TAB> <C-d>

inoremap <M-,> <ESC>A,
inoremap <M-`> <ESC>jA,
inoremap <M-;> <ESC>A;
inoremap <M-\> <ESC>jA;

nnoremap <M-,> <ESC>A,
nnoremap <M-`> <ESC>jA,
nnoremap <M-;> <ESC>A;
nnoremap <M-\> <ESC>jA;

nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-l> :wincmd l<cr>

" Can't remember what this does
nnoremap <C-x> <C-w>c

" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> <Leader>v '`[' . strpart(getregtype(), 0, 1) . '`]'

" When editing a file, always jump to the last known cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd FileType git,gitcommit set textwidth=72 colorcolumn=72

autocmd FileType py set ft=python
autocmd FileType python let g:python_highlight_all=1
autocmd FileType python set syntax=python
autocmd FileType python inoremap # X<C-h>#
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType python inoremap <M-;> <ESC>A:<CR>
autocmd FileType python nnoremap <M-;> <ESC>A:<CR>

function! RubyMethodFold(line)
  let line_is_method_or_end = synIDattr(synID(a:line,1,0), 'name') == 'rubyMethodBlock'
  let line_is_def = getline(a:line) =~ '\s*def '
  return line_is_method_or_end || line_is_def
endfunction
autocmd FileType rb set ft=ruby
autocmd FileType ruby set syntax=ruby
autocmd FileType ruby set foldexpr=RubyMethodFold(v:lnum)
autocmd FileType ruby set foldmethod=expr

autocmd FileType tf set indentexpr=

autocmd BufRead,BufNewFile *.txt,*.md set linebreak
autocmd BufRead,BufNewFile *.ex,*.exs set ft=elixir
autocmd BufRead,BufNewFile *.sbt set ft=scala
autocmd BufRead,BufNewFile *.jbuilder set ft=ruby
autocmd BufRead,BufNewFile *.zsh-theme set ft=zsh
autocmd BufRead,BufNewFile *.jsonl set ft=json

autocmd FileType qf call AdjustWindowHeight(1, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function CheckSwap()
  swapname
  if v:statusmsg =~ '\.sw[^p]$'
    set ro
  endif
endfunc
if &swf
  set shm+=A
  autocmd BufReadPre * call CheckSwap()
endif

" http://stackoverflow.com/questions/12091497/how-to-get-notified-when-file-is-changed-by-another-application
autocmd CursorMoved,CursorMovedI * checktime
autocmd FileChangedShell * set statusline^=!!!\ 

command CopyPath :!echo -n % | pbcopy

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

" Show git diff in gutter
Bundle 'airblade/vim-gitgutter'
set signcolumn=yes

" Toggle code blocks between single- and multi-line: gJ gS
Bundle 'AndrewRadev/splitjoin.vim'

" Jump between matching symbols and words: %
Bundle 'andymass/vim-matchup'
let g:matchup_matchparen_status_offscreen = 0

" Navigate inside camel or snake case terms: <Leader>w/b/e/ge
Bundle 'bkad/CamelCaseMotion'
call camelcasemotion#CreateMotionMappings('<Leader>')

" Jump to a specific character with ;
Bundle 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap ; <Plug>(easymotion-bd-f)
vmap ; <Plug>(easymotion-bd-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" See register contents: " @ in normal, <C-r> in insert
Bundle 'junegunn/vim-peekaboo'

" Highlight yanked text
Bundle 'machakann/vim-highlightedyank'
map y <Plug>(highlightedyank)
" FIXME: Why doesn't this highlight the selection?
nnoremap Y yg_

" Expand abbreviations to HTML and navigate: <C-y>, <C-y>n
Bundle 'mattn/emmet-vim'

" Defines text objects: ai aI ii iI
Bundle 'michaeljsmith/vim-indent-object'

" Search a codebase
Bundle 'mileszs/ack.vim'
let g:ackprg = 'ag --path-to-ignore ~/.agignore --nogroup --nocolor --column'
let g:ackhighlight = 1
let g:ackpreview = 1

" Label buffer tabs
Bundle 'mkitt/tabline.vim'

" " Highlight indentation levels
" Bundle 'nathanaelkane/vim-indent-guides'
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_auto_colors = 0
" let g:indent_guides_guide_size = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237

" Automatically close quotes/parens
" <Tab> = delimitmate#shouldjump /
" <S-Tab> = autocomplete forward
" <C-S-Tab> = autocomplete back
" <S-CR> = delimitmate#jumpmany /
" <C-Tab> = dedent
Bundle 'raimondi/delimitMate'
autocmd FileType ruby let b:delimitMate_quotes = "\" ' ` |"
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
inoremap <expr> <Tab> delimitMate#ShouldJump() ?
      \ "\<C-R>=delimitMate#JumpAny()<CR>" :
      \ "\<Tab>"
inoremap <expr> <S-CR> delimitMate#JumpMany()
inoremap <NUL> <Tab>

" Required for vac script, I think
Bundle 'ronakg/quickr-preview.vim'
let g:quickr_preview_keymaps = 0
autocmd FileType qf nmap <Tab> <Plug>(quickr_preview)
autocmd FileType qf nmap q <Plug>(quickr_preview_qf_close)

" Explore the filesystem
Bundle 'scrooloose/nerdtree'
nnoremap <silent> <Leader><Tab> :NERDTreeToggle<CR>

" Syntax checker
Bundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_html_checkers=['']
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }
nnoremap <Leader>c :SyntasticCheck<CR>
nnoremap <Leader>C :SyntasticToggle<CR>

" Next/prev/skip/all: <C-n> <C-p> <C-x> <C-a>
Bundle 'terryma/vim-multiple-cursors'
let g:multi_cursor_select_all_word_key = '<C-a>'
let g:multi_cursor_select_all_key      = 'g<C-a>'

" Required for tmux to work with vim-fugitive, vim-gitgutter
Bundle 'tmux-plugins/vim-tmux-focus-events'

" :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or} {despe,sepa}rat{}
" :%Subvert/facilit{y,ies}/building{,s}/g
" Case coercion: crc crs crm cru cr-
Bundle 'tpope/vim-abolish'

" Comment out: gc gcc gcap
Bundle 'tpope/vim-commentary'

" Automatically add `end` in Ruby
Bundle 'tpope/vim-endwise'

" Git wrapper
Bundle 'tpope/vim-fugitive'
function! StatuslineBranch()
  if strlen(fugitive#head()) > 0
    return '(' . fugitive#head() . ') '
  endif
  return ''
endfunction
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit --verbose<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gh :setlocal shellpipe=><CR>:Glog<CR><CR><CR>:copen<CR>:wincmd k<CR>:Gedit<CR>:wincmd j<CR>:echo "Space: open split / q: quit"<CR>
nnoremap <Leader>go :Gread<CR>
command Greview :Git! diff --staged
nnoremap <Leader>gr :Greview<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gy :Gbrowse!<CR>
vnoremap <Leader>gy :Gbrowse!<CR>

" Repeat surround.vim & unimpaired.vim with .
Bundle 'tpope/vim-repeat'

" Enable Gbrowse
Bundle 'tpope/vim-rhubarb'

" Add/delete/change pairs of parens/quotes/tags: ysiw) ds" cst<p>
Bundle 'tpope/vim-surround'

" Previous/next mappings: ]e ]<Space> ]u (url) ]y (escape) ]n (conflict)
" Possible overlap with conflict-marker.vim
Bundle 'tpope/vim-unimpaired'

" Required for gmc script
" Jump between markers: [x ]x
" Resolve conflict with themselves/ourselves/none/both: ct co cn cb
Bundle 't33chong/conflict-marker.vim'
function! NextMergeConflict()
  try
    execute "ConflictMarkerNextHunk"
  catch /conflict not found/
    silent! call NextQuickfix()
  endtry
endfunction
function! NextQuickfix()
  execute "Gwrite"
  try
    " normal ]q
    execute "cnext"
    if winnr("$") < 3
      execute "Gdiff"
    endif
    execute "set noro"
  catch /E553/
    execute "qa"
  endtry
endfunction

" List location & quickfix: <Leader>l <Leader>q
Bundle 'Valloric/ListToggle'

" Highlight indentation levels
Bundle 'Yggdroot/indentLine'
let g:indentLine_color_term = 235
let g:indentLine_char_list = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
" let g:indentLine_first_char = '0'
" let g:indentLine_showFirstIndentLevel = 1

" LANGUAGE-SPECIFIC

" Elixir syntax highlighting
Bundle 'elixir-editors/vim-elixir'

" Go syntax highlighting
Bundle 'fatih/vim-go'

" JavaScript syntax highlighting
Bundle 'jelera/vim-javascript-syntax'

" JSON syntax highlighting
Bundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Automatically expand: {{ {{# {{if {{ife
Bundle 'mustache/vim-mustache-handlebars'
let g:mustache_abbreviations = 1

" Color code brackets
Bundle 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'ctermfgs': [
\     'cyan',
\     'magenta',
\     'green',
\     'blue',
\     'yellow',
\     'red',
\   ]
\ }

" DISABLED

" " Go to the next specified indent level
" Bundle 'jeetsukumaran/vim-indentwise'
" " map [[ <Plug>(IndentWisePreviousEqualIndent)
" " map ]] <Plug>(IndentWiseNextEqualIndent)
" " nunmap <expr> [[
" " nunmap <expr> ]]
" " xunmap <expr> [[
" " xunmap <expr> ]]
" map [< <Plug>(IndentWisePreviousLesserIndent)
" map [[ <Plug>(IndentWisePreviousEqualIndent)
" map [> <Plug>(IndentWisePreviousGreaterIndent)
" map ]< <Plug>(IndentWiseNextLesserIndent)
" map ]] <Plug>(IndentWiseNextEqualIndent)
" map ]> <Plug>(IndentWiseNextGreaterIndent)

" " Fuzzy file finder, requires `brew install fzf`
" Bundle 'junegunn/fzf.vim'
" nnoremap <silent> <Leader><Space> :FZF<CR>
" set rtp+=/usr/local/opt/fzf

" " Show classes and functions in sidebar; requires `brew install ctags`
" Bundle 'majutsushi/tagbar'
" function! SetTagbarWidth()
"   let g:tagbar_width = winwidth('%') - 87
" endfunction
" nnoremap <silent> <Leader>t :call SetTagbarWidth()<CR>:TagbarToggle<CR>
" ctags
" nnoremap <M-/> <C-w>}
" nnoremap <M-/> <C-w>s<C-]>
" nnoremap <silent> <M-/> :set noswf<CR><C-w>s<C-]>:set swf<CR>

" " Parse stack traces and open files in splits
" Bundle 'mattboehm/vim-unstack'

if VundleNotInstalled == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif
" END VUNDLE

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline^=%{StatuslineBranch()}
