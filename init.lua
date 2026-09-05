-- TODO: Move plugin configurations into separate Lua modules (e.g., `lua/plugins/`, `lua/config/`)

vim.g.mapleader = ','

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
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      event = "InsertEnter",
      config = function()
        local ls = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        vim.keymap.set({ "i", "s" }, "<Tab>", function()
          return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
        end, { expr = true, silent = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
          if ls.jumpable(-1) then ls.jump(-1) end
        end, { silent = true })
      end,
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
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter").install { "ruby", "elixir", "markdown", "markdown_inline" }
      end,
    },
    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "olimorris/neotest-rspec",
        "jfpedroza/neotest-elixir",
      },
      config = function()
        require("neotest").setup({
          adapters = {
            -- Defaults to `bundle exec rspec` (not ./bin/rspec)
            require("neotest-rspec"),
            require("neotest-elixir"),
          },
          -- Populate the quickfix with real file:line entries (jumpable) in the
          -- background; the run mappings open the output panel, and :copen /
          -- :cnext navigate the failures when you want them.
          quickfix = {
            enabled = true,
            open = false,
          },
          -- Custom consumer: auto-close the output panel when a run finishes green.
          -- Registers its own `results` listener (keyed by consumer name), so it
          -- coexists with the built-in quickfix/diagnostic listeners.
          consumers = {
            close_panel_on_success = function(client)
              client.listeners.results = function(_, results, partial)
                if partial then
                  return
                end
                for _, result in pairs(results) do
                  if result.status == "failed" then
                    return -- keep the panel open so failures are visible
                  end
                end
                require("neotest").output_panel.close()
              end
              return {}
            end,
          },
        })
      end,
    },
    "powerman/vim-plugin-AnsiEsc",
    -- language-specific plugins
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "solargraph" },
          automatic_installation = true,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Ruby LSP setup with solargraph
        vim.lsp.config.solargraph = {
          cmd = { "solargraph", "stdio" },
          filetypes = { "ruby" },
          root_markers = { "Gemfile", ".git" },
          capabilities = capabilities,
          settings = {
            solargraph = {
              diagnostics = false, -- Disable to avoid conflicts with standardrb
              completion = true,
              hover = true,
              formatting = false, -- We'll use standardrb for formatting
            }
          }
        }

        -- StandardRB: starts for any Ruby project without .rubocop.yml (default linter)
        vim.lsp.config.standardrb = {
          cmd = { "standardrb", "--lsp" },
          filetypes = { "ruby" },
          root_dir = function(bufnr, cb)
            local root = vim.fs.root(bufnr, { 'Gemfile', '.git' })
            if root and not vim.uv.fs_stat(root .. '/.rubocop.yml') then
              cb(root)
            end
          end,
          capabilities = capabilities,
        }

        -- RuboCop: only starts when .rubocop.yml is found; omitting cb prevents startup
        vim.lsp.config.rubocop = {
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
          filetypes = { "ruby" },
          root_dir = function(bufnr, cb)
            local found = vim.fs.find('.rubocop.yml', {
              upward = true,
              path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
              limit = 1,
            })
            if #found > 0 then cb(vim.fs.dirname(found[1])) end
          end,
          capabilities = capabilities,
        }

        -- Enable all Ruby LSP servers once; root_dir function gates which linter starts
        vim.lsp.enable('solargraph')
        vim.lsp.enable('standardrb')
        vim.lsp.enable('rubocop')

        -- LSP keymaps
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<Leader>F', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })

        -- Configure diagnostics
        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })

        -- Diagnostic signs
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      end
    },
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
          strategies = {
            chat = {
              adapter = "sfdc_eng_ai_model_gateway",
              roles = {llm = "🤖", user = "Me",},
              tools = {
                -- Timeout waiting for user input/confirmation (1 hour)
                opts = { wait_timeout = 3600000 },
                -- Disable approval for read-only tools
                ["read_file"] = {
                  opts = { require_approval_before = false },
                },
                ["file_search"] = {
                  opts = { require_approval_before = false },
                },
                ["grep_search"] = {
                  opts = { require_approval_before = false },
                },
                ["list_code_usages"] = {
                  opts = { require_approval_before = false },
                },
                ["get_changed_files"] = {
                  opts = { require_approval_before = false },
                },
              },
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
            },
          },
          adapters = {
            http = {
              sfdc_eng_ai_model_gateway = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                  env = {
                    url = "cmd:echo $SFDC_AI_API_HOST",
                    api_key = "cmd:echo $SFDC_AI_API_KEY",
                  },
                  schema = {
                    model = {
                      -- https://docs.internal.salesforce.com/ai/express-llm-gateway/home/
                      default = "us.anthropic.claude-sonnet-4-6"
                      -- default = "claude-opus-4-5-20251101"
                      -- default = "us.anthropic.claude-sonnet-4-5-20250929-v1:0"
                    },
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
        -- vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
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
            title = "",
            message = "⏳",
            lsp_client = {name = ""},
          })
        end
        function FidgetIntegration:report_exit_status(handle, request)
          if request.data.status == "success" then
            handle.message = "✔"
          elseif request.data.status == "error" then
            handle.message = " Error"
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


-- Flash cursor line briefly
vim.opt.cursorline = true
-- Highlight cursor line number only
vim.opt.cursorlineopt = "number"
-- vim.keymap.set("n", "<C-l>", function()
--   local old_opt = vim.opt.cursorlineopt:get()
--   vim.opt.cursorlineopt = "both"
--   vim.cmd("redraw")
--   vim.defer_fn(function()
--     vim.opt.cursorlineopt = old_opt
--   end, 150)
-- end, { desc = "Flash cursor line" })

-- set directory=.,./.tmp,/tmp//
-- set directory=/tmp// "swap files
-- set backupdir=/tmp,. "tilde files

-- statusline
local statusline = "%<%f " -- filename
  .. "%-7h" -- help status
  .. "%-4m" -- modified flag
  .. "%-5r" -- readonly flag
if vim.fn.exists('*fugitive#statusline') == 1 then
  statusline = statusline .. "%{fugitive#statusline()} " -- Git status
end
statusline = statusline
  .. "%=%-14.(%l,%c%V%)" -- line/column
  .. "%30(%=%<%P%)" -- rulerformat
vim.opt.statusline = statusline

vim.opt.startofline = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.sidescroll = 10
vim.opt.sidescrolloff = 2
vim.opt.lazyredraw = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.winminheight = 0
vim.opt.mouse = "" -- disable mouse
vim.opt.mousehide = true
vim.opt.visualbell = true
vim.opt.list = true -- display extra whitespace
vim.opt.synmaxcol = 256
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.hidden = false -- don't close an unsaved buffer
vim.opt.shortmess = "aoOtT"
vim.g.netrw_liststyle = 3 -- netrw default to tree view
-- vim.opt.printoptions:append("header:0")
vim.opt.tags:prepend("./.git/tags;") -- ctags support
vim.g.ruby_minlines = 100
vim.g.markdown_fenced_languages = { 'ruby', 'rb=ruby', 'sh', 'bash=sh', 'javascript', 'js=javascript' }
vim.opt.foldenable = false
-- vim.opt.guifont = "Monaco:h16"
vim.opt.background = "dark"
vim.cmd.colorscheme("spacegray")
vim.opt.termguicolors = true

vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/venv/bin/python')

vim.opt.grepprg = "ag --smart-case --vimgrep --path-to-ignore ~/.ignore"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.cmd([[
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
]])
vim.keymap.set('n', '\\', ':call Grep()<CR>', { silent = true })
vim.keymap.set('n', 'K', ":call Grep(expand('<cword>'))<CR>", { silent = true })
vim.keymap.set('v', 'K', '"gy :call Grep(@g)<CR>:call setreg(\'g\', [])<CR>', { silent = true })

-- LSP + standardrb (configured above in lua)
-- vim.g.ruby_indent_assignment_style = 'variable'

-- LSP diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true })
-- vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { silent = true })
-- vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { silent = true })

