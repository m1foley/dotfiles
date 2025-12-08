" TODO: migrate to init.lua
" TODO: Move plugin configurations into separate Lua modules (e.g., `lua/plugins/`, `lua/config/`)
" TODO: Add modern LSP configuration with `nvim-lspconfig`
" TODO: Consider replacing `vim-test` with `neotest`/`neotest-rspec` for better integration

let g:mapleader=','

lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    "tpope/vim-sensible",
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-surround",
    "tpope/vim-eunuch",
    "tpope/vim-repeat",
    "tpope/vim-bundler",
    {
      "tpope/vim-rails",
      dependencies = {"tpope/vim-projectionist"},
    },
    "tpope/vim-characterize",
    "tpope/vim-haml",
    {
      "tpope/vim-dispatch",
      config = function()
        vim.g.dispatch_quickfix_height = 25
        vim.g.dispatch_tmux_height = 25
      end
    },
    "tpope/vim-abolish",
    "tpope/vim-capslock", -- software capslock: <C-g>c in insert mode
    "tpope/vim-endwise",
    "tpope/vim-projectionist",
    "yegappan/greplace",
    {
      "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icon support
      opts = {
        winopts = {
          height = 0.6,
          width = 1.0,
          row = 1,
          border = "rounded",
        },
        files = {
          true,        -- uncomment to inherit all the below in your custom config
          -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
          -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
          -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
          -- ["enter"]       = actions.file_edit_or_qf,
          -- ["ctrl-s"]      = actions.file_split,
          -- ["ctrl-v"]      = actions.file_vsplit,
          -- ["ctrl-t"]      = actions.file_tabedit,
          -- ["alt-q"]       = actions.file_sel_to_qf,
          -- ["alt-Q"]       = actions.file_sel_to_ll,
          -- ["alt-i"]       = actions.toggle_ignore,
          -- ["alt-h"]       = actions.toggle_hidden,
          -- ["alt-f"]       = actions.toggle_follow,
        },
      },
    },
    "AndrewRadev/splitjoin.vim",
    -- <CR> text object for entire buffer
    {
      "vim-utils/vim-all",
      dependencies = { "kana/vim-textobj-user" }
    },
    -- <Space> text object for whitespace
    {
      "vim-utils/vim-space",
      dependencies = { "kana/vim-textobj-user" }
    },
    {
      -- Arrow keys move visual select blocks
      "zirrostig/vim-schlepp",
      keys = {
        { "<up>", "<Plug>SchleppUp", mode = "v" },
        { "<down>", "<Plug>SchleppDown", mode = "v" },
        { "<left>", "<Plug>SchleppLeft", mode = "v" },
        { "<right>", "<Plug>SchleppRight", mode = "v" }
      },
      config = function()
        vim.g.Schlepp_allowSquishingBlock = 1
        vim.g.Schlepp_allowSquishingLines = 1
      end,
    },
    "justinmk/vim-gtfo",
    {
      "talek/obvious-resize",
      config = function()
        vim.g.obvious_resize_default = 5
      end,
      keys = {
        { "<up>", ":<C-U>ObviousResizeUp<CR>", mode = "n", silent = true },
        { "<down>", ":<C-U>ObviousResizeDown<CR>", mode = "n", silent = true },
        { "<left>", ":<C-U>ObviousResizeLeft<CR>", mode = "n", silent = true },
        { "<right>", ":<C-U>ObviousResizeRight<CR>", mode = "n", silent = true },
      },
    },
    "https://git.sr.ht/~ackyshake/spacegray.vim",
    {
      "honza/vim-snippets",
      dependencies = {
        "MarcWeber/vim-addon-mw-utils",
        "tomtom/tlib_vim",
        "SirVer/ultisnips"
      }
    },
    {
      "simplenote-vim/simplenote.vim",
      config = function()
        vim.cmd("source ~/.simplenoterc")
        vim.g.SimplenoteNoteFormat = '%N%>[%D]'
        vim.g.SimplenoteStrftime = '%Y-%m-%d %H:%M:%S'
      end,
    },
    "jeetsukumaran/vim-indentwise",
    "kopischke/vim-fetch", -- jump to line/col
    "machakann/vim-highlightedyank",
    "m1foley/vim-expresso",
    "travisjeffery/vim-auto-mkdir",
    "johngrib/vim-game-code-break",
    {
      "uptech/vim-ping-cursor",
      config = function()
        vim.g.ping_cursor_flash_milliseconds = 100
      end
    },
    {
      "tyru/open-browser.vim",
      config = function()
        vim.g.netrw_nogx = 1
      end,
      keys = {
        { "gx", "<Plug>(openbrowser-smart-search)", mode = "n" },
        { "gx", "<Plug>(openbrowser-smart-search)", mode = "v" },
      },
    },
    "markonm/traces.vim", -- preview substitutions
    {
      "vim-test/vim-test",
      config = function()
        vim.g["test#strategy"] = "dispatch"
        vim.g["test#ruby#rspec#options"] = {
          nearest = "--backtrace --no-color",
          file = "--format documentation --no-color",
          suite = "--no-color --tag ~slow",
        }
      end
    },
    "powerman/vim-plugin-AnsiEsc",
    -- language-specific plugins
    "dense-analysis/ale",
    {
      "paulyeo21/vim-textobj-rspec",
      dependencies = { "kana/vim-textobj-user" }
    },
    "sunaku/vim-ruby-minitest",
    "ck3g/vim-change-hash-syntax",
    {
      "hashivim/vim-terraform",
      config = function()
        vim.g.terraform_fmt_on_save = 1
      end
    },
    "elixir-editors/vim-elixir",
    -- {
    --   "mhinz/vim-mix-format",
    --   config = function()
    --     vim.g.mix_format_on_save = 1
    --   end
    -- },
    {
      "andyl/vim-textobj-elixir",
      dependencies = { "kana/vim-textobj-user" }
    },
    {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "j-hui/fidget.nvim",
      },
      config = function()
        require("codecompanion").setup({
          -- TODO: remove after next version update
          ignore_warnings = true,
          strategies = {
            chat = {
              adapter = "sfdc_eng_ai_model_gateway",
              roles = {llm = "🤖", user = "Me",},
              -- C-s submits to LLM instead of Return
              keymaps = {
                send = {
                  modes = { n = "<C-s>", i = "<C-s>" },
                  opts = {},
                },
                close = {
                  modes = { n = "<C-c>", i = "<C-c>" },
                  opts = {},
                },
              },
              tools = {
                -- Timeout waiting for user input/confirmation (1 hour)
                opts = { wait_timeout = 3600000 },
              },
            },
          },
          adapters = {
            http = {
              sfdc_eng_ai_model_gateway = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                  env = {
                    -- url = "cmd:op read 'op://Private/Salesforce Engineering AI Model Gateway/url'",
                    -- api_key = "cmd:op read 'op://Private/Salesforce Engineering AI Model Gateway/password'",
                    url = "cmd:echo $SFDC_AI_API_HOST",
                    api_key = "cmd:echo $SFDC_AI_API_KEY",
                  },
                  schema = {
                    model = {default = "claude-opus-4-5-20251101"},
                    -- model = {default = "claude-sonnet-4-20250514"},
                    temperature = {default = 0.2},
                    max_completion_tokens = {default = 4096},
                  },
                })
              end,
            },
          },
          display = {
            chat = {
              intro_message = "CodeCompanion ✨ Press ? for options",
              show_header_separator = true,
              show_token_count = false,
            },
          },
        })

        -- CodeCompanion keymaps:
        -- <C-a> opens CodeCompanionActions
        vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
        -- <Leader>a toggles CodeCompanionChat
        vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        -- ga adds the visual selection to CodeCompanionChat
        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

        -- File picker function for CodeCompanion /file references
        local function insert_file_with_picker()
          require('fzf-lua').files({
            prompt = "Select file to reference: ",
            actions = {
              ['default'] = function(selected)
                if selected and #selected > 0 then
                  local file_path = selected[1]
                  vim.api.nvim_put({"/file " .. file_path .. " "}, "c", true, true)
                end
              end
            }
          })
        end

        -- Shortcuts within CodeCompanion chat:
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "codecompanion",
          callback = function()
            -- <C-d> inserts full_stack_dev tool for maximum vibing
            vim.keymap.set("i", "<C-d>", "@{full_stack_dev} ", { buffer = true, noremap = true, silent = true })
            -- <C-b> inserts buffer variable
            vim.keymap.set("i", "<C-b>", "#{buffer} ", { buffer = true, noremap = true, silent = true })
            -- <C-f> opens file picker and inserts /file reference
            vim.keymap.set("i", "<C-f>", insert_file_with_picker, { buffer = true, noremap = true, silent = true })
          end,
        })

        -- AI progress updates
        local progress = require("fidget.progress")
        local FidgetIntegration = {}
        FidgetIntegration.handles = {}
        function FidgetIntegration:store_progress_handle(id, handle)
          self.handles[id] = handle
        end
        function FidgetIntegration:pop_progress_handle(id)
          local handle = self.handles[id]
          self.handles[id] = nil
          return handle
        end
        function FidgetIntegration:create_progress_handle(request)
          return progress.handle.create({
            title = "",
            message = "⏳",
            lsp_client = {name = ""},
          })
        end
        function FidgetIntegration:report_exit_status(handle, request)
          if request.data.status == "success" then
            handle.message = "✔"
          elseif request.data.status == "error" then
            handle.message = " Error"
          else
            handle.message = "󰜺 Cancelled"
          end
        end
        local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})
        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequestStarted",
          group = group,
          callback = function(request)
            local handle = FidgetIntegration:create_progress_handle(request)
            FidgetIntegration:store_progress_handle(request.data.id, handle)
          end,
        })
        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequestFinished",
          group = group,
          callback = function(request)
            local handle = FidgetIntegration:pop_progress_handle(request.data.id)
            if handle then
              FidgetIntegration:report_exit_status(handle, request)
              handle:finish()
            end
          end,
        })
      end
    },
    {
      "LunarVim/bigfile.nvim",
      config = function()
        require("bigfile").setup({
          filesize = 40, -- MB
        })
      end,
    },
  },
  install = { colorscheme = { "habamax" } },
  -- checker = { enabled = true }, -- automatically check for plugin updates
  auto_install = true,
})
EOF

