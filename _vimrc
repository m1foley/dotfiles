set directory=/tmp "swap files
set backupdir=/tmp,. "tilde files

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
Bundle 'vim-scripts/greplace.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'
Bundle 'wincent/Command-T'
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-commentary'
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

" autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.hamlc set filetype=haml

set clipboard=unnamed "share clipboard with OS
set iskeyword+=- "add dash to keywords (for e, b, *)
set number
set ignorecase
set smartcase
set magic
set rulerformat=%30(%=%<%3r%2l,%c\ \ \ %P%)
set undolevels=1000
set formatoptions=cql
set sidescroll=10
set hlsearch
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

" display extra whitespace
set list
" make non-ascii chars stand out
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2

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
" ctrl+n temporarily clears hlsearch
nnoremap <silent> <C-n> :nohlsearch<CR>
" expand %% to current directory in command-line mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" imap <C-CR> <CR><C-o>d0<C-o>>><C-o>>>
inoremap <S-Tab> <C-o><<

nnoremap <Leader>c ct_
nnoremap <Leader>m ]m
vnoremap <Leader>m ]m
nnoremap <Leader>n [m
vnoremap <Leader>n [m
nnoremap <Leader><Bar> 80<Bar>
vnoremap <Leader><Bar> 80<Bar>
nnoremap <Leader>j Jx
",, opens previously edited file
nnoremap <Leader>, <C-^>
",s spec method
nnoremap <Leader>s :!bundle exec rspec <C-R>=expand("%:p")<CR> --format nested -c -l <C-R>=line(".")<CR><CR>
",S spec file
nnoremap <Leader>S :!bundle exec rspec <C-r>=expand("%:p")<CR> --format nested -c<CR>
" ,<Space> strips all trailing whitespace from current file
nnoremap <Leader><Space> :%s/\s\+$//<CR>
" ,d = diff all
nnoremap <Leader>d :diffthis<CR><C-w><C-w>:diffthis<CR>
" ,D = diff off
nnoremap <Leader>D :diffoff<CR><C-w><C-w>:diffoff<CR>
nnoremap <Leader>o :!git checkout %<CR><CR>
