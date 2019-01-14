" TODO: check out:
" https://github.com/dyng/ctrlsf.vim
" https://github.com/maralla/completor.vim
" https://github.com/wincent/ferret
" https://github.com/mattn/vim-maketable

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
  let g:dispatch_quickfix_height=20
  let g:dispatch_tmux_height=20
  " TEMP: https://github.com/tpope/vim-dispatch/issues/192
  set shellpipe+=\ 
Plug 'tpope/tpope-vim-abolish'
" software capslock: <C-g>c in insert mode
Plug 'tpope/vim-capslock'
Plug 'vim-scripts/LargeFile'
  let g:LargeFile=1.5 "MB
Plug 'yegappan/greplace'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  nnoremap <C-p> :Files<CR>

  set grepprg=rg\ --vimgrep\ --sort-files
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  function! MySearch()
    let grep_term = input("Search: ")
    if !empty(grep_term)
      execute 'silent grep!' grep_term | copen
      redraw!
    endif
  endfunction
  command! Search call MySearch()
  nnoremap \ :Search<CR>
  nnoremap K :Search<CR><cword><CR>
  vnoremap K "ay :Search<CR>'<C-r>a'<CR>

  " :Rg = Global search that can be further filtered in real time
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bruno-/vim-all'
Plug 'zirrostig/vim-schlepp'
  " Arrow keys move visual select blocks
  vmap <unique> <up>    <Plug>SchleppUp
  vmap <unique> <down>  <Plug>SchleppDown
  vmap <unique> <left>  <Plug>SchleppLeft
  vmap <unique> <right> <Plug>SchleppRight
  let g:Schlepp#allowSquishingBlock = 1
  let g:Schlepp#allowSquishingLines = 1
Plug 'justinmk/vim-gtfo'
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
Plug 'mrtazz/simplenote.vim'
  source ~/.simplenoterc
Plug 'jeetsukumaran/vim-indentwise'
Plug 'kopischke/vim-fetch' " jump to line/col
Plug 'ngmy/vim-rubocop', { 'on': 'RuboCop' }
  let g:vimrubocop_rubocop_cmd="bundle exec rubocop"
" flash yanked text
Plug 'kana/vim-operator-user' | Plug 'haya14busa/vim-operator-flashy'
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
Plug 'm1foley/vim-expresso'
Plug 'm1foley/vim-pivotal-tracker-jump'
Plug 'travisjeffery/vim-auto-mkdir'
Plug 'johngrib/vim-game-code-break'
" TEMP until ruby_indent_assignment_style is in the latest MacVim build
Plug 'vim-ruby/vim-ruby'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'vim-scripts/Align' | Plug 'vim-scripts/SQLUtilities'
  let g:sqlutil_load_default_maps = 0
  command! -range -nargs=* SQLFormat <line1>,<line2> call SQLUtilities#SQLU_Formatter(<q-args>)
Plug 'leafgarland/typescript-vim'

" language-specific plugins
Plug 'tpope/vim-endwise', { 'for': ['ruby','sh'] }
Plug 'sunaku/vim-ruby-minitest' , { 'for': ['ruby'] }
Plug 'thoughtbot/vim-rspec', { 'for': ['ruby'] }
  let g:rspec_command = "Dispatch bin/rspec {spec} 2>&1"
Plug 'ck3g/vim-change-hash-syntax'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'chr4/nginx.vim', { 'for': 'nginx' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
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
set formatoptions+=l
set textwidth=80
set sidescroll=10
set sidescrolloff=2
set lazyredraw
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set splitbelow splitright
set winminheight=0
set mousehide
set visualbell
set guioptions=agmrL "disable gui dialogs
set list " display extra whitespace
set synmaxcol=256
set hlsearch
set incsearch
" set pastetoggle=
let g:netrw_liststyle=3 " netrw default to tree view
set diffopt+=vertical,internal,algorithm:patience
set printoptions+=header:0
let g:is_posix=1
let g:ruby_indent_assignment_style = 'variable'
let ruby_minlines = 100

set guifont=Monaco:h16
set background=dark
colorscheme spacegray
" print current color: echo synIDattr(synID(line('.'), col('.'), 1), 'name')

" set foldtext=MyFoldFunction()
" function! MyFoldFunction()
"   let s:line=getline(v:foldstart)
"   let s:numfolded=v:foldend - v:foldstart + 1
"   return '+---' . line . '  ' . numfolded . ' '
" endfunction
set nofoldenable

" don't open binary files
augroup nonvim
  autocmd!
  autocmd BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc*,*.rtf bd! | let &ft=&ft | echoerr "Binary file not opened."
augroup end

" make non-ascii chars stand out
autocmd BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
highlight nonascii guibg=Red ctermbg=1 term=standout

" spellcheck git commit messages
autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

" tcsh-style command line
cnoremap <C-A> <Home>
cnoremap <C-F> <S-Right>
cnoremap <C-B> <S-Left>
cnoremap <C-E> <End>
" set cedit=<C-E>

" Typos
iabbrev particpant participant
iabbrev particpants participants
iabbrev particpant_id participant_id
iabbrev particiapnt participant
iabbrev particiapnts participants
iabbrev particiapnt_id participant_id
iabbrev particpiant participant
iabbrev particpiants participants
iabbrev particpiant_id participant_id
iabbrev particiant participant
iabbrev particiants participants
iabbrev particiant_id participant_id
cabbrev q1 q!
cabbrev qa1 qa!

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
" ,R rake test file
nnoremap <Leader>R :Dispatch rake test TEST=<C-r>=expand("%:p")<CR><CR>

autocmd Filetype ruby call LoadRubyMaps()
function! LoadRubyMaps()
  " vim-rspec mappings
  map <Leader>t :call RunCurrentSpecFile()<CR>
  map <Leader>ft :let g:rspec_command.=' --fail-fast' \| call RunCurrentSpecFile() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>s :call RunNearestSpec()<CR>
  map <Leader>fs :let g:rspec_command.=' --fail-fast' \| call RunNearestSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>l :call RunLastSpec()<CR>
  map <Leader>fl :let g:rspec_command.=' --fail-fast' \| call RunLastSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  " vim-rails mappings
  nnoremap <Leader>r :Rails<CR>
  vnoremap <Leader>r :Rails<CR>
  " ,b remote pry
  nnoremap <Leader>b Orequire 'pry'; binding.remote_pry<ESC>
  " ,: update Ruby hash syntax
  vnoremap <silent> <Leader>: :ChangeHashSyntax<CR>
  " ,m memoize a Ruby method
  nmap <Leader>m [mwy$oreturn @0 if defined?(@0)jI@0 = l
endfunction