" set directory=.,./.tmp,/tmp//
" set directory=/tmp// "swap files
" set backupdir=/tmp,. "tilde files

set statusline=%<%f\ " filename
set statusline+=%-7h " help status
set statusline+=%-4m " modified flag
set statusline+=%-5r " readonly flag
if exists('*fugitive#statusline')
  set statusline+=%{fugitive#statusline()}\ " Git status
endif
set statusline+=%=%-14.(%l,%c%V%) " line/column
set statusline+=%30(%=%<%P%) " rulerformat

set startofline
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
set mouse= " disable mouse
set mousehide
set visualbell
set list " display extra whitespace
set synmaxcol=256
set hlsearch
set incsearch
set nohidden " don't close an unsaved buffer
set shortmess=aoOtT
let g:netrw_liststyle=3 " netrw default to tree view
" set printoptions+=header:0
set tags^=./.git/tags; " ctags support
let ruby_minlines = 100
let g:markdown_fenced_languages = ['ruby', 'rb=ruby', 'sh', 'bash=sh', 'javascript', 'js=javascript']
set nofoldenable
" set guifont=Monaco:h16
set background=dark
colorscheme spacegray
set termguicolors

let g:python3_host_prog = expand('~/.config/nvim/venv/bin/python')

set grepprg=ag\ --smart-case\ --vimgrep\ --path-to-ignore\ ~/.ignore
set grepformat=%f:%l:%c:%m
function! Grep(...)
  " normal/visual mode
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
      let s:grep_term = shellescape(s:grep_term)
      let s:grep_term = substitute(s:grep_term, '[|#]', '\\\0', 'g')
      execute 'silent grep! -Q --' s:grep_term
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

" ale + standardrb
let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}
let g:ruby_indent_assignment_style = 'variable'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 'never'
let g:ale_lint_on_insert_leave = 'never'
let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1

