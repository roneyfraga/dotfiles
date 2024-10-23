
-- General ------------------------------{{{

-- vim.opt options
-- vim.g   geral
-- vim.api api
-- vim.cmd command

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.showmode = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.relativenumber = true
vim.opt.showtabline = 1
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.numberwidth = 1
vim.cmd("set t_ZH=^[[3m")
vim.cmd("set t_ZH=^[[23m")
vim.cmd[[set clipboard+=unnamedplus]]
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.cmd[[highlight Comment cterm=italic]]
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true })
vim.cmd[[set nohlsearch]]

-- }}}

-- Highlight Color  ------------------------------{{{
-- SideBar,StatusBar and Menus
-- Cor da barra lateral quando marcas sao feitas
vim.cmd("highlight SignColumn guibg=none")
vim.cmd("highlight SignColumn ctermbg=none")
vim.cmd("highlight SignatureMarkText ctermbg=none")

-- tabline
vim.cmd("highlight TabLine gui=NONE guibg=NONE guifg=NONE cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE")
vim.cmd("highlight TabLineFill term=NONE cterm=NONE ctermbg=NONE")

-- menu de autocompletar
vim.cmd("highlight Pmenu ctermfg=7 ctermbg=0")
vim.cmd("highlight PmenuSel ctermfg=0 ctermbg=7")

-- }}}

-- Spell check ------------------------------{{{
--
-- dicionario em dois idiomas
vim.cmd("setlocal nospell spelllang=pt,en")

-- alterando a forma como o vim sinaliza as palavras erradas
vim.cmd("hi clear SpellBad")
vim.cmd("hi SpellBad cterm=underline")

-- nao corrigir palavras no inicio da linha em minusculo
vim.cmd("set spellfile=~/Sync/.spell/lowercase.utf-8.add")
vim.cmd("set spellfile=~/Sync/.spell/pt.utf-8.add")
vim.cmd("set spellfile=~/Sync/.spell/en.utf-8.add")
vim.cmd("set spellcapcheck=")

-- control + n
-- utilizar o dicionario como fonte das palavras sugeridas no autocompletar
vim.cmd("set dictionary=/usr/share/dict/words")
vim.cmd("set complete+=kspell")

-- não precisa do nospell, pois, 'spell!' é toggle
-- F2 pt_br
-- F3 en_us
-- F4 pt_br, en_us
--
-- see which-key configs
-- vim.cmd("nmap <F2> :set spell! spelllang=pt<CR>")
-- vim.cmd("nmap <F3> :set spell! spelllang=en<CR>")
-- vim.cmd("nmap <F4> :set spell! spelllang=pt,en<CR>")

-- }}}