-- recognize heex extention for Elixir templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html.heex",
  command = "set filetype=eelixir",
})
-- automatically format when saving Elixir
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ex", "*.exs" },
  command = "Dispatch! mix format %",
})

-- quickfix: o opens file in split
local quickfix = vim.api.nvim_create_augroup("quickfix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = quickfix,
  pattern = "qf",
  command = "nnoremap <buffer> o <C-W><CR>",
})

-- don't open binary files
local nonvim = vim.api.nvim_create_augroup("nonvim", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  group = nonvim,
  pattern = { "*.png", "*.jpg", "*.pdf", "*.gif", "*.xls*", "*.ppt*", "*.doc", "*.docx", "*.rtf" },
  command = [[bd! | let &ft=&ft | echoerr "Binary file not opened."]],
})

-- escape ANSI escape sequences in log files
local logfile = vim.api.nvim_create_augroup("logfile", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = logfile,
  pattern = "*.log",
  command = "AnsiEsc",
})

-- make non-ascii chars stand out
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = [[syntax match nonascii "[^\u0000-\u007F]"]],
})
vim.cmd([[highlight nonascii guibg=Red ctermbg=1 term=standout]])

-- spellcheck git commit messages
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "COMMIT_EDITMSG",
  command = "set spell",
})

-- -o = Don't continue comment when hitting o
-- +l = Don't break long lines in insert mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "set formatoptions-=o formatoptions+=l",
})