" recognize heex extention for Elixir templates
autocmd BufRead,BufNewFile *.html.heex set filetype=eelixir
" automatically format when saving Elixir
autocmd BufWritePre *.ex,*.exs Dispatch! mix format %

" quickfix: o opens file in split
augroup quickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> o <C-W><CR>
augroup end

" don't open binary files
augroup nonvim
  autocmd!
  autocmd BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc,*.docx,*.rtf bd! | let &ft=&ft | echoerr "Binary file not opened."
augroup end

" escape ANSI escape sequences in log files
augroup logfile
  autocmd!
  autocmd BufReadPost *.log :AnsiEsc
augroup end

" make non-ascii chars stand out
autocmd BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
highlight nonascii guibg=Red ctermbg=1 term=standout

" spellcheck git commit messages
autocmd BufRead,BufNewFile COMMIT_EDITMSG set spell

" -o = Don't continue comment when hitting o
" +l = Don't break long lines in insert mode
autocmd FileType * set formatoptions-=o formatoptions+=l

" tcsh-style command line
cnoremap <C-A> <Home>
" cnoremap <C-F> <S-Right>
" cnoremap <C-B> <S-Left>
cnoremap <C-E> <End>

" Typos
cabbrev q1 q!
cabbrev qa1 qa!
iabbrev contet context

