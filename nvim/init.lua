
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
vim.opt.wrap = false
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

-- \ca close all buffers except the current one
vim.cmd[[nnoremap ;ca :w <bar> %bd <bar> e# <bar> bd# <CR>]]

-- }}}

-- Spell check ------------------------------{{{
--
-- dicionario em dois idiomas
vim.cmd[[setlocal nospell spelllang=pt,en]]

-- alterando a forma como o vim sinaliza as palavras erradas
vim.cmd[[hi clear SpellBad]]
vim.cmd[[hi SpellBad cterm=underline]]

-- nao corrigir palavras no inicio da linha em minusculo
vim.cmd[[set spellfile=~/Sync/.spell/lowercase.utf-8.add]]
vim.cmd[[set spellfile=~/Sync/.spell/pt.utf-8.add]]
vim.cmd[[set spellfile=~/Sync/.spell/en.utf-8.add]]
vim.cmd[[set spellcapcheck=]]

-- control + n
-- utilizar o dicionario como fonte das palavras sugeridas no autocompletar
vim.cmd[[set dictionary=/usr/share/dict/words]]
vim.cmd[[set complete+=kspell]]

-- não precisa do nospell, pois, 'spell!' é toggle
-- F2 pt_br
-- F3 en_us
-- F4 pt_br, en_us
vim.cmd[[nmap <F2> :set spell! spelllang=pt<CR>]]
vim.cmd[[nmap <F3> :set spell! spelllang=en<CR>]]
vim.cmd[[nmap <F4> :set spell! spelllang=pt,en<CR>]]

--}}}

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
vim.cmd("nmap <F2> :set spell! spelllang=pt<CR>")
vim.cmd("nmap <F3> :set spell! spelllang=en<CR>")
vim.cmd("nmap <F4> :set spell! spelllang=pt,en<CR>")

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
Plug('f3fora/cmp-spell')

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

-- tabular / alinhar texto
Plug 'godlygeek/tabular'

-- code formater
Plug 'sbdchd/neoformat'

-- rainbow colors to {} [] ()
-- Plug('luochen1990/rainbow')

--  Delete buffer withou messing the layout :Bd
Plug('moll/vim-bbye')

-- distraction free :Goyo
Plug('junegunn/goyo.vim')

-- Python, Julia, Go
Plug('jalvesaq/vimcmdline')

-- LaTeX
-- Plug('lervag/vimtex')

-- bracket mappings - quickfix navigation
Plug('tpope/vim-unimpaired')

-- surround a object with (`c` chance, `d` delete, `y` you surround) 
Plug('tpope/vim-surround')

-- wiki 
Plug('vimwiki/vimwiki')
Plug('michal-h21/vim-zettel')

-- julia 
-- Plug 'JuliaEditorSupport/julia-vim'

vim.call('plug#end')

-- }}}

-- Colorschemes and Status Line --------------------------------------{{{

vim.cmd("set background=dark") -- or light if you want light mode
vim.cmd("colorscheme gruvbox") 

require'lualine'.setup { options = { theme = 'gruvbox_dark' } }

-- }}}

-- Auto complete and Beauty ------------------------------------{{{

-- treesitter 
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

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "r", "python", "lua", "vim", "markdown", "markdown_inline", "yaml", "xml", "html", "tmux", "bibtex", "latex"},
  sync_install = false,
  auto_install = true,
  -- ignore_install = { "latex" },
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
    { name = 'nvim_lsp' },
    { name = 'path'},
    { name = 'cmdline' }, 
    { name = 'spell' }, 
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

vim.cmd[[nnoremap ;p :PasteImage<CR>]]

-- preview equations with nabla.nvim
-- ;e
vim.cmd[[nnoremap ;e :lua require"nabla".toggle_virt()<CR>]]

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
    bottom_search = true, -- use a classic bottom cmdline for search
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

-- noice: desabilitar mensagens
vim.keymap.set('n', ';d', '<cmd>NoiceDismiss<CR>', {desc = 'Dismiss Noice Message'})

-- -- }}}