-- Plugins ------------------------------{{{

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- marks in the side bar 
Plug('kshenoy/vim-signature')

-- move between vim and tmux with control+hjkl
Plug('christoomey/vim-tmux-navigator')

-- FZF
Plug('ibhagwan/fzf-lua') 
Plug('nvim-tree/nvim-web-devicons')
Plug('msprev/fzf-bibtex')

-- Git
-- Plug('tpope/vim-fugitive')
-- Plug 'stsewd/fzf-checkout.vim'
-- Plug('kdheepak/lazygit.nvim')
-- Plug 'junegunn/gv.vim'

-- Register on side bar: ou @ in normal mode; Control+R in normal mode
Plug('junegunn/vim-peekaboo')

-- comment any file with motion gc[motion] 
Plug('tpope/vim-commentary')

-- repeat vim and plugin commands with .
Plug('tpope/vim-repeat')

-- R  
Plug('R-nvim/R.nvim')
-- Plug('quarto-dev/quarto-nvim')

-- Auto complete
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-cmdline')
Plug('R-nvim/cmp-r')
Plug('kdheepak/cmp-latex-symbols')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
Plug('dcampos/nvim-snippy')
Plug('dcampos/cmp-snippy')
Plug('micangl/cmp-vimtex')
Plug('tamago324/cmp-zsh')
Plug('Shougo/deol.nvim')

-- snippets 
Plug('roneyfraga/vim-snippets')

-- equation preview in markdown
Plug('jbyuki/nabla.nvim')

-- image from clipboad, web or file to neovim
Plug('HakonHarnes/img-clip.nvim')

-- command line on center of screen
Plug('MunifTanjim/nui.nvim')
Plug('rcarriga/nvim-notify')
Plug('folke/noice.nvim')

-- Colorschemes and Statusline
Plug('ellisonleao/gruvbox.nvim')
Plug('nvim-lualine/lualine.nvim')

-- WhichKey menu
Plug('folke/which-key.nvim')
Plug('echasnovski/mini.icons')

-- date and time insertion
Plug('AntonVanAssche/date-time-inserter.nvim')

-- tabular / alinhar texto
Plug('godlygeek/tabular')

-- code formater
Plug('sbdchd/neoformat')

--  Delete buffer withou messing the layout :Bd
Plug('moll/vim-bbye')

-- distraction free :Goyo
Plug('junegunn/goyo.vim')

-- Python, Julia, Go
Plug('jalvesaq/vimcmdline')

-- bracket mappings - quickfix navigation
Plug('tpope/vim-unimpaired')

-- surround a object with (`c` chance, `d` delete, `y` you surround) 
Plug('tpope/vim-surround')

-- wiki 
Plug('vimwiki/vimwiki')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')
Plug('michal-h21/vim-zettel')

-- nerd tree
Plug('nvim-tree/nvim-tree.lua')

-- ChatGPT
-- Plug("MunifTanjim/nui.nvim") -- already instaled
Plug("nvim-lua/plenary.nvim")
Plug("folke/trouble.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("jackMort/ChatGPT.nvim")

vim.call('plug#end')

-- }}}

-- Colorschemes and Status Line --------------------------------------{{{

vim.cmd("set background=dark") -- or light if you want light mode
vim.cmd("colorscheme gruvbox") 

require'lualine'.setup { options = { theme = 'gruvbox' } }

-- }}}

-- Auto complete and Beauty ------------------------------------{{{

-- TreeSitter 
-- :TSInstall r
-- :TSInstall python
-- :TSInstall lua
-- :TSInstall markdown
-- :TSInstall markdown_inline
-- :TSInstall yaml
-- :TSInstall xml
-- :TSInstall html
-- :TSInstall tmux
-- :TSInstall bibtex
-- :TSInstall latex
-- :TSInstall make

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "r", "python", "lua", "vim", "markdown", "markdown_inline", "yaml", "xml", "html", "tmux", "bibtex", "latex", "make"},
  sync_install = false,
  auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = false},
  indent = {enable = true}, 
}

-- snippy
require('snippy').setup({
  mappings = {
    is = {
      ['<Tab>'] = 'expand_or_advance',
      ['<S-Tab>'] = 'previous',
    },
    nx = {
      ['<leader>x'] = 'cut_text',
    },
  },
})

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body) 
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(), 
    ['<C-p>'] = cmp.mapping.select_prev_item(), 
    ['<C-Space>'] = cmp.mapping.complete(), 
    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-c>'] = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
    { name = 'snippy' }, 
    { name = 'cmp_r' },
    { name = 'vimtex' },
    { name = 'nvim_lsp' },
    { name = 'path'},
    { name = 'cmdline' }, 
    { name = 'zsh' }, 
    { name = 'markdown' }, 
    { name = 'markdown_inline' }, 
    { name = 'latex_symbols' }, 
    { name = 'yaml' }, 
  }, {
      { name = 'buffer', keyword_lengh = 5 },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

-- PasteImage image from clipboad, system or web to neovim with img-clip.nvim 
require("img-clip").setup({
    default = {
        dir_path = "./",  
        extension = "png",  -- (opcional)
        file_name = "%Y-%m-%d-%H-%M-%S",  -- (opcional)
        use_absolute_path = false,  
    },
})

-- see which-key
-- vim.cmd[[nnoremap ;p :PasteImage<CR>]]

-- see which-key
-- preview equations with nabla.nvim
-- ;e
-- vim.cmd[[nnoremap ;e :lua require"nabla".toggle_virt()<CR>]]

-- noice: command line on center
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  cmdline = {
    opts = {
      position = { 
        row = "50%", -- posição vertical (50% para centralizar)
        col = "50%", -- posição horizontal (50% para centralizar)
      },
    },
  },
  })