-- tcsh-style command line
vim.keymap.set('c', '<C-A>', '<Home>')
-- vim.keymap.set('c', '<C-F>', '<S-Right>')
-- vim.keymap.set('c', '<C-B>', '<S-Left>')
vim.keymap.set('c', '<C-E>', '<End>')

-- Typos
vim.cmd([[cabbrev q1 q!]])
vim.cmd([[cabbrev qa1 qa!]])
vim.cmd([[iabbrev contet context]])

vim.keymap.set('', 'Q', '<silent>')
vim.keymap.set('', 'ZA', ':qa!<CR>')
-- Control key jumps between panes
vim.keymap.set('', '<C-k>', '<C-w>k')
vim.keymap.set('', '<C-j>', '<C-w>j')
vim.keymap.set('', '<C-h>', '<C-w>h')
-- C-e and C-y scroll 3 lines instead of 1
vim.keymap.set('', '<C-e>', '3<C-e>')
vim.keymap.set('', '<C-y>', '3<C-y>')
-- expand %% to current directory in command-line mode
-- http://vimcasts.org/episodes/the-edit-command/
vim.keymap.set('c', '%%', "<C-r>=expand('%:h').'/'<CR>")
-- gp selects last paste
vim.keymap.set('n', 'gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })
-- <C-l> modified from vim-sensible to also ping cursor
-- vim.keymap.set('n', '<C-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>:PingCursor<CR><C-L>", { silent = true })

-- ,c replace until next underscore
vim.keymap.set('n', '<Leader>c', 'ct_')
-- ,| go to 80th column
vim.keymap.set('n', '<Leader><Bar>', '80<Bar>')
vim.keymap.set('v', '<Leader><Bar>', '80<Bar>')
-- ,, open previously edited file
vim.keymap.set('n', '<Leader><Leader>', '<C-^>')
-- ,<Space> strip all trailing whitespace from current file
vim.keymap.set('n', '<Leader><Space>', ':%s/\\s\\+$//e<CR>')
-- ,d diff all
vim.keymap.set('n', '<Leader>d', ':diffthis<CR><C-w><C-w>:diffthis<CR>')
-- ,D diff off
vim.keymap.set('n', '<Leader>D', ':diffoff<CR><C-w><C-w>:diffoff<CR>')
-- ,n Simplenote list
vim.keymap.set('n', '<Leader>n', ':SimplenoteList<CR>')
-- ,y use clipboard register: "+
vim.keymap.set('n', '<Leader>y', '"+')
vim.keymap.set('v', '<Leader>y', '"+')
-- ,<UP> restore arrow keys (kept as vimscript for the <LT>/\| escaping)
vim.cmd([[nnoremap <silent> <Leader><UP> :nunmap <LT>LEFT>\|nunmap <LT>RIGHT>\|nunmap <LT>DOWN>\|nunmap <LT>UP>\|echo 'Arrow keys restored.'<CR>]])
-- ,5 !open current file
vim.keymap.set('n', '<Leader>5', ':!open %<CR>')
-- ,L git log -p
vim.keymap.set('n', '<Leader>L', ':Git log -p %<CR>')
-- ,g Fugitive git status
vim.keymap.set('n', '<Leader>g', ':Git<CR>')
-- ,j format JSON
vim.keymap.set('n', '<Leader>j', ':%!jq .')
-- vim.keymap.set('n', '<Leader>j', ':%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"<CR>:%s/\\s\\+$//e<CR>:set filetype=json<CR>')
-- ,f set filetype to ruby
vim.keymap.set('n', '<Leader>f', ':set filetype=ruby<CR>')
-- ctrl-r ,d in insert/command mode inserts today's date
vim.keymap.set('i', '<C-r><Leader>d', '<C-r>=strftime("%Y-%m-%d")<CR>', { silent = true })
vim.keymap.set('c', '<C-r><Leader>d', '<C-r>=strftime("%Y-%m-%d")<CR>')
-- <C-p> FZF
vim.keymap.set('n', '<C-p>', function() require('fzf-lua').files() end)
-- ,h most recently used files
vim.keymap.set('n', '<Leader>h', function() require('fzf-lua').oldfiles() end, { silent = true })
-- ,w autopopulate GUS ticket in commit msg
vim.keymap.set('n', '<Leader>w', "/^# Please e<CR>O<Esc>4j/ W-<CR>l2yt-{o@<C-R>0<Esc>O<Esc>dipO<Esc>k")

-- neotest mappings (Ruby via neotest-rspec, Elixir via neotest-elixir)
-- Runs open the output panel immediately; the quickfix populates in the background (see above).
vim.keymap.set('n', '<Leader>t', function()
  require("neotest").output_panel.clear()
  require('neotest').run.run(vim.fn.expand('%'))
  require('neotest').output_panel.open()
end, { silent = true })
vim.keymap.set('n', '<Leader>ft', function()
  require("neotest").output_panel.clear()
  require('neotest').run.run({ vim.fn.expand('%'), extra_args = { '--fail-fast' } })
  require('neotest').output_panel.open()
end, { silent = true })
vim.keymap.set('n', '<Leader>s', function()
  require("neotest").output_panel.clear()
  require('neotest').run.run()
  require('neotest').output_panel.open()
end, { silent = true })
vim.keymap.set('n', '<Leader>fs', function()
  require("neotest").output_panel.clear()
  require('neotest').run.run({ extra_args = { '--fail-fast' } })
  require('neotest').output_panel.open()
end, { silent = true })
vim.keymap.set('n', '<Leader>l', function()
  require("neotest").output_panel.clear()
  require('neotest').run.run_last()
  require('neotest').output_panel.open()
end, { silent = true })
vim.keymap.set('n', '<Leader>fl', function()
  require("neotest").output_panel.clear()
  require('neotest').run.run_last({ extra_args = { '--fail-fast' } })
  require('neotest').output_panel.open()
end, { silent = true })
-- attach to a running test's process (interactive debuggers: binding.pry, byebug, debug)
vim.keymap.set('n', '<Leader>A', function() require('neotest').run.attach() end, { silent = true })
-- output/summary consumers
vim.keymap.set('n', '<Leader>o', function() require('neotest').output.open({ enter = true }) end, { silent = true })
vim.keymap.set('n', '<Leader>O', function() require('neotest').output_panel.toggle() end, { silent = true })
vim.keymap.set('n', '<Leader>S', function() require('neotest').summary.toggle() end, { silent = true })

-- Ruby-specific mappings (kept as vimscript for the control-char memoize macro)
vim.cmd([[
autocmd Filetype ruby call LoadRubyMaps()
function! LoadRubyMaps()
  set textwidth=80
  " vim-rails mappings
  nnoremap <Leader>r :Rails<CR>
  vnoremap <Leader>r :Rails<CR>
  " ,: update Ruby hash syntax
  vnoremap <silent> <Leader>: :ChangeHashSyntax<CR>
  " ,m memoize a Ruby method
  nmap <Leader>m [mwy$oreturn @0 if defined?(@0)jI@0 = l
endfunction
]])
