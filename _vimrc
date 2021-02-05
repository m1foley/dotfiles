set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-dispatch'
  let g:dispatch_quickfix_height=25
  let g:dispatch_tmux_height=25
Plug 'tpope/vim-abolish'
" software capslock: <C-g>c in insert mode
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'vim-scripts/LargeFile'
  let g:LargeFile=1.5 "MB
Plug 'yegappan/greplace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
  let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-o': 'split', 'ctrl-v': 'vsplit' }
  let g:fzf_layout = { 'down': '~60%' }
  command! FZFMru call fzf#run(fzf#wrap({ 'source': v:oldfiles }))
  nnoremap <silent> <C-p> :FZF<CR>
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bruno-/vim-all'
" Arrow keys move visual select blocks
Plug 'zirrostig/vim-schlepp'
  vmap <up>    <Plug>SchleppUp
  vmap <down>  <Plug>SchleppDown
  vmap <left>  <Plug>SchleppLeft
  vmap <right> <Plug>SchleppRight
  let g:Schlepp#allowSquishingBlock = 1
  let g:Schlepp#allowSquishingLines = 1
Plug 'justinmk/vim-gtfo'
Plug 'christoomey/vim-tmux-navigator'
 let g:tmux_navigator_no_mappings = 1
 nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
 nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" Arrow keys resize window
Plug 'talek/obvious-resize'
  let g:obvious_resize_default=5
  nnoremap <silent> <up> :<C-U>ObviousResizeUp<CR>
  nnoremap <silent> <down> :<C-U>ObviousResizeDown<CR>
  nnoremap <silent> <left> :<C-U>ObviousResizeLeft<CR>
  nnoremap <silent> <right> :<C-U>ObviousResizeRight<CR>
Plug 'ajh17/Spacegray.vim'
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'simplenote-vim/simplenote.vim'
  source ~/.simplenoterc
  let g:SimplenoteNoteFormat='%N%>[%D]'
  let g:SimplenoteStrftime='%Y-%m-%d %H:%M:%S'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'kopischke/vim-fetch' " jump to line/col
Plug 'machakann/vim-highlightedyank'
Plug 'm1foley/vim-expresso'
Plug 'travisjeffery/vim-auto-mkdir'
Plug 'johngrib/vim-game-code-break'
Plug 'vim-scripts/Align' | Plug 'vim-scripts/SQLUtilities'
  let g:sqlutil_load_default_maps = 0
  command! -range -nargs=* SQLFormat <line1>,<line2> call SQLUtilities#SQLU_Formatter(<q-args>)
Plug 'uptech/vim-ping-cursor'
  let g:ping_cursor_flash_milliseconds = 150
Plug 'tyru/open-browser.vim'
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
Plug 'markonm/traces.vim' " preview substitutions
Plug 'idanarye/vim-merginal'
Plug 'vim-test/vim-test'
  let test#strategy='dispatch'

" language-specific plugins
Plug 'sunaku/vim-ruby-minitest' , { 'for': ['ruby'] }
Plug 'ck3g/vim-change-hash-syntax'
Plug 'hashivim/vim-terraform'
  let g:terraform_fmt_on_save = 1
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
  let g:mix_format_on_save = 1
Plug 'kana/vim-textobj-user' | Plug 'andyl/vim-textobj-elixir'
call plug#end()

set directory=/tmp// "swap files
set backupdir=/tmp,. "tilde files

