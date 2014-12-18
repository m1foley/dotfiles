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
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-markdown'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/LargeFile'
" waiting for: https://github.com/yegappan/greplace/pull/2
Plug 'm1foley/greplace'
Plug 'kchmck/vim-coffee-script'
Plug 'scrooloose/syntastic'
Plug 'wincent/Command-T'
Plug 'rking/ag.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bruno-/vim-all'
Plug 'gavinbeatty/dragvisuals.vim'
Plug 'justinmk/vim-gtfo'
Plug 'vim-scripts/SyntaxRange' "for vimdeck
Plug 'haya14busa/incsearch.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'talek/obvious-resize'
Plug 'ajh17/Spacegray.vim'
" required for snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
call plug#end()

let g:LargeFile=1.5 "MB
set grepprg=ag
let g:grep_cmd_opts='--line-numbers --noheading'
let g:agprg="ag --column --case-sensitive"
let g:aghighlight = 1 " highlight Ag matches

set directory=/tmp "swap files
set backupdir=/tmp,. "tilde files

set iskeyword+=- "add chars to keywords for w/b/e/* etc.
set number
set ignorecase
set smartcase
set magic
set rulerformat=%30(%=%<%3r%2l,%c\ \ \ %P%)
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

set foldtext=MyFoldFunction()
function! MyFoldFunction()
  let line = getline(v:foldstart)
  let lastline = getline(v:foldend)
  let numfolded = v:foldend - v:foldstart + 1
  return '+---' . line . '  ' . numfolded . ' '
endfunction
set nofoldenable

syntax enable
set guifont=Monaco:h16
set background=dark
" echo synIDattr(synID(line("."), col("."), 1), "name")
colorscheme spacegray
highlight rubyRailsFilterMethod ctermfg=25
highlight rubyFunction ctermfg=25
highlight rubyDefine ctermfg=24
highlight rubySymbol ctermfg=9
highlight yamlBlockMappingKey ctermfg=25
highlight yamlFlowString ctermfg=35

set mousehide
set visualbell
set guioptions=agmrL "disable gui dialogs
set pastetoggle=<C-h>

" display extra whitespace
set list
" make non-ascii chars stand out
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2

let mapleader = ","

set hlsearch
set incsearch
" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" turn off hlsearch after motions
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Arrow keys move visual select blocks (dragvisuals.vim)
vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')
let g:DVB_TrimWS = 1 " trim whitespace after moving

noremap <silent> <leader>wk :ObviousResizeUp 5<CR>
noremap <silent> <leader>wj :ObviousResizeDown 5<CR>
noremap <silent> <leader>wh :ObviousResizeLeft 5<CR>
noremap <silent> <leader>wl :ObviousResizeRight 5<CR>

cabbrev q1 q!
cabbrev qa1 qa!
noremap Y y$
noremap K ""
noremap Q ""
noremap ZA :qa!<CR>
" ^e and ^y scroll 2 lines instead of 1
noremap <C-e> 2<C-e>
noremap <C-y> 2<C-y>
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
" nnoremap <Leader>s :!bundle exec rspec <C-R>=expand("%:p")<CR> --format doc -c -l <C-R>=line(".")<CR><CR>
nnoremap <Leader>s :Dispatch bundle exec rspec <C-R>=expand("%:p")<CR>:<C-R>=line(".")<CR> --format doc --color<CR>
",S spec file
nnoremap <Leader>S :Dispatch bundle exec rspec <C-r>=expand("%:p")<CR>                     --format doc --color<CR>
" nnoremap <Leader>S :!bundle exec rspec <C-r>=expand("%:p")<CR> --format doc -c<CR>
" ,<Space> strips all trailing whitespace from current file
nnoremap <Leader><Space> :%s/\s\+$//<CR>
" ,d = diff all
nnoremap <Leader>d :diffthis<CR><C-w><C-w>:diffthis<CR>
" ,D = diff off
nnoremap <Leader>D :diffoff<CR><C-w><C-w>:diffoff<CR>
nnoremap <Leader>o :!git checkout %<CR><CR>
