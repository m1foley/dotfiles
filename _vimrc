set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-dispatch'
  let g:dispatch_quickfix_height=20
  let g:dispatch_tmux_height=20
Plug 'vim-scripts/LargeFile'
  let g:LargeFile=1.5 "MB
Plug 'm1foley/greplace' " waiting for: https://github.com/yegappan/greplace/pull/2
Plug 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_user_command='rg --files %s'
Plug 'JazzCore/ctrlp-cmatcher'
  let g:ctrlp_match_func = { 'match' : 'matcher#cmatch' }
Plug 'mhinz/vim-grepper'
  set grepprg=rg\ no-heading\ --vimgrep
  let g:grepper = {}
  let g:grepper.tools = ['rg']
  let g:grepper.prompt = 0
  let g:grepper.highlight = 1
  " remove ignore-case from defaults
  let g:grepper.rg = { 'grepprg': 'rg --no-heading --vimgrep' }
  " backslash for Grepper
  vmap \ <Plug>(GrepperOperator)
  nmap \ <Plug>(GrepperOperator)
  " :Rg or double-backslash for Grepper command
  command! -nargs=+ -bang -complete=file Rg GrepperRg <args>
  nmap \\ :Rg<Space>
  " K searches word
  nnoremap K :GrepperRg <cword><CR>
Plug 'romainl/vim-qf'
  let g:qf_mapping_ack_style = 1
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bruno-/vim-all'
Plug 'gavinbeatty/dragvisuals.vim'
  " Arrow keys move visual select blocks
  vmap <expr> <LEFT> DVB_Drag('left')
  vmap <expr> <RIGHT> DVB_Drag('right')
  vmap <expr> <DOWN> DVB_Drag('down')
  vmap <expr> <UP> DVB_Drag('up')
  let g:DVB_TrimWS=1 " trim whitespace after moving
Plug 'justinmk/vim-gtfo'
Plug 'haya14busa/incsearch.vim'
  set hlsearch
  set incsearch
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
Plug 'christoomey/vim-tmux-navigator'
Plug 'talek/obvious-resize'
  " Arrow keys resize window
  let g:obvious_resize_default=5
  nnoremap <silent> <LEFT> :<C-U>ObviousResizeLeft<CR>
  nnoremap <silent> <RIGHT> :<C-U>ObviousResizeRight<CR>
  nnoremap <silent> <DOWN> :<C-U>ObviousResizeDown<CR>
  nnoremap <silent> <UP> :<C-U>ObviousResizeUp<CR>
Plug 'ajh17/Spacegray.vim'
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsListSnippets="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
Plug 'mrtazz/simplenote.vim', { 'on': ['SimplenoteList','SimplenoteNew'] }
  source ~/.simplenoterc
Plug 'jeetsukumaran/vim-indentwise'
Plug 'kopischke/vim-fetch' " jump to line/col
Plug 'chrisbra/vim-diff-enhanced'
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
Plug 'ngmy/vim-rubocop', { 'on': 'RuboCop' }
  " let g:vimrubocop_rubocop_cmd="bundle exec rubocop"
Plug 'wincent/terminus'
  let g:TerminusMouse=0
  let g:TerminusCursorShape=0
" flash yanked text
Plug 'kana/vim-operator-user' | Plug 'haya14busa/vim-operator-flashy'
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
Plug 'm1foley/vim-expresso'
Plug 'metakirby5/codi.vim', { 'on': 'Codi' }
Plug 'travisjeffery/vim-auto-mkdir'

" language-specific plugins
Plug 'tpope/vim-endwise', { 'for': ['ruby','sh'] }
Plug 'ck3g/vim-change-hash-syntax', { 'on': 'ChangeHashSyntax'}
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'evanmiller/nginx-vim-syntax', { 'for': 'nginx' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
call plug#end()

set directory=/tmp "swap files
set backupdir=/tmp,. "tilde files

set statusline=%<%f\ " filename
set statusline+=%-7h " help status
set statusline+=%-4m " modified flag
set statusline+=%-5r " readonly flag
set statusline+=%=%-14.(%l,%c%V%) " line/column
set statusline+=%30(%=%<%P%) " rulerformat

set iskeyword+=- "add chars to keywords for w/b/e/* etc.
set number
set ignorecase
set smartcase
set formatoptions=cqj
set sidescroll=10
set sidescrolloff=2
set lazyredraw
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set splitright
set splitbelow
set winminheight=0
set mousehide
set visualbell
set guioptions=agmrL "disable gui dialogs
set list " display extra whitespace
set synmaxcol=2048
" set pastetoggle=
let g:netrw_liststyle=3 " netrw default to tree view
set diffopt+=vertical
set printoptions+=header:0

set guifont=Monaco:h16
set background=dark
colorscheme spacegray
" print current color: echo synIDattr(synID(line('.'), col('.'), 1), 'name')

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

cabbrev q1 q!
cabbrev qa1 qa!
noremap Q ""
noremap ZA :qa!<CR>
" ^e and ^y scroll 3 lines instead of 1
noremap <C-e> 3<C-e>
noremap <C-y> 3<C-y>
" Esc/Return clears highlighted search text
nnoremap <silent> <ESC> :nohlsearch<CR><ESC>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
" expand %% to current directory in command-line mode
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-r>=expand('%:h').'/'<CR>

let g:mapleader=','

" ,c replace until next underscore
nnoremap <Leader>c ct_
" ,a replace until next capital letter
nnoremap <Leader>a c/[A-Z]<CR>
" ,| go to 80th column
nnoremap <Leader><Bar> 80<Bar>
vnoremap <Leader><Bar> 80<Bar>
" ,, open previously edited file
nnoremap <Leader><Leader> <C-^>
" ,s spec line
nnoremap <Leader>s :Dispatch bin/rspec <C-r>=expand("%:p")<CR>:<C-r>=line(".")<CR> --format doc --color<CR>
" ,S spec file
nnoremap <Leader>S :Dispatch bin/rspec <C-r>=expand("%:p")<CR> --format doc --color<CR>
" ,r rake test file
nnoremap <Leader>r :Dispatch rake test TEST=<C-r>=expand("%:p")<CR><CR>
" ,b remote pry
nnoremap <Leader>b Orequire 'pry'; binding.remote_pry<ESC>
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
" ,n Simplenote list
nnoremap <Leader>n :SimplenoteList<CR>
" ,y use clipboard register: "+
nnoremap <Leader>y "+
vnoremap <Leader>y "+
" ,<UP> restore arrow keys
nnoremap <silent> <Leader><UP> :nunmap <LT>LEFT>\|nunmap <LT>RIGHT>\|nunmap <LT>DOWN>\|nunmap <LT>UP>\|echo 'Arrow keys restored.'<CR>
" ,w ignore whitespace in diff
nnoremap <Leader>w :set diffopt+=iwhite<CR>
" ,j ,k jump to next/previous method
nmap <Leader>j ]m
nmap <Leader>k [m
" ,p Plug update
nnoremap <Leader>p :PlugUpdate \| PlugUpgrade<CR>