set statusline=%<%f\ " filename
set statusline+=%-7h " help status
set statusline+=%-4m " modified flag
set statusline+=%-5r " readonly flag
set statusline+=%{fugitive#statusline()}\ " Git status
set statusline+=%=%-14.(%l,%c%V%) " line/column
set statusline+=%30(%=%<%P%) " rulerformat

set number
set ignorecase
set smartcase
set sidescroll=10
set sidescrolloff=2
set lazyredraw
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set shiftround
set splitbelow splitright
set winminheight=0
set mousehide
set visualbell
set guioptions=agmrL "disable gui dialogs
set list " display extra whitespace
set synmaxcol=256
set hlsearch
set incsearch
set shortmess=aoOtT
let g:netrw_liststyle=3 " netrw default to tree view
set diffopt+=vertical,internal,algorithm:patience
set printoptions+=header:0
set tags^=./.git/tags; " ctags support
let g:is_posix=1
let ruby_minlines = 100
set nofoldenable
set guifont=Monaco:h16
set background=dark
colorscheme spacegray

set grepprg=ag\ --smart-case\ --vimgrep\ --path-to-ignore\ ~/.ignore
set grepformat=%f:%l:%c:%m
function! Grep(...)
  " normal mode
  if a:0 > 0
    " strip accidental newlines from visual mode
    let s:grep_term = substitute(a:1, '\n\+$', '', '')
    let s:interpret_as_literal = 1
  " command-line mode
  else
    let s:grep_term = ''
    let s:interpret_as_literal = 0
  endif

  if len(s:grep_term) < 3
    let s:grep_term = input("Search: ")
    let s:interpret_as_literal = 0
  endif

  if len(s:grep_term) >= 3
    if s:interpret_as_literal
      execute 'silent grep! -Q --' shellescape(s:grep_term, 1)
    else
      execute 'silent grep!' s:grep_term
    endif
    copen
    resize 20
  endif
  redraw!
endfunction
nnoremap <silent> \ :call Grep()<CR>
nnoremap <silent> K :call Grep(expand('<cword>'))<CR>
vnoremap <silent> K "gy :call Grep(@g)<CR>:call setreg('g', [])<CR>

" replace functionality of rubocop.vim
function! s:RuboCop(args)
  let l:rubocop_cmd = 'bundle exec rubocop --format emacs'
  if len(a:args)
    let l:rubocop_cmd = l:rubocop_cmd . ' ' . a:args
  else
    let l:rubocop_cmd = '(git diff --name-status; git diff --name-status --cached) | grep -v ^D | cut -f 2 | xargs ' . l:rubocop_cmd
  endif

  let l:rubocop_output  = system(l:rubocop_cmd)
  let l:rubocop_output  = substitute(l:rubocop_output, '\\"', "'", 'g')

  " remove noise from TH projects
  let l:rubocop_output  = substitute(l:rubocop_output, 'Warning: unrecognized cop \(Rails\|Style\)\S\+ found in \S\+[\x0]', '', 'g')
  let l:rubocop_output  = substitute(l:rubocop_output, '\S\+devforce\S\+: `\S\+` is concealed by line \S\+[\x0]', '', 'g')
  let l:rubocop_output  = substitute(l:rubocop_output, '\S\+devforce\S\+: \S\+ has the wrong namespace - should be \S\+[\x0]', '', 'g')

  let l:rubocop_results = split(l:rubocop_output, "\n")
  cexpr l:rubocop_results
  if len(l:rubocop_results)
    copen
  else
    echo 'RuboCop: No offenses detected'
    cclose
  endif
endfunction
command! -complete=file -nargs=? RuboCop :call <SID>RuboCop(<q-args>)

" quickfix: o opens file in split
augroup quickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> o <C-W><CR>
augroup END

" don't open binary files
augroup nonvim
  autocmd!
  autocmd BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc,*.docx,*.rtf bd! | let &ft=&ft | echoerr "Binary file not opened."
augroup end

" make non-ascii chars stand out
autocmd BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
highlight nonascii guibg=Red ctermbg=1 term=standout

" spellcheck git commit messages
autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

" -o = Don't continue comment when hitting o
" +l = Don't break long lines in insert mode
autocmd FileType * set formatoptions-=o formatoptions+=l

" tcsh-style command line
cnoremap <C-A> <Home>
cnoremap <C-F> <S-Right>
cnoremap <C-B> <S-Left>
cnoremap <C-E> <End>

" Typos
cabbrev q1 q!
cabbrev qa1 qa!

nmap Y y$
noremap Q <silent>
noremap ZA :qa!<CR>
" C-e and C-y scroll 3 lines instead of 1
noremap <C-e> 3<C-e>
noremap <C-y> 3<C-y>
" expand %% to current directory in command-line mode
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-r>=expand('%:h').'/'<CR>
" gp selects last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" <C-L> modified from vim-sensible to ping cursor
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>:PingCursor<CR><C-L>

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
nnoremap <Leader><Space> :%s/\s\+$//e<CR>
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
" ,p Plug update
nnoremap <Leader>p :PlugUpdate \| PlugUpgrade<CR>
" ,5 open current file
nnoremap <Leader>5 :!open %<CR>
" ,L git log -p
nnoremap <Leader>L :Git log -p %<CR>
" ,g Fugitive git status
nnoremap <Leader>g :Gstatus<CR>
" ,j format JSON
nnoremap <Leader>j :%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"<CR>:%s/\s\+$//e<CR>:set filetype=json<CR>
" ,f set filetype to ruby
nnoremap <Leader>f :set filetype=ruby<CR>
" ctrl-d in insert/command mode inserts today's date
noremap! <C-d> <C-r>=strftime("%Y-%m-%d")<CR>
" ,h most recently used files
nnoremap <silent> <Leader>h :FZFMru<CR>

" vim-test mappings
nmap <Leader>t :TestFile<CR>
nmap <Leader>ft :TestFile --max-failures 1<CR>
nmap <Leader>s :TestNearest<CR>
nmap <Leader>is :Dispatch iex -S mix test %:<C-r>=line(".")<CR><CR>

nmap <Leader>fs :TestNearest --max-failures 1<CR>
nmap <Leader>l :TestLast<CR>
nmap <Leader>fl :TestLast --max-failures 1<CR>

autocmd Filetype ruby call LoadRubyMaps()
function! LoadRubyMaps()
  set textwidth=80
  " vim-rails mappings
  nnoremap <Leader>r :Rails<CR>
  vnoremap <Leader>r :Rails<CR>
  " ,: update Ruby hash syntax
  vnoremap <silent> <Leader>: :ChangeHashSyntax<CR>
  " ,m memoize a Ruby method
  nmap <Leader>m [mwy$oreturn @0 if defined?(@0)jI@0 = l
endfunction
