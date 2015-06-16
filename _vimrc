set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-characterize'
Plug 'kana/vim-textobj-user' " required for vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/LargeFile'
Plug 'm1foley/greplace' " waiting for: https://github.com/yegappan/greplace/pull/2
Plug 'kchmck/vim-coffee-script'
Plug 'scrooloose/syntastic'
Plug 'wincent/Command-T'
Plug 'rking/ag.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bruno-/vim-all'
Plug 'gavinbeatty/dragvisuals.vim'
Plug 'justinmk/vim-gtfo'
" Plug 'vim-scripts/SyntaxRange' " required for vimdeck
Plug 'haya14busa/incsearch.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'talek/obvious-resize'
Plug 'ajh17/Spacegray.vim'
Plug 'kana/vim-operator-user' " required for vim-operator-gsearch
Plug 'rgrinberg/vim-operator-gsearch'
Plug 'MarcWeber/vim-addon-mw-utils' " required for snipmate
Plug 'tomtom/tlib_vim' " required for snipmate
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'ck3g/vim-change-hash-syntax'
Plug 'mrtazz/simplenote.vim'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'kopischke/vim-fetch' " jump to line/col
Plug 'evanmiller/nginx-vim-syntax'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'ngmy/vim-rubocop'
call plug#end()

let g:LargeFile=1.5 "MB
set grepprg=ag " greplace searches with Silver Searcher
let g:grep_cmd_opts='--line-numbers --noheading'
let g:agprg="ag --column --case-sensitive"
let g:aghighlight=1 " highlight Ag matches
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

source ~/.simplenoterc " Simplenote credentials

set directory=/tmp "swap files
set backupdir=/tmp,. "tilde files

set statusline=%<%f\ " filename
set statusline+=%-7h " help status
set statusline+=%-4m " modified flag
set statusline+=%-5r " readonly flag
set statusline+=\ %#ErrorMsg#%{SyntasticStatuslineFlag()}%* "syntastic
set statusline+=%=%-14.(%l,%c%V%) " line/column
set statusline+=%30(%=%<%P%) " rulerformat

set iskeyword+=- "add chars to keywords for w/b/e/* etc.
set number
set ignorecase
set smartcase
set magic
set undolevels=1000
set formatoptions=cql
set sidescroll=10
set sidescrolloff=2
set lazyredraw

set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set splitright
set splitbelow
set history=50
set winminheight=0

set mousehide
set visualbell
set guioptions=agmrL "disable gui dialogs
set pastetoggle=<C-_>
set list " display extra whitespace

set guifont=Monaco:h16
set background=dark
" to see what colors are being applied:
" echo synIDattr(synID(line('.'), col('.'), 1), 'name')
colorscheme spacegray

set foldtext=MyFoldFunction()
function! MyFoldFunction()
  let s:line=getline(v:foldstart)
  let s:numfolded=v:foldend - v:foldstart + 1
  return '+---' . line . '  ' . numfolded . ' '
endfunction
set nofoldenable

" don't open binary files
augroup nonvim
  autocmd!
  autocmd BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc*,*.rtf bd! | let &ft=&ft | echoerr "Binary file not opened."
augroup end

" make non-ascii chars stand out
autocmd BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
highlight nonascii guibg=Red ctermbg=1 term=standout

" tcsh-style command line
cnoremap <C-A> <Home>
cnoremap <C-F> <S-Right>
cnoremap <C-B> <S-Left>

set hlsearch
set incsearch
" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" turn off hlsearch after motions
let g:incsearch#auto_nohlsearch=1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" g/ calls motion-wise vim-operator-gsearch
map g/ <Plug>(operator-ag)

" Arrow keys resize window
let g:obvious_resize_default=5
nnoremap <silent> <LEFT> :<C-U>ObviousResizeLeft<CR>
nnoremap <silent> <RIGHT> :<C-U>ObviousResizeRight<CR>
nnoremap <silent> <DOWN> :<C-U>ObviousResizeDown<CR>
nnoremap <silent> <UP> :<C-U>ObviousResizeUp<CR>

" Arrow keys move visual select blocks (dragvisuals.vim)
vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')
let g:DVB_TrimWS=1 " trim whitespace after moving

cabbrev q1 q!
cabbrev qa1 qa!
noremap Y y$
noremap K ""
noremap Q ""
noremap ZA :qa!<CR>
" ^e and ^y scroll 3 lines instead of 1
noremap <C-e> 3<C-e>
noremap <C-y> 3<C-y>
" ctrl+n temporarily clears hlsearch
nnoremap <silent> <C-n> :nohlsearch<CR>
" expand %% to current directory in command-line mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>

let g:mapleader=","

" ,c replace until next underscore
nnoremap <Leader>c ct_
" ,a replace until next capital letter
nnoremap <Leader>a c/[A-Z]<CR>
" ,| go to 80th column
nnoremap <Leader><Bar> 80<Bar>
vnoremap <Leader><Bar> 80<Bar>
" ,, open previously edited file
nnoremap <Leader><Leader> <C-^>
" ,s spec method
nnoremap <Leader>s :Dispatch bundle exec rspec <C-R>=expand("%:p")<CR>:<C-R>=line(".")<CR> --format doc --color<CR>
" ,S spec file
nnoremap <Leader>S :Dispatch bundle exec rspec <C-r>=expand("%:p")<CR>                     --format doc --color<CR>
" ,<Space> strip all trailing whitespace from current file
nnoremap <Leader><Space> :%s/\s\+$//<CR>
" ,d diff all
nnoremap <Leader>d :diffthis<CR><C-w><C-w>:diffthis<CR>
" ,D diff off
nnoremap <Leader>D :diffoff<CR><C-w><C-w>:diffoff<CR>
" ,o git checkout current file
nnoremap <Leader>o :!git checkout %<CR><CR>
" ,: update Ruby hash syntax
vnoremap <Leader>: :ChangeHashSyntax<CR>
" ,= evaluate highlighted expression
vnoremap <Leader>= c<C-r>=<C-r>"<CR><ESC>
" ,p use Patience diff algorithm
nnoremap <Leader>p :EnhancedDiff patience<CR>:diffupdate<CR>
" ,n :next
nnoremap <Leader>n :next<CR>
" ,y "*
nnoremap <Leader>y "*
vnoremap <Leader>y "*