-- see which-key
-- noice: desabilitar mensagens
-- vim.keymap.set('n', ';d', '<cmd>NoiceDismiss<CR>', {desc = 'Dismiss Noice Message'})

-- see which-key
-- \ca close all buffers except the current one
-- vim.cmd[[nnoremap ;ca :w <bar> %bd <bar> e# <bar> bd# <CR>]]

-- }}}

-- R-nvim ------------------------------------{{{
 
-- :RMapsDesc         -- list all commands
-- :RConfigShow       -- list configurations 
--

require("cmp_r").setup({
  filetypes = {"r", "rmd", "quarto"},
  sources = {
    { name = 'cmp_r' },
  }
})

local nvim_lsp = require('lspconfig')

nvim_lsp.r_language_server.setup {
  cmd = { "R", "--slave", "-e", "languageserver::run()" },
  settings = {
    languageserver = {
      diagnostics = {
        globals = { "nvim" }, -- Inclui nvim como global para diagnósticos
      },
    },
  },
}

-- LSP Enable 
function LspEnable()
  require('lspconfig').r_language_server.setup{
  cmd = { "R", "--slave", "-e", "languageserver::run()" },
  }
end

-- LSP Disable
-- vim.lsp.stop_client(vim.lsp.get_active_clients())

-- R.nvim: configurações gerais
require("r").setup({
  -- R_args = {"--quiet", "--no-save"}, 
  min_editor_width = 72, 
  rconsole_width = 78, 
  disable_cmds = { 
    -- "RSPlot",
    "RSaveClose",
  },
  hook = {
    on_filetype = function()
      -- Mapeamentos de teclas específicos para arquivos R
      vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
      vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
      -- vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
      -- vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
    end,
  },
})

-- qmd as rmd
-- to allow snippets in quarto document
-- but disable quarto chunks tags autocompletion
vim.cmd[[autocmd BufRead,BufNewFile *.qmd set ft=rmd.r]]

-- see which-key
-- :Neoformat
-- formatar o código de R
-- seguido de
-- gg=G

-- }}}

-- Markdown VimWiki --------------------------------------{{{
-- 

vim.g.vimwiki_list = {
	{
		path = '~/Wiki',
		syntax = 'markdown',
		ext = '.md',
	}
}

vim.g.vimwiki_global_ext = 0 -- don't treat all md files as vimwiki (0)
vim.g.vimwiki_hl_headers = 1  -- use alternating colours for different heading levels
vim.g.vimwiki_markdown_link_ext = 1 -- add markdown file extension when generating links
vim.g.taskwiki_markdown_syntax = "markdown"
vim.g.indentLine_conceallevel = 2 -- indentline controlls concel

-- }}}

