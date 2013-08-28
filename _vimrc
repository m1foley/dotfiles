set nocompatible
set directory=/tmp "swap files
set backupdir=/tmp,. "tilde files

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=100

runtime macros/matchit.vim
" vundle start
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-repeat'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'vim-scripts/LargeFile'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/greplace.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'kchmck/vim-coffee-script'
" required for snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
filetype plugin indent on
" vundle end

set clipboard=unnamed "share clipboard with OS
set iskeyword+=- "add dash to keywords (for e, b, *)
set nrformats= "number increments
set nonumber
set ignorecase
set smartcase
set magic
set wildmenu
set ruler
set rulerformat=%30(%=%<%3r%2l,%c\ \ \ %P%)
set undolevels=1000
set formatoptions=cql
set sidescroll=10
let g:LargeFile = 1.5 "MB
let g:rubycomplete_rails = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

set backspace=indent,eol,start
set nosmartindent
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set nojoinspaces
set splitright
set splitbelow

set foldtext=MyFoldFunction()
function! MyFoldFunction()
  let line = getline(v:foldstart)
  let lastline = getline(v:foldend)
  let numfolded = v:foldend - v:foldstart + 1
  return '+---' . line . '  ' . numfolded . ' '
endfunction
set nofoldenable

syntax on
set guifont=Monaco:h16
set background=dark
colorscheme koehler
set mousehide
set visualbell
set guioptions=agmrL "disable gui dialogs
set pastetoggle=<F9>

" highlight Error ctermbg=darkgray guibg=#292929
"make non-ascii stand out
highlight link NonAscii Error
syn match NonAscii /[^ -~]/

" Display extra whitespace
set list listchars=tab:»·,trail:·

" syntax highlighting files
au BufRead,BufNewFile *.json set filetype=javascript
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.hamlc set filetype=haml

cabbrev q1 q!
cabbrev qa1 qa!
map Y y$
map K ""
map Q ""
map ZA :qa!<CR>
nmap k gk
nmap j gj
" ^e and ^y scroll 2 lines instead of 1
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" navigate splits more easily
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" expand %% to current directory in command-line mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>

:let mapleader = ","
",r generates comments in routes.rb
" map <Leader>r :update<CR>:!annotate -r<CR>
map <Leader>r :update<CR>gg/^#== Route Map<CR>jdGo Generated <ESC>:read !date +\%Y-\%m-\%d<CR>kJmr:read !bundle exec rake routes \| sed 's/^/\#/g'<CR>`rjdd
map <Leader>c ct_
map <Leader>m ]m
map <Leader>n [m
map <Leader><Bar> 80<Bar>
map <Leader>j Jx
map <Leader>, <C-^>
" ,<Space> strips all trailing whitespace from current file
nnoremap <Leader><Space> :%s/\s\+$//<CR>
