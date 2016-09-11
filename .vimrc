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
Bundle 'tmux-plugins/vim-tmux-focus-events'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'junegunn/gv.vim'
" Bundle 'christoomey/vim-conflicted'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/ListToggle'
Bundle 'ronakg/quickr-preview.vim'
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
Bundle 'junegunn/fzf.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'junkblocker/patchreview-vim'
Bundle 'codegram/vim-codereview'
Bundle 'vim-scripts/Tail-Bundle'
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'mkitt/tabline.vim'
Bundle 'justone/remotecopy', {'rtp': 'vim/'}
Bundle 'vim-scripts/matchit.zip'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
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

set colorcolumn=80

set noeb vb t_vb=

set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

set clipboard=unnamed

set diffopt+=vertical

set updatetime=250
" set timeoutlen=1000 ttimeoutlen=10
" set esckeys

nnoremap <silent> \ :noh<CR>
nnoremap <silent> \| :set noro<CR>

nnoremap ' `
vnoremap ' `

" Retain cursor position after yanking a visual block
vmap y ygv<Esc>

let &t_Co=256

set ls=2
set ruler

set pastetoggle=<F6>
let mapleader=";"

map <Leader> <Plug>(easymotion-prefix)

function! StatuslineBranch()
  if strlen(fugitive#head()) > 0
    return '(' . fugitive#head() . ') '
  endif
  return ''
endfunction

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline^=%{StatuslineBranch()}
" set statusline^=%{ConflictedVersion()}

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
autocmd BufRead,BufNewFile *.zsh-theme set ft=zsh

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_html_checkers=['']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

nnoremap <leader>c :SyntasticCheck<CR>
nnoremap <leader>C :SyntasticToggle<CR>

function! SetTagbarWidth()
  let g:tagbar_width = winwidth('%') - 87
endfunction
nnoremap <silent> <leader>t :call SetTagbarWidth()<CR>:TagbarToggle<CR>

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

" nnoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
" nnoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
" vnoremap <silent> [i <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
" vnoremap <silent> ]i <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
" onoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
" onoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>

au FileType qf call AdjustWindowHeight(1, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

let g:ackprg = 'ag --nogroup --nocolor --column'
" let g:ack_autoclose = 1
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

inoremap <expr> <Tab> delimitMate#ShouldJump() ?
      \ "\<C-R>=delimitMate#JumpAny()<CR>" :
      \ "\<Tab>"
inoremap <expr> <S-Tab> delimitMate#ShouldJump() ?
      \ "\<C-R>=delimitMate#JumpMany()<CR>" :
      \ "\<C-d>"

au BufNewFile,BufRead *.html set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
let g:mustache_abbreviations = 1
let g:vim_json_syntax_conceal = 0

au FileType git,gitcommit set textwidth=72 colorcolumn=72

nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gh :setlocal shellpipe=><CR>:Glog<CR><CR><CR>:copen<CR>:wincmd k<CR>:Gedit<CR>:wincmd j<CR>:echo "Space: open split / q: quit"<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>go :Gread<CR>
command Greview :Git! diff --staged
nnoremap <leader>gr :Greview<CR>
nnoremap <leader>gs :Gstatus<CR>

nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-l> :wincmd l<cr>

hi StatusLine ctermbg=white ctermfg=black
hi StatusLineNC ctermbg=240 ctermfg=white

" augroup StatusHighlight
"   autocmd!
"   autocmd WinEnter *
"         \ if winnr('$') > 1 |
"         \   hi StatusLine ctermbg=yellow |
"         \ else |
"         \   hi StatusLine ctermbg=white |
"         \ endif
"   autocmd WinLeave * hi StatusLine ctermbg=white
" augroup END

let g:quickr_preview_keymaps = 0
autocmd FileType qf nmap <Space> <Plug>(quickr_preview)
autocmd FileType qf nmap q <Plug>(quickr_preview_qf_close)

nnoremap <C-x> <C-w>c
nnoremap <silent> <leader><Tab> :NERDTreeToggle<CR>
nnoremap <silent> <leader><Space> :FZF<CR>

nnoremap <leader>d :vsplit<CR>
nnoremap <leader>D :split<CR>

" au FileType conflict nmap <leader>dt :diffget //2<CR>n
" au FileType conflict nmap <leader>dm :diffget //3<CR>n
" au FileType conflict nmap <leader>x :Gwrite<CR>:qa<CR>

set rtp+=/usr/local/opt/fzf

let g:yankring_history_dir = '$HOME/.vim'
let g:yankring_history_file = '.yankring_history'

let g:gitgutter_sign_column_always = 1

let g:patchreview_split_right = 1

command CopyPath :!echo -n % | pbcopy

" http://stackoverflow.com/questions/12091497/how-to-get-notified-when-file-is-changed-by-another-application
autocmd CursorMoved,CursorMovedI * checktime
autocmd FileChangedShell * set statusline^=CHANGED!!!\ 

" Use `gl` and `gu` rather than the default conflicted diffget mappings
let g:diffget_local_map = 'gl'
let g:diffget_upstream_map = 'gu'

function! DiffGet(window)
  execute "diffget //" . a:window
  execute "diffupdate"
  " call NextMergeConflict()
endfunction

" function! NextMergeConflict()
"   normal n
"   if v:warningmsg =~ "^search hit BOTTOM, continuing at TOP"
"     let v:warningmsg = ""
"     call NextQuickFix()
"   endif
" endfunction

function! NextMergeConflict()
  try
    normal n
  catch /E486/
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
  catch /E553/
    execute "qa"
  endtry
endfunction

" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
