set nocompatible
set directory=/tmp "swap files
set backupdir=/tmp,. "tilde files

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=100

" autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.hamlc set filetype=haml

runtime macros/matchit.vim
" vundle start
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-sensible'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'vim-scripts/LargeFile'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/greplace.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-jdaddy'
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
set number
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

set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
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
set list

:let mapleader = ","
cabbrev q1 q!
cabbrev qa1 qa!
noremap Y y$
noremap K ""
noremap Q ""
noremap ZA :qa!<CR>
" ^e and ^y scroll 2 lines instead of 1
noremap <C-e> 2<C-e>
noremap <C-y> 2<C-y>
" navigate splits more easily
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" expand %% to current directory in command-line mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>

nnoremap <Leader>c ct_
noremap <Leader>m ]m
noremap <Leader>n [m
noremap <Leader><Bar> 80<Bar>
nnoremap <Leader>j Jx
",, opens previously edited file
nnoremap <Leader>, <C-^>
",s spec method
nnoremap <leader>s :!bundle exec rspec <C-R>=expand("%:p")<CR> --format nested -c -l <C-R>=line(".")<CR><CR>
",S spec file
nnoremap <leader>S :!bundle exec rspec <C-r>=expand("%:p")<CR> --format nested -c<CR>
" ,<Space> strips all trailing whitespace from current file
nnoremap <Leader><Space> :%s/\s\+$//<CR>
nnoremap <Leader>d :diffthis<CR><C-w><C-w>:diffthis<CR>
nnoremap <Leader>D :diffoff<CR><C-w><C-w>:diffoff<CR>
nnoremap <leader>o :!git checkout %<CR><CR>