noremap Q <silent>
noremap ZA :qa!<CR>
" Control key jumps between panes
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
" C-e and C-y scroll 3 lines instead of 1
noremap <C-e> 3<C-e>
noremap <C-y> 3<C-y>
" expand %% to current directory in command-line mode
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-r>=expand('%:h').'/'<CR>
" gp selects last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" <C-l> modified from vim-sensible to ping cursor
nnoremap <silent> <C-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>:PingCursor<CR><C-L>

" ,c replace until next underscore
nnoremap <Leader>c ct_
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
" ,5 !open current file
nnoremap <Leader>5 :!open %<CR>
" ,L git log -p
nnoremap <Leader>L :Git log -p %<CR>
" ,g Fugitive git status
nnoremap <Leader>g :Git<CR>
" ,j format JSON
nnoremap <Leader>j :%!jq .
" nnoremap <Leader>j :%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"<CR>:%s/\s\+$//e<CR>:set filetype=json<CR>
" ,f set filetype to ruby
nnoremap <Leader>f :set filetype=ruby<CR>
" ctrl-r ,d in insert/command mode inserts today's date
inoremap <silent> <C-r><Leader>d <C-r>=strftime("%Y-%m-%d")<CR>
cnoremap <C-r><Leader>d <C-r>=strftime("%Y-%m-%d")<CR>
" <C-p> FZF
nnoremap <C-p> <cmd>lua require('fzf-lua').files()<CR>
" ,h most recently used files
nnoremap <silent> <Leader>h <cmd>lua require('fzf-lua').oldfiles()<CR>
" ,w autopopulate GUS ticket in commit msg
nnoremap <Leader>w /^# Please eO4j/ W-l2yt-{o@0OdipOk

" vim-test mappings
nmap <Leader>t :TestFile<CR>
" TODO: change vim-test options per lanuage
" nmap <Leader>ft :TestFile --max-failures 1<CR>
nmap <Leader>ft :TestFile --fail-fast<CR>
nmap <Leader>s :TestNearest<CR>
nmap <Leader>is :Dispatch iex -S mix test %:<C-r>=line(".")<CR><CR>

" nmap <Leader>fs :TestNearest --max-failures 1<CR>
nmap <Leader>fs :TestNearest --fail-fast<CR>
nmap <Leader>l :TestLast<CR>
" nmap <Leader>fl :TestLast --max-failures 1<CR>
nmap <Leader>fl :TestLast --fail-fast<CR>

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
