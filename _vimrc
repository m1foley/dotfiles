set nocompatible

" TODO: check out:
" https://github.com/wincent/ferret
" mattn/vim-maketable

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
  " TEMP: https://github.com/tpope/vim-dispatch/issues/192
  set shellpipe+=\ 
Plug 'vim-scripts/LargeFile'
  let g:LargeFile=1.5 "MB
Plug 'm1foley/greplace' " waiting for: https://github.com/yegappan/greplace/pull/2
Plug 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_user_command='rg --files %s'
Plug 'JazzCore/ctrlp-cmatcher'
  let g:ctrlp_match_func = { 'match' : 'matcher#cmatch' }
Plug 'rking/ag.vim'
  set grepprg=rg\ --no-heading\ --sort-files\ --with-filename\ --vimgrep
  set grepformat^=%f:%l:%c:%m " vimgrep format
  let g:ag_prg="rg --no-heading --sort-files --with-filename --vimgrep"
  let g:ag_highlight=1
  nmap \\ :Ag<Space>
  " TODO: vim-operator-gsearch
  " vmap \ <Plug>(operator-ag)
  nnoremap K :Ag <cword><CR>
  vnoremap \ "ay:Ag '<C-r>a'<CR>

" function! Rg(search_term)
  " let l:search_term = a:search_term
  " if empty(l:search_term)
  "   let l:search_term = input("Search term: ")
  " endif
  " if empty(l:search_term)
  "   echo 'Empty search term'
  " else
  "   execute 'silent grep' l:search_term | copen
  " endif
  " redraw!
" endfunction

" command! -nargs=? Rg call Rg(<q-args>)
" nmap \\ :Rg<Space>

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
 let g:tmux_navigator_no_mappings = 1
 nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
 nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
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
Plug 'mrtazz/simplenote.vim'
  source ~/.simplenoterc
Plug 'jeetsukumaran/vim-indentwise'
Plug 'kopischke/vim-fetch' " jump to line/col
Plug 'chrisbra/vim-diff-enhanced'
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
Plug 'ngmy/vim-rubocop', { 'on': 'RuboCop' }
  " let g:vimrubocop_rubocop_cmd="bundle exec rubocop"
Plug 'wincent/terminus'
  let g:TerminusMouse=0
  " let g:TerminusCursorShape=0
" flash yanked text
Plug 'kana/vim-operator-user' | Plug 'haya14busa/vim-operator-flashy'
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
Plug 'm1foley/vim-expresso'
Plug 'travisjeffery/vim-auto-mkdir'

" language-specific plugins
Plug 'tpope/vim-endwise', { 'for': ['ruby','sh'] }
Plug 'ck3g/vim-change-hash-syntax'
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
set formatoptions+=lj
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
let g:ruby_indent_end_alignment = 'variable' " Ruby indentation
" let ruby_no_expensive = 0

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
" C-e and C-y scroll 3 lines instead of 1
noremap <C-e> 3<C-e>
noremap <C-y> 3<C-y>
" C-l un-highlights search text before clearing
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
" expand %% to current directory in command-line mode
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-r>=expand('%:h').'/'<CR>
" gp selects last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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
" ,<Space> strip all trailing whitespace from current file
nnoremap <Leader><Space> :%s/\s\+$//<CR>
" ,d diff all
nnoremap <Leader>d :diffthis<CR><C-w><C-w>:diffthis<CR>
" ,D diff off
nnoremap <Leader>D :diffoff<CR><C-w><C-w>:diffoff<CR>
" ,n Simplenote list
nnoremap <Leader>n :SimplenoteList<CR>
" ,y use clipboard register: "+
nnoremap <Leader>y "+
vnoremap <Leader>y "+
" ,<UP> restore arrow keys
nnoremap <silent> <Leader><UP> :nunmap <LT>LEFT>\|nunmap <LT>RIGHT>\|nunmap <LT>DOWN>\|nunmap <LT>UP>\|echo 'Arrow keys restored.'<CR>
" ,w ignore whitespace in diff
nnoremap <Leader>w :set diffopt+=iwhite<CR>
" ,p Plug update
nnoremap <Leader>p :PlugUpdate \| PlugUpgrade<CR>
" ,5 open current file
nnoremap <Leader>5 :!open %<CR>
" ,l git log -p
nnoremap <Leader>l :!git log -p %<CR>

autocmd Filetype ruby call LoadRubyMaps()
function LoadRubyMaps()
  " ,s spec line
  nnoremap <Leader>s :Dispatch bin/rspec <C-r>=expand("%:p")<CR>:<C-r>=line(".")<CR> --format doc<CR>
  " ,S spec file
  nnoremap <Leader>S :Dispatch bin/rspec <C-r>=expand("%:p")<CR> --format doc<CR>
  " ,r rake test file
  nnoremap <Leader>r :Dispatch rake test TEST=<C-r>=expand("%:p")<CR><CR>
  " ,b remote pry
  nnoremap <Leader>b Orequire 'pry'; binding.remote_pry<ESC>
  " ,: update Ruby hash syntax
  nmap vnoremap <silent> <Leader>: :ChangeHashSyntax<CR>
  " ,j ,k jump to next/previous method
  nmap <Leader>j ]m
  nmap <Leader>k [m
  " ,m memoize a Ruby method
  nmap <Leader>m [mwy$oreturn @0 if defined?(@0)jI@0 = l
endfunction