-- snippets ------------------------------{{{
-- 
-- arquivos Rnw usando snippets de r tex e rnoweb
-- au BufRead,BufNewFile *.rnw set ft=rnoweb.r.tex
-- arquivos  Rmd usando snippets de r e rmd
-- au BufRead,BufNewFile *.rmd set ft=rmd.r
-- au BufRead,BufNewFile *.Rmd set ft=rmd.r

-- vim.cmd[[autocmd BufRead,BufNewFile *.qmd set ft=rmd.r]]

-- markdown flavor 
-- autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

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

-- LSP Disable and Enable
local lsp_enabled = true

function ToggleLsp()
  if lsp_enabled then
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    print("LSP disabled.")
  else
    require('lspconfig').r_language_server.setup{
      cmd = { "R", "--slave", "-e", "languageserver::run()" },
      on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      end,
    }
    print("LSP activated.")
  end
  lsp_enabled = not lsp_enabled 
end

-- map shortcut ;l
vim.api.nvim_set_keymap('n', ';l', ':lua ToggleLsp()<CR>', { noremap = true, silent = true })

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
      vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
      vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
      vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
    end,
  },
})

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

-- Time Stamps
vim.cmd[[inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>]]
vim.cmd[[ inoremap <F7> <C-R>=strftime("%H:%M")<CR>]]

-- save
vim.cmd[[nnoremap <F8> :w<CR>]]

-- remove ^M quebra de página
vim.cmd[[nnoremap <F9> :%s/\r//g <CR>]]

-- wrap
vim.cmd[[nnoremap <F10> :set nowrap! <CR>]]

-- Makefile
-- :make 
-- :make html
-- :make pdf
-- :make all

-- ou simplismente via atalhos
vim.cmd[[nmap <leader>mm :!make<CR>]]
vim.cmd[[nmap <leader>ma :!make all<CR>]]
-- nmap <leader>md :!make docx

-- mm (mindmaps) as markdown
vim.cmd[[autocmd BufRead,BufNewFile *.mm set ft=markdown.pandoc]]

vim.cmd[[nmap <leader>mc ::CocCommand markmap.create<CR>]]
vim.cmd[[nmap <leader>mw :CocCommand markmap.watch<CR>]] 

-- }}}

-- Fuzzy Finder - fzf-lua --------------------------------------{{{

-- find files and buffers
-- ;f find files
-- ;b find buffer
-- ;o history opened files
-- ;w find files in ~/Wiki
-- ;z find files in ~/Wiki/Zet
--
-- find content
-- ;\ find content opened buffer
-- ;G find content from current directory
-- ;B find content all buffers
-- ;W grep content from ~/Wiki 
-- ;Z grep content from ~/Wiki/Zet 

-- files or buffers
vim.keymap.set('n', ';f', require('fzf-lua').files)
vim.keymap.set('n', ';b', require('fzf-lua').buffers)
vim.keymap.set('n', ';o', require('fzf-lua').oldfiles)
vim.keymap.set("n", ";w", function() require('fzf-lua').files({ cwd = "~/Wiki/", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff" } }) end, { desc = "files ~/Wiki" })
vim.keymap.set("n", ";z", function() require('fzf-lua').files({ cwd = "~/Wiki/Zet", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff" } }) end, { desc = "files ~/Wiki/Zet" })

-- content inside files and buffers
vim.keymap.set('n', ';\\', require('fzf-lua').lgrep_curbuf)    
vim.keymap.set('n', ';G', require('fzf-lua').live_grep)
vim.keymap.set('n', ';B', require('fzf-lua').lines)             
vim.keymap.set("n", ";W", function() require('fzf-lua').live_grep({ cwd = "~/Wiki/", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff" } }) end, { desc = "live_grep ~/Wiki/Zet" })
vim.keymap.set("n", ";Z", function() require('fzf-lua').live_grep({ cwd = "~/Wiki/Zet", file_ignore_patterns  = { "%.html", "%.css", "%.js", "%.woff" } }) end, { desc = "live_grep ~/Wiki" })

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

vim.cmd[[let cmdline_app           = {}]]
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

vim.cmd[[autocmd FileType html set omnifunc=htmlcomplete#CompleteTags]]

-- indent xml
-- `:%!xmllint --format %`

-- fold and syntax
vim.cmd[[let g:xml_syntax_folding=1]]
vim.cmd[[au FileType xml setlocal foldmethod=syntax]]
vim.cmd[[au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null]]

vim.cmd[[au BufEnter,BufNew *.php :set filetype=html]]

-- }}}

-- Zoom in buffer ------------------------------ {{{coc#pum#visible() ? coc#pum#confirm() : "\
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

nnoremap <leader>wz :<c-u>call <sid>window_zoom_toggle()<cr>
]])
-- }}}

-- Source Nvim ------------------------------ {{{
--
-- Source Nvim configuration file and install plugins
vim.cmd[[nnoremap <leader>1 :source ~/.config/nvim/init.lua <CR>]]
vim.cmd[[nnoremap <leader>2 :source ~/.config/nvim/init.lua \| :PlugInstall<CR>]]

-- }}}

-- vim: fdm=marker nowrap