-- Fuzzy Finder - fzf-lua --------------------------------------{{{

-- all shortcuts in which-key

function FilesHereOpen()
  require('fzf-lua').files({ file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

function WikiOpen()
  require('fzf-lua').files({ cwd = "~/Wiki/", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } }) 
end

function WikiZetOpen()
  require('fzf-lua').files({ cwd = "~/Wiki/Zet/", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } }) 
end

function SyncOpen()
  require('fzf-lua').files({ cwd = "~/Sync/", file_ignore_patterns  = { "%._", "%.DS_Store", "%.spell" } }) 
end

function RworkspaceOpen()
  require('fzf-lua').files({ cwd = "/mnt/raid0/Pessoal/Documents/Rworkspace/", file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

function ProfissionalOpen()
  require('fzf-lua').files({ cwd = "/mnt/raid0/Pessoal/Documents/Profissional/", file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

function DownloadsOpen()
  require('fzf-lua').files({ cwd = "~/Downloads/", file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

function WikiGrep()
  require('fzf-lua').live_grep({ cwd = "~/Wiki/", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } }) 
end

function WikiZetGrep()
  require('fzf-lua').live_grep({ cwd = "~/Wiki/Zet/", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } }) 
end

function SyncGrep()
  require('fzf-lua').live_grep({ cwd = "~/Sync/", file_ignore_patterns  = { "%._", "%.DS_Store", ".spell" } }) 
end

function RworkspaceGrep()
  require('fzf-lua').live_grep({ cwd = "/mnt/raid0/Pessoal/Documents/Rworkspace/", file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

function ProfissionalGrep()
  require('fzf-lua').live_grep({ cwd = "/mnt/raid0/Pessoal/Documents/Profissional/", file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

function DownloadsGrep()
  require('fzf-lua').live_grep({ cwd = "~/Downloads/", file_ignore_patterns  = { "%._", "%.DS_Store" } }) 
end

-- }}}

-- fzf-bibtex ------------------------------{{{
-- inset mode

vim.cmd([[
function! Bibtex_ls()
  let bibfiles = (
      \ globpath('.', '*.bib', v:true, v:true) +
      \ globpath('..', '*.bib', v:true, v:true) +
      \ globpath('*/', '*.bib', v:true, v:true)
      \ )
  let bibfiles = join(bibfiles, ' ')
  let source_cmd = 'bibtex-ls '.bibfiles
  return source_cmd
endfunction

function! s:bibtex_cite_sink_insert(lines)
    let r=system("bibtex-cite ", a:lines)
    execute ':normal! a' . r
    call feedkeys('a', 'n')
endfunction

inoremap <silent> @@ <c-g>u<c-o>:call fzf#run({
                        \ 'source': Bibtex_ls(),
                        \ 'sink*': function('<sid>bibtex_cite_sink_insert'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>
]])

vim.cmd("call Bibtex_ls()")

-- }}}

-- Maps to resizing a window split ------------------------------{{{
vim.cmd[[nnoremap <expr> <C-w>+ v:count1 * 10 . '<C-w>+']]
vim.cmd[[nnoremap <expr> <C-w>- v:count1 * 10 . '<C-w>-']]
vim.cmd[[nnoremap <expr> <C-w>< v:count1 * 10 . '<C-w><']]
vim.cmd[[nnoremap <expr> <C-w>> v:count1 * 10 . '<C-w>>']]
-- }}}

-- Python, Julia and vimcmdline------------------------------ {{{
--
-- vimcmdline mappings

vim.cmd[[let cmdline_app = {}]]
vim.cmd[[let cmdline_app['python'] = 'ipython']]

-- <LocalLeader>s to start the interpreter.
-- <Space> to send the current line to the interpreter.
-- <LocalLeader><Space> to send the current line to the interpreter and keep the cursor on the current line.
-- <LocalLeader>q to send the quit command to the interpreter.
-- <Space> to send a selection of text to the interpreter.
-- <LocalLeader>p to send from the line to the end of paragraph.
-- <LocalLeader>b to send block of code between the two closest marks.
-- <LocalLeader>f to send the entire file to the interpreter.
-- <LocalLeader>m to send the text in the following motion to the interpreter. For example 
-- <LocalLeader>miw would send the selected word.

-- }}}

-- HTML, XML, PHP ------------------------------{{{

-- vim.cmd[[autocmd FileType html set omnifunc=htmlcomplete#CompleteTags]]
-- fold and syntax
-- vim.cmd[[let g:xml_syntax_folding=1]]
-- vim.cmd[[au FileType xml setlocal foldmethod=syntax]]
-- vim.cmd[[au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null]]
-- vim.cmd[[au BufEnter,BufNew *.php :set filetype=html]]

-- }}}

-- Zoom in buffer ------------------------------{{{
vim.cmd([[
fu s:window_zoom_toggle() abort
    if winnr('$') == 1 | return | endif
    if exists('t:zoom_restore') && win_getid() == t:zoom_restore.winid
        exe get(t:zoom_restore, 'cmd', '')
        unlet t:zoom_restore
    else
        let t:zoom_restore = {'cmd': winrestcmd(), 'winid': win_getid()}
        wincmd |
        wincmd _
    endif
endfu

]])

-- see which-key
-- nnoremap <leader>wz :<c-u>call <sid>window_zoom_toggle()<cr>

-- }}}

-- Date and Time  ------------------------------ {{{
--
local date_time_inserter_status_ok, date_time_inserter = pcall(require, "date-time-inserter")
if not date_time_inserter_status_ok then
    return
end

date_time_inserter.setup {
    date_format = 'YYYYMMDD',
    date_separator = '-',
    time_format = 24,
    show_seconds = false,
    -- insert_date_map = '<leader>dt',
    -- insert_time_map = '<leader>tt',
    -- insert_date_time_map = '<leader>dtt',
}

-- }}}

-- Nerd Tree ------------------------------ {{{

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

--- }}}

-- ChatGPT ------------------------------ {{{

-- "gpt-3.5-turbo"
-- "gpt-4"
-- "gpt-4.0-turbo"
-- "gpt-4o-mini"
-- "gpt-4o"
-- "o1-preview"
-- "o1-mini"

require("chatgpt").setup({
  api_key_cmd = "secret-tool lookup openai neovim",

  openai_params = {
    -- NOTE: model can be a function returning the model name
    -- this is useful if you want to change the model on the fly
    -- using commands
    -- Example:
    -- model = function()
        -- if some_condition() then
            -- return "gpt-4-1106-preview"
        -- else
            -- return "gpt-3.5-turbo"
        -- end
    -- end,
    -- model = "gpt-4-1106-preview",
    -- model = "gpt-4o-mini",
    model = "gpt-4",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 4095,
    temperature = 0.2,
    top_p = 0.1,
    n = 1,
  }
})

--- }}}

-- WhichKey Menu ------------------------------ {{{

-- Configuração do which-key
require("which-key").setup({
  preset = 'classic', -- modern, helix, classic
  plugins = {
    marks = true, -- Exibe marcacurls
    registers = true, -- Exibe registros
    spelling = {
      enabled = true, -- Habilita correção ortográfica
      suggestions = 20, -- Número de sugestões a serem exibidas
    },
  },
  sort = { "order", "local", "group", "alphanum", "mod" }, -- Define a ordem dos mapeamentos
})

local wk = require("which-key")

wk.add({
  -- main group
  { "<Space>/", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", desc = "search here" },
  { "<Space>b", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "find buffers" },
  { "<Space>a", "<cmd>lua require('fzf-lua').lines()<CR>", desc = "all buffers" },
  -- file peak
  { "<Space>f", group = "[f]ile peak" },
  { "<Space>ft", "<cmd>NvimTreeOpen<CR>", desc = "tree open" },
  { "<Space>fh", FilesHereOpen, desc = "here" },
  { "<Space>fk", "<cmd>:w <bar> %bd <bar> e# <bar> bd# <CR>", desc = "keep only current buffer" },
  { "<Space>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", desc = "old files" },
  { "<Space>fr", RworkspaceOpen, desc = "/mnt/.../rworkspace" },
  { "<Space>fp", ProfissionalOpen, desc = "/mnt/.../profissional" },
  { "<Space>fd", DownloadsOpen, desc = "~/downloads" },
  { "<Space>fs", SyncOpen, desc = "~/sync" },
  { "<Space>fw", WikiOpen, desc = "~/wiki" },
  { "<Space>fz", WikiZetOpen, desc = "~/wiki/zet" },
  -- search content
  { "<Space>s", group = "[s]earch content" },
  { "<Space>sa", "<cmd>lua require('fzf-lua').grep()<CR>", desc = "all buffers" },
  { "<Space>sd", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "directory" },
  { "<Space>sq", "<cmd>lua require('fzf-lua').lgrep_quickfix()<CR>", desc = "quickfix" },
  { "<Space>sp", ProfissionalGrep, desc = "/mnt/.../profissional" },
  { "<Space>sr", RworkspaceGrep, desc = "/mnt/.../rworkspace" },
  { "<Space>sd", DownloadsGre, desc = "~/downloads" },
  { "<Space>ss", SyncGrep, desc = "~/sync" },
  { "<Space>sw", WikiGrep, desc = "~/wiki" },
  { "<Space>sz", WikiZetGrep, desc = "~/wiki/zet" },
  -- ChatGPT
  { "<Space>c", group = "[c]hat gpt" },
  { "<Space>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
  { "<Space>ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", mode = { "n", "v" } },
  { "<Space>ck",  "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
  { "<Space>cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
  { "<Space>ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
  { "<Space>co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
  { "<Space>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
  { "<Space>cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
  { "<Space>cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
  { "<Space>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
  { "<Space>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis", mode = { "n", "v" } },
  { "<Space>cg", group = "[g]rammar and translate" }, -- subgroup
  { "<Space>cgp", "<cmd>ChatGPTRun grammar_correction português brasileiro<CR>", desc = "Grammar Correction pt_br", mode = { "n", "v" } },
  { "<Space>cge", "<cmd>ChatGPTRun grammar_correction american english<CR>", desc = "Grammar Correction en_us", mode = { "n", "v" } },
  { "<Space>cgP", "<cmd>ChatGPTRun translate to brazilian porgutuese<CR>", desc = "Translate en_pt", mode = { "n", "v" } },
  { "<Space>cgE", "<cmd>ChatGPTRun translate to american english<CR>", desc = "Translate pt_en", mode = { "n", "v" } },
  -- vim
  { "<Space>v", group = "[v]im" },
  { "<Space>ve", "<cmd>lua require'nabla'.toggle_virt()<CR>", desc = "equations preview toggle" },
  { "<Space>vf", "<cmd>Neoformat<CR>", desc = "neoformat" },
  { "<Space>vm", "<cmd>NoiceDismiss<CR>", desc = "messages dismiss toggle" },
  { "<Space>vp", "<cmd>lua PasteImage<CR>", desc = "paste image" },
  { "<Space>vc", group = "[c]olor" }, -- subgroup
  { "<Space>vcl", "<cmd>set background=light<CR>", desc = "ligth background" },
  { "<Space>vcd", "<cmd>set background=dark<CR>", desc = "dark background" },
  { "<Space>vd", group = "[d]ate and time" }, -- subgroup
  { "<Space>vdb", "<cmd>InsertDateTime<CR>", desc = "both date and time" },
  { "<Space>vdd", "<cmd>InsertDate<CR>", desc = "date" },
  { "<Space>vdt", "<cmd>InsertTime<CR>", desc = "time" },
  { "<Space>vg", group = "[g]rammar check" }, -- subgroup
  { "<Space>vgb", "<cmd>set spell! spelllang=pt,en<CR>", desc = "both", mode = { "n", "v" } },
  { "<Space>vge", "<cmd>set spell! spelllang=en<CR>", desc = "english" , mode = { "n", "v" } },
  { "<Space>vgp", "<cmd>set spell! spelllang=pt<CR>", desc = "português", mode = { "n", "v" } },
  { "<Space>vl", group = "[l]sp" }, -- subgroup
  { "<Space>vld", "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>", desc = "lsp disable", mode = { "n", "v" } },
  { "<Space>vlD", "<cmd>bufdo lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>", desc = "lsp disable buffers", mode = { "n", "v" } },
  { "<Space>vle", LspEnable, desc = "lsp enable", mode = { "n", "v" } },
  { "<Space>vi", group = "[i]nit.lua" }, -- subgroup
  { "<Space>vii", "<cmd>PlugInstall<CR>", desc = "install plugins" },
  { "<Space>vis", "<cmd>source ~/.config/nvim/init.lua<CR>", desc = "source init.lua" }, 
  { "<Space>vf", group = "[f]ormat" }, -- subgroup
  { "<Space>vfx", "<cmd>%!xmllint --format %<CR>", desc = "xml indent" }, 
  { "<Space>vfR", "<cmd>%s/\r//g <CR>", desc = "remove ^m" }, 
  { "<Space>vfD", "<cmd>%s/\\([^ ]\\)  */\\1 /g<CR>", desc = 'delete multiple spaces' },
  })

-- }}}

-- vim: fdm=marker nowrap
