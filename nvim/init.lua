
-- General {{{

-- vim.opt options
-- vim.g geral
-- vim.api api
-- vim.cmd command

-- Leaders
vim.g.mapleader = " " -- Espaço = atalhos gerais (which-key)
vim.g.maplocalleader = "\\" -- Barra invertida = atalhos específicos (R.nvim, etc.)

vim.opt.number = true
vim.opt.wrap = true
vim.opt.showmode = false
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
vim.opt.termguicolors = true
vim.cmd("set t_ZH=^[[3m")
vim.cmd("set t_ZR=^[[23m")
vim.opt.clipboard:append("unnamedplus")
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.cmd[[highlight Comment cterm=italic]]
-- vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "leave insert mode" })
vim.cmd[[set nohlsearch]]

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.signcolumn = "no"
vim.opt.number = true                                                                                      
vim.opt.relativenumber = true                                                                              
vim.opt.numberwidth = 4

vim.opt.updatetime = 200
vim.opt.timeoutlen = 300  -- Default for normal mode

-- Disable timeoutlen in insert mode to eliminate space key delay
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.opt.timeoutlen = 0
  end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.opt.timeoutlen = 400
  end
})

vim.env.COLORTERM = "truecolor"
vim.env.TERM = "xterm-256color"

-- }}}

-- Highlight Color {{{
-- SideBar,StatusBar and Menus
local hl = vim.api.nvim_set_hl
hl(0, "SignColumn", { bg = "NONE" })
hl(0, "SignatureMarkText", { ctermbg = 0, bg = "NONE" })
hl(0, "TabLine", { bold = false, bg = "NONE", fg = "NONE" })
hl(0, "TabLineFill", {})
hl(0, "Pmenu", { ctermfg = 7, ctermbg = 0 })
hl(0, "PmenuSel", { ctermfg = 0, ctermbg = 7 })
hl(0, "SpellBad", { underline = true })

-- }}}

-- Spell check {{{
-- Requisitos no Arch/Manjaro: sudo pacman -S vim-spell-pt vim-spell-en

local opt = vim.opt

-- desliga por padrão; você liga/desliga depois (F2/F3/F4 abaixo)
opt.spell = false
opt.spelllang = { "pt_br", "en_us" }

-- sinalização: sublinhado em palavras erradas (API moderna)
vim.api.nvim_set_hl(0, "SpellBad", { underline = true })

-- dicionários pessoais: use append (não sobrescreva o valor anterior)
opt.spellfile = vim.empty_dict() -- zera de forma explícita
opt.spellfile:append(vim.fn.expand("~/Sync/.spell/lowercase.utf-8.add"))
opt.spellfile:append(vim.fn.expand("~/Sync/.spell/pt.utf-8.add"))
opt.spellfile:append(vim.fn.expand("~/Sync/.spell/en.utf-8.add"))

-- não exigir maiúscula no começo de frase (desativa checagem de capitalização)
opt.spellcapcheck = ""

-- dicionário de palavras do sistema + completar usando kspell
opt.dictionary = "/usr/share/dict/words"
opt.complete:append("kspell")

-- Funções centralizadas de toggle (adicionar junto ao bloco Spell check ou antes do which-key)
function ToggleSpellBoth()
  vim.opt.spell = not vim.opt.spell:get()
  vim.opt.spelllang = { "pt_br", "en_us" }
  vim.notify("spell: pt_br + en_us (" .. (vim.opt.spell:get() and "ON" or "OFF") .. ")")
end

function ToggleSpellEN()
  vim.opt.spell = not vim.opt.spell:get()
  vim.opt.spelllang = { "en_us" }
  vim.notify("spell: en_us (" .. (vim.opt.spell:get() and "ON" or "OFF") .. ")")
end

function ToggleSpellPT()
  vim.opt.spell = not vim.opt.spell:get()
  vim.opt.spelllang = { "pt_br" }
  vim.notify("spell: pt_br (" .. (vim.opt.spell:get() and "ON" or "OFF") .. ")")
end
-- }}}

-- Plugins {{{

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
-- Plug('jalvesaq/Nvim-R')
Plug('R-nvim/R.nvim')

-- Auto complete
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-cmdline')
Plug('R-nvim/cmp-r') -- autocompletion with 'R-nvim/R.nvim'
Plug('kdheepak/cmp-latex-symbols')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
Plug('dcampos/nvim-snippy')
Plug('dcampos/cmp-snippy')
Plug('micangl/cmp-vimtex')
Plug('tamago324/cmp-zsh')
Plug('Shougo/deol.nvim')

-- snippets
Plug('roneyfraga/vim-snippets')

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

-- Delete buffer withou messing the layout :Bd
Plug('moll/vim-bbye')

-- distraction free :Goyo
Plug('junegunn/goyo.vim')

-- Python, Julia, Go
Plug('jalvesaq/hlterm')

-- bracket mappings - quickfix navigation
Plug('tpope/vim-unimpaired')

-- surround a object with (`c` chance, `d` delete, `y` you surround)
Plug('tpope/vim-surround')

-- wiki
Plug('vimwiki/vimwiki')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')
Plug('michal-h21/vim-zettel')

-- Configure vim-zettel to use ripgrep instead of silver searcher
vim.g.zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"

-- markdown render
Plug('MeanderingProgrammer/render-markdown.nvim')

-- nerd tree
-- Plug('nvim-tree/nvim-tree.lua')

-- opencode AI
Plug('NickvanDyke/opencode.nvim')

-- required dependencies
Plug('nvim-lua/plenary.nvim')
-- Plug('MunifTanjim/nui.nvim') -- already instaled
-- Plug('MeanderingProgrammer/render-markdown.nvim') -- already instaled
Plug('stevearc/dressing.nvim') -- " for enhanced input UI
Plug('folke/snacks.nvim') -- " for modern input UI

-- optional dependecies
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-telescope/telescope.nvim')
-- Plug('ibhagwan/fzf-lua') -- already instaled
-- Plug('hrsh7th/nvim-cmp') -- already instaled
Plug('stevearc/dressing.nvim')
Plug('folke/snacks.nvim')

-- windows movements
Plug('MisanthropicBit/winmove.nvim')

-- markmap
-- also do: yarn global add markmap-cli
Plug('Zeioth/markmap.nvim', { ['do'] = 'yarn global add markmap-cli' })

vim.call('plug#end')

-- }}}

-- Colorschemes and Status Line {{{

vim.cmd("set background=dark") -- or light if you want light mode
vim.cmd("colorscheme gruvbox")

function getWords()
  local wc = vim.fn.wordcount()
  if wc["visual_words"] then
    -- return wc["visual_words"] .. " words"
    return wc["visual_words"]
  else
    -- return wc["words"] .. " words"
    return wc["words"]
  end
end

require'lualine'.setup {
  options = { theme = 'gruvbox' },
  sections = {
    lualine_z = {
      "location",
      { getWords },
    },
  },
}

-- }}}

-- nvim-lspconfig {{{

-- LSP (Neovim 0.11+ API)
pcall(require, "lspconfig")

-- Capabilities for nvim-cmp
local caps = require("cmp_nvim_lsp").default_capabilities()

-- Basic per-buffer keymaps
local on_attach = function(_, bufnr)
  local k = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true }) end
  k("gd", vim.lsp.buf.definition)
  k("K",  vim.lsp.buf.hover)
  k("gr", vim.lsp.buf.references)
end

-- Configure servers with custom options
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = caps,
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- yay -S ltex-ls-bin
-- LanguageTool
vim.lsp.config("ltex", {
  autostart = false,
  on_attach = on_attach,
  capabilities = caps,
  settings = {
    ltex = {
      languageToolHttpServerUri = "https://api.languagetoolplus.com",
      languageToolOrg = {
        username = os.getenv("LANGUAGETOOL_USERNAME"),
        apiKey = os.getenv("LANGUAGETOOL_API_KEY"),
      },
      language = "en-US",
      additionalRules = {
        enablePickyRules = true,
      },
      -- Ignore code blocks and math in markdown/quarto files
      markdown = {
        ignoreCodeBlocks = true,
        ignoreMath = true,
      },
      -- Ignore LaTeX equations and environments
      latex = {
        commands = {
          ignore = { "cite", "ref", "label" },
        },
        environments = {
          ignore = { 
            "equation", "equation*",
            "align", "align*",
            "gather", "gather*",
            "multline", "multline*",
            "eqnarray", "eqnarray*",
            "math", "displaymath",
            "lstlisting", "verbatim",
          },
        },
      },
      disabledRules = { 
        ["en-US"] = { 
          "MORFOLOGIK_RULE_EN_US",
          "COMMA_PARENTHESIS_WHITESPACE",
        },
        ["pt-BR"] = { 
          "MORFOLOGIK_RULE_PT_BR",
          "COMMA_PARENTHESIS_WHITESPACE",
        },
      },
      enabledRules = {},
    },
  },
  filetypes = { "tex", "bib", "markdown", "gitcommit", "org", "quarto", "vimwiki", "rmd" },
})

-- Enable all desired servers (ltex excluded because autostart=false)
vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
  "r_language_server",
})

-- LSP Toggle function (handles ALL LSP servers for current buffer)
function LspToggle()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if #clients > 0 then
    -- LSP is active, disable ALL clients in current buffer
    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
    end
    print("LSP disabled")
  else
    -- LSP is inactive, start appropriate server based on filetype
    vim.cmd('LspStart')
    print("LSP enabled")
  end
end

-- Change ltex language
function LtexSetLanguage(lang)
  local clients = vim.lsp.get_clients({ name = "ltex", bufnr = 0 })

  if #clients > 0 then
    for _, client in ipairs(clients) do
      client.config.settings.ltex.language = lang
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      print("ltex language changed to: " .. lang)
    end
  else
    print("ltex is not running. Start it first with <Space>lt")
  end
end

-- Language shortcuts
function LtexAuto()
  LtexSetLanguage("auto")
end

function LtexEnglish()
  LtexSetLanguage("en-US")
end

function LtexPortuguese()
  LtexSetLanguage("pt-BR")
end

-- }}}

-- Auto complete and Beauty {{{

-- linux: pacman -S pyright
-- R: install.packages("languageserver")

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

-- check installation
-- :checkhealth nvim-treesitter
-- :InspectTree

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "r", "python", "lua", "vim", "markdown", "markdown_inline", "yaml", "xml", "html", "tmux", "bibtex", "latex", "make"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {enable = true},
}

-- Set up nvim-cmp.
-- see: https://github.com/hrsh7th/nvim-cmp
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
    { name = 'snippy' }, -- R snippets
    { name = 'cmp_r' }, -- R autocompletion
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
      { name = 'buffer', keyword_length = 5 },
    })
})

-- snippy
-- snippets configs
-- see: https://github.com/dcampos/nvim-snippy
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
  -- Make markdown snippets available in vimwiki and quarto files
  scopes = {
    vimwiki = function()
      return { "vimwiki", "markdown" }
    end,
    quarto = function()
      return { "quarto", "markdown" }
    end,
  },
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
    extension = "png", -- (opcional)
    file_name = "%Y-%m-%d-%H-%M-%S", -- (opcional)
    use_absolute_path = false,
  },
})

-- see which-key
-- vim.cmd[[nnoremap ;p :PasteImage<CR>]]

-- see which-key

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

-- treesitter fold
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldenable = true -- disable folding on startup

-- rename file
function RenameFile()
  local old_name = vim.fn.expand('%:p') -- caminho absoluto do arquivo aberto
  local new_name = vim.fn.input('Novo nome: ', old_name, 'file')
  if new_name == '' or new_name == old_name then
    return
  end

  vim.fn.mkdir(vim.fn.fnamemodify(new_name, ":h"), "p")

  local ok, err = os.rename(old_name, new_name)
  if not ok then
    vim.notify("Erro ao renomear: " .. err, vim.log.levels.ERROR)
    return
  end

  vim.cmd('edit ' .. new_name)
  vim.cmd('bdelete ' .. old_name) -- fecha o antigo
  vim.notify("Arquivo renomeado para: " .. new_name, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('RenameFile', RenameFile, {})

-- }}}

-- R-nvim {{{

-- :RMapsDesc -- list all commands
-- :RConfigShow -- list configurations

-- R.nvim: configurações gerais
require("r").setup({
  -- filetypes = {"r", "rmd", 'rnoweb', 'rhelp', 'quarto'},
  -- sources = {
  -- { name = 'cmp_r' },
  -- },
  -- R_args = {"--no-save"},
  min_editor_width = 72,
  rconsole_width = 78,
  disable_cmds = {
    -- "RSPlot",
    -- "RSaveClose",
  },
  hook = {
    on_filetype = function()
      -- Mapeamentos de teclas específicos para arquivos R
      vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
      vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
    end,
  },
})

-- atalhos
vim.api.nvim_set_keymap('n', '<LocalLeader>T', '<cmd>lua vim.fn.RAction("tail")<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<Leader><Leader>t', ':call RAction("tail")<CR>', { noremap = false, silent = false })
-- vim.api.nvim_set_keymap('n', '<Leader><Leader>h', ':call RAction("head")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader><Leader>n', ':call RAction("names")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader><Leader>l', ':call RAction("length")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader><Leader>d', ':call RAction("dim")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader><Leader>g', ':call RAction("dplyr::glimpse")<CR>', { noremap = true, silent = true })

-- qmd as rmd
-- to allow snippets in quarto document
-- but disable quarto chunks tags autocompletion
-- vim.cmd[[autocmd BufRead,BufNewFile *.qmd, *.Rmd set ft=rmd.r]]
-- vim.cmd[[autocmd BufRead,BufNewFile *.qmd, *.Rmd set ft=r]]

-- keybindings only inside R, Rmd, and Quarto filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "r", "rmd", "quarto" },
  callback = function()
    local opts = { noremap = true, silent = true }
    -- Define keybindings for the current buffer
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>t', "<cmd>lua require('r.run').action('tail')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>h', "<cmd>lua require('r.run').action('head')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>n', "<cmd>lua require('r.run').action('names')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>L', "<cmd>lua require('r.run').action('length')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>d', "<cmd>lua require('r.run').action('dim')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>p', "<cmd>lua require('r.run').action('print')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>c', "<cmd>lua require('r.run').action('class')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>g', "<cmd>lua require('r.run').action('glimpse')<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>v', "<cmd>lua require('r.run').action('viewobj', 'h')<CR>", opts)

    -- function loaded from ~/.Rprofile
    vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader><LocalLeader>l', "<cmd>lua require('r.send').cmd('largura()')<CR>", opts)

  end
})

-- }}}

-- Markdown VimWiki + render + preview {{{

-- disable default mappings
vim.g.vimwiki_key_mappings = { all_maps = 0, global = 0 }

-- Re-enable *just* the link navigation you want inside Vimwiki buffers
local grp = vim.api.nvim_create_augroup("MyVimwikiMaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = "vimwiki",
  callback = function()
    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true, nowait = true })
    end
    -- Enter to follow link / open note
    map("n", "<CR>", "<Plug>VimwikiFollowLink") -- enter no creat note
    map("n", "<BS>", "<Plug>VimwikiGoBackLink") -- go back
    map("n", "<Tab>", "<Plug>VimwikiNextLink") -- next link
    map("n", "<S-Tab>", "<Plug>VimwikiPrevLink") -- prev link
  end,
})

vim.g.vimwiki_list = {
  {
    path = '~/Wiki',
    syntax = 'markdown',
    ext = '.md',
  },
  {
    path = '~/Wiki/Zet',
    syntax = 'markdown',
    ext = '.md',
  }
}

vim.g.vimwiki_global_ext = 0 -- don't treat all md files as vimwiki (0)
-- vim.g.vimwiki_hl_headers = 1 -- use alternating colours for different heading levels
-- vim.g.vimwiki_markdown_link_ext = 1 -- add markdown file extension when generating links
-- vim.g.taskwiki_markdown_syntax = "markdown"
-- vim.g.indentLine_conceallevel = 2 -- indentline controlls concel

-- Show real characters (emoji/symbols) in Markdown-like buffers
local grp_show = vim.api.nvim_create_augroup("MarkdownVisibleSymbols", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = grp_show,
  pattern = { "markdown", "vimwiki", "quarto" },
  callback = function()
    -- Ensure emojis/special glyphs like 🔐 🧭 👤 are not hidden by conceal
    vim.opt_local.conceallevel = 0
    -- Optional: show invisibles while you tune fonts
    -- vim.opt_local.list = true
    -- vim.opt_local.listchars = { eol = '↴', space = '·', tab = '→ ' }
  end,
})

function ZettelIndexOpen()
  vim.cmd('edit ~/Wiki/Zet/index.md')
end

-- -- Search only markdown files in the current wiki directory
vim.g.zettel_fzf_command = "rg --pcre2 --column --line-number --ignore-case --color=always -g '*.md'"

-- ---------------------------------------
-- First define the highlights

-- fix H1 title color bug in render-markdown.nvim
vim.cmd([[
  highlight RenderMarkdownH1Bg guibg=#5b474e guifg=#f38ba8
  highlight RenderMarkdownH2Bg guibg=#514046 guifg=#f5c2e7
  highlight RenderMarkdownH3Bg guibg=#47393e guifg=#bea9a2
  highlight RenderMarkdownH4Bg guibg=#3d3236 guifg=#cbb6b0
  highlight RenderMarkdownH5Bg guibg=#332b2e guifg=#d8c3be
  highlight RenderMarkdownH6Bg guibg=#2a2426 guifg=#e5d0cc 

  " LaTeX/Math highlighting via TreeSitter
  highlight @markup.math guifg=#89b4fa gui=italic
  highlight @text.math guifg=#89b4fa gui=italic
  highlight @math guifg=#89b4fa gui=italic
]])

require('render-markdown').setup({
  file_types = { 'markdown', 'vimwiki', 'quarto' },
  render_modes = true,
  anti_conceal = { enabled = true },
  heading = {
    enabled = true,
    render_modes = false,
    atx = true,
    setext = true,
    sign = true,
    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    position = 'overlay',
    signs = { '󰫎 ' },
    width = 'full',
    left_margin = 0,
    left_pad = 0,
    right_pad = 0,
    min_width = 0,
    border = false,
    border_virtual = false,
    border_prefix = false,
    above = '▄',
    below = '▀',
    backgrounds = {
      'RenderMarkdownH1Bg',
      'RenderMarkdownH2Bg',
      'RenderMarkdownH3Bg',
      'RenderMarkdownH4Bg',
      'RenderMarkdownH5Bg',
      'RenderMarkdownH6Bg',
    },
    foregrounds = {
      'RenderMarkdownH1',
      'RenderMarkdownH2',
      'RenderMarkdownH3',
      'RenderMarkdownH4',
      'RenderMarkdownH5',
      'RenderMarkdownH6',
    },
    custom = {},
  },
  html = {
    enabled = true,
    render_modes = false,
    comment = { conceal = false, text = nil, highlight = 'RenderMarkdownHtmlComment' },
    tag = {},
  },
})

vim.treesitter.language.register('markdown', 'vimwiki')

-- Função para copiar o texto selecionado e inseri-lo dentro de um chunk
function CopyToChunk()
  -- Obtém a seleção visual
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Obtém as linhas selecionadas
  local lines = vim.fn.getline(start_line, end_line)

  -- Define o texto do chunk
  local chunk_start = "```text"
  local chunk_end = "```"

  -- Cria uma tabela para armazenar as linhas formatadas
  local formatted_lines = {}

  -- Adiciona o início do chunk
  table.insert(formatted_lines, chunk_start)

  -- Adiciona as linhas selecionadas
  for _, line in ipairs(lines) do
    table.insert(formatted_lines, line)
  end

  -- Adiciona o final do chunk
  table.insert(formatted_lines, chunk_end)

  -- Insere o novo conteúdo abaixo da seleção
  vim.fn.append(end_line, formatted_lines)

  -- Opcional: Remove a seleção original (se desejado)
  -- vim.fn.deletebufline('%', start_line, end_line)
end

-- Mapeia a função a um atalho (exemplo: <leader>cck)
-- vim.api.nvim_set_keymap('v', '<leader>cck', ':lua CopyToChunk()<CR>', { noremap = true, silent = true })

-- Function to convert selected text to markdown link
local function create_markdown_link()
  -- Check if we're in a markdown, quarto, or vimwiki file
  local ft = vim.bo.filetype
  if ft ~= "markdown" and ft ~= "quarto" and ft ~= "vimwiki" then
    vim.notify("This function only works in markdown, quarto, and vimwiki files", vim.log.levels.WARN)
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  local selected_text = ""
  local is_visual_mode = mode:match('[vV]')

  if is_visual_mode then
    -- Visual mode: get selected text
    -- Save the current register content
    local save_reg = vim.fn.getreg('"')
    local save_regtype = vim.fn.getregtype('"')

    -- Yank the visual selection
    vim.cmd('normal! "zy')
    selected_text = vim.fn.getreg('z')

    -- Restore the register
    vim.fn.setreg('"', save_reg, save_regtype)
  else
    -- Normal mode: get current line
    selected_text = vim.api.nvim_get_current_line()
  end

  -- Check if we got any text
  if selected_text == "" or selected_text == nil then
    vim.notify("No text found", vim.log.levels.WARN)
    return
  end

  -- Remove trailing newlines
  selected_text = selected_text:gsub("\n$", ""):gsub("\n", " ")

  -- Convert special characters to ASCII equivalents (same as linuxify_text)
  local char_map = {
    -- Lowercase
    ['à']='a', ['á']='a', ['â']='a', ['ã']='a', ['ä']='a', ['å']='a',
    ['è']='e', ['é']='e', ['ê']='e', ['ë']='e',
    ['ì']='i', ['í']='i', ['î']='i', ['ï']='i',
    ['ò']='o', ['ó']='o', ['ô']='o', ['õ']='o', ['ö']='o', ['ø']='o',
    ['ù']='u', ['ú']='u', ['û']='u', ['ü']='u',
    ['ý']='y', ['ÿ']='y',
    ['ñ']='n', ['ç']='c',
    -- Uppercase
    ['À']='A', ['Á']='A', ['Â']='A', ['Ã']='A', ['Ä']='A', ['Å']='A',
    ['È']='E', ['É']='E', ['Ê']='E', ['Ë']='E',
    ['Ì']='I', ['Í']='I', ['Î']='I', ['Ï']='I',
    ['Ò']='O', ['Ó']='O', ['Ô']='O', ['Õ']='O', ['Ö']='O', ['Ø']='O',
    ['Ù']='U', ['Ú']='U', ['Û']='U', ['Ü']='U',
    ['Ý']='Y', ['Ÿ']='Y',
    ['Ñ']='N', ['Ç']='C'
  }

  -- Convert special characters to ASCII equivalents
  local normalized_text = selected_text:gsub('[%z\1-\127\194-\244][\128-\191]*', function(c)
    return char_map[c] or c
  end)

  -- Create the slug version (lowercase, replace spaces with hyphens)
  local slug = normalized_text:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")

  -- Create the markdown link format with parentheses inside brackets
  local link = string.format("[\"%s\"](%s)", selected_text, slug)

  -- Replace the text with the link
  if is_visual_mode then
    -- Visual mode: replace selection
    vim.cmd('normal! gv"_c' .. link)
    vim.cmd('normal! l')
  else
    -- Normal mode: replace current line
    local current_line = vim.api.nvim_get_current_line()
    vim.api.nvim_set_current_line(link)
  end
end

-- Make the function available globally
_G.create_markdown_link = create_markdown_link

-- Function to insert manual fold structure
local function insert_manual_fold()
  -- Check if we're in a markdown, quarto, or vimwiki file
  local ft = vim.bo.filetype
  if ft ~= "markdown" and ft ~= "quarto" and ft ~= "vimwiki" then
    vim.notify("This function only works in markdown, quarto, and vimwiki files", vim.log.levels.WARN)
    return
  end

  -- Get current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  
  -- Create fold structure
  local fold_lines = {
    "<!-- Description {{{ -->",
    "",
    "",
    "<!-- }}} -->",
  }
  
  -- Insert the fold structure at current position
  vim.api.nvim_buf_set_lines(0, row, row, false, fold_lines)
  
  -- Move cursor to the empty line inside the fold (2 lines down, at the beginning)
  vim.api.nvim_win_set_cursor(0, {row + 2, 0})
end

-- Function to insert vim fold marker at end of file
local function insert_fold_marker()
  -- Check if we're in a markdown, quarto, or vimwiki file
  local ft = vim.bo.filetype
  if ft ~= "markdown" and ft ~= "quarto" and ft ~= "vimwiki" then
    vim.notify("This function only works in markdown, quarto, and vimwiki files", vim.log.levels.WARN)
    return
  end

  local marker = "<!-- vim: fdm=marker foldlevel=0 -->"
  
  -- Get total number of lines in buffer
  local line_count = vim.api.nvim_buf_line_count(0)
  
  -- Get last line content
  local last_line = vim.api.nvim_buf_get_lines(0, line_count - 1, line_count, false)[1]
  
  -- Check if marker already exists in last line
  if last_line and last_line:match("vim:%s*fdm=marker") then
    vim.notify("Fold marker already exists at end of file", vim.log.levels.INFO)
    return
  end
  
  -- Check if last line is empty, if not add a blank line first
  local lines_to_add = {}
  if last_line and last_line ~= "" then
    table.insert(lines_to_add, "")
  end
  table.insert(lines_to_add, marker)
  
  -- Insert marker at end of file
  vim.api.nvim_buf_set_lines(0, line_count, line_count, false, lines_to_add)
  
  vim.notify("Fold marker added at end of file", vim.log.levels.INFO)
end

-- Make functions available globally
_G.insert_manual_fold = insert_manual_fold
_G.insert_fold_marker = insert_fold_marker

-- }}}

-- Fuzzy Finder - fzf-lua {{{

-- all shortcuts in which-key

function FilesHereOpen()
  require('fzf-lua').files({ file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function FilesHomeOpen()
  require('fzf-lua').files({ cwd = "~/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function WikiOpen()
  require('fzf-lua').files({ cwd = "~/Wiki/", file_ignore_patterns = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } })
end

function WikiZetOpen()
  require('fzf-lua').files({ cwd = "~/Wiki/Zet/", file_ignore_patterns = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } })
end

function SyncOpen()
  require('fzf-lua').files({ cwd = "~/Sync/", file_ignore_patterns = { "%._", "%.DS_Store", "%.spell" } })
end

function RworkspaceOpen()
  require('fzf-lua').files({ cwd = "/mnt/raid0/Pessoal/Documents/Rworkspace/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function ProfissionalOpen()
  require('fzf-lua').files({ cwd = "/mnt/raid0/Pessoal/Documents/Profissional/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function DownloadsOpen()
  require('fzf-lua').files({ cwd = "~/Downloads/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function HomeGrep()
  require('fzf-lua').live_grep({ cwd = "~/", file_ignore_patterns = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } })
end

function WikiGrep()
  require('fzf-lua').live_grep({ cwd = "~/Wiki/", file_ignore_patterns = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } })
end

function WikiZetGrep()
  require('fzf-lua').live_grep({ cwd = "~/Wiki/Zet/", file_ignore_patterns = { "%.html", "%.css", "%.js", "%.woff", "%._", "%.DS_Store" } })
end

function SyncGrep()
  require('fzf-lua').live_grep({ cwd = "~/Sync/", file_ignore_patterns = { "%._", "%.DS_Store", ".spell" } })
end

function RworkspaceGrep()
  require('fzf-lua').live_grep({ cwd = "/mnt/raid0/Pessoal/Documents/Rworkspace/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function ProfissionalGrep()
  require('fzf-lua').live_grep({ cwd = "/mnt/raid0/Pessoal/Documents/Profissional/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

function DownloadsGrep()
  require('fzf-lua').live_grep({ cwd = "~/Downloads/", file_ignore_patterns = { "%._", "%.DS_Store" } })
end

-- }}}

-- Maps to resizing a window split {{{
vim.keymap.set("n", "<C-w>+", function() return (vim.v.count1 * 10).."<C-w>+" end, { expr = true, desc = "split + altura" })
vim.keymap.set("n", "<C-w>-", function() return (vim.v.count1 * 10).."<C-w>-" end, { expr = true, desc = "split - altura" })
vim.keymap.set("n", "<C-w><", function() return (vim.v.count1 * 10).."<C-w><" end, { expr = true, desc = "split - largura" })
vim.keymap.set("n", "<C-w>>", function() return (vim.v.count1 * 10).."<C-w>>" end, { expr = true, desc = "split + largura" })
-- }}}

-- Python, Julia with hlterm {{{
--
-- hlterm mappings


-- <LocalLeader>s to start the interpreter.
-- <Enter> to send the current line to the interpreter.
-- <LocalLeader><Enter> to send the current line to the interpreter and keep the cursor on the current line.
-- <LocalLeader>q to send the quit command to the interpreter.
-- <Space> to send a selection of text to the interpreter.
-- <LocalLeader>p to send from the line to the end of paragraph.
-- <LocalLeader>b to send block of code between the two closest marks.
-- <LocalLeader>f to send the entire file to the interpreter.
-- <LocalLeader>m to send the text in the following motion to the interpreter. For example
-- <LocalLeader>miw would send the selected word.

-- }}}

-- HTML, XML, PHP {{{

-- vim.cmd[[autocmd FileType html set omnifunc=htmlcomplete#CompleteTags]]
-- fold and syntax
-- vim.cmd[[let g:xml_syntax_folding=1]]
-- vim.cmd[[au FileType xml setlocal foldmethod=syntax]]
-- vim.cmd[[au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null]]
-- vim.cmd[[au BufEnter,BufNew *.php :set filetype=html]]

-- }}}

-- Zoom in buffer {{{
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

-- Date and Time {{{
--
local ok_dti, date_time_inserter = pcall(require, "date-time-inserter")
if ok_dti then
  date_time_inserter.setup({
    date_format = '%Y-%m-%d',
    show_seconds = false,
  })
end
-- }}}

-- White Space + Equations with $$ and $ {{{
--

function TrimTrailingWhitespace()
  -- Save cursor position
  local save = vim.fn.winsaveview()
  -- Substitute trailing whitespace
  vim.api.nvim_command([[%s/\s\+$//e]])
  -- Restore cursor position
  vim.fn.winrestview(save)
end

-- Substitui \[...\] por $$...$$ e \(..\) por $..$ no buffer atual
local function replace_math_delimiters()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local new_lines = {}
  local in_block = false

  for _, line in ipairs(lines) do
    if line:match("^%s*\\%[%s*$") then
      -- Linha contendo apenas "\["
      table.insert(new_lines, "$$")
      in_block = true
    elseif line:match("^%s*\\%]%s*$") then
      -- Linha contendo apenas "\]"
      table.insert(new_lines, "$$")
      in_block = false
    elseif in_block then
      -- Linha dentro de \[...\]
      table.insert(new_lines, line)
    else
      -- Fora de bloco: substitui \(...\) por $...$
      local modified = line:gsub("\\%(%s*(.-)%s*\\%)", "$%1$")
      table.insert(new_lines, modified)
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
end

-- Comando Neovim: :ReplaceMathDelimiters
vim.api.nvim_create_user_command("ReplaceMathDelimiters",
  function() replace_math_delimiters()
  end, { desc = "Substitui delimitadores \\[\\]/\\(\\) por $$/$ no buffer atual" })

-- Atalho: <leader>ld
-- vim.keymap.set("n", "<leader>ld", replace_math_delimiters, { desc = "Swap LaTeX math delimiters" })

-- format text to be filename
-- remove spaces, special characters, etc.
local function linuxify_text()
  -- Get mode and selection range
  local mode = vim.api.nvim_get_mode().mode
  local start_row, start_col, end_row, end_col

  if mode:match('[vV]') then -- visual mode
    local selection = vim.fn.getpos('v')
    local cursor = vim.fn.getpos('.')
    start_row, start_col = selection[2], selection[3]
    end_row, end_col = cursor[2], cursor[3]

    -- Normalize selection direction
    if start_row > end_row or (start_row == end_row and start_col > end_col) then
      start_row, end_row = end_row, start_row
      start_col, end_col = end_col, start_col
    end
  else -- normal mode
    start_row = vim.fn.line('.')
    start_col = 1
    end_row = start_row
    end_col = vim.fn.col('$')
  end

  -- Get and process text
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  if #lines == 0 then return end

  local text = mode == 'V' and table.concat(lines, '\n') or
  (mode == 'v' and string.sub(lines[1], start_col, end_col) or lines[1])

  -- Special character conversion (Portuguese diacritics)
  local char_map = {
    -- Lowercase
    ['à']='a', ['á']='a', ['â']='a', ['ã']='a', ['ä']='a', ['å']='a',
    ['è']='e', ['é']='e', ['ê']='e', ['ë']='e',
    ['ì']='i', ['í']='i', ['î']='i', ['ï']='i',
    ['ò']='o', ['ó']='o', ['ô']='o', ['õ']='o', ['ö']='o', ['ø']='o',
    ['ù']='u', ['ú']='u', ['û']='u', ['ü']='u',
    ['ý']='y', ['ÿ']='y',
    ['ñ']='n', ['ç']='c',
    -- Uppercase
    ['À']='A', ['Á']='A', ['Â']='A', ['Ã']='A', ['Ä']='A', ['Å']='A',
    ['È']='E', ['É']='E', ['Ê']='E', ['Ë']='E',
    ['Ì']='I', ['Í']='I', ['Î']='I', ['Ï']='I',
    ['Ò']='O', ['Ó']='O', ['Ô']='O', ['Õ']='O', ['Ö']='O', ['Ø']='O',
    ['Ù']='U', ['Ú']='U', ['Û']='U', ['Ü']='U',
    ['Ý']='Y', ['Ÿ']='Y',
    ['Ñ']='N', ['Ç']='C'
  }

  -- Convert special characters (preserve base letter)
  text = text:gsub('[%z\1-\127\194-\244][\128-\191]*', function(c)
    return char_map[c] or c
  end)

  -- Process filename and extension
  local filename, extension = text:match('^(.*)(%..-)$')
  if not filename then filename, extension = text, '' end

  local new_text = filename:lower()
    :gsub('%s+', '-') -- Spaces to hyphens
    :gsub('[%._]+', '-') -- Periods/underscores to hyphens
    :gsub('[^%w%-]', '') -- Remove remaining non-alphanumeric
    :gsub('%-+', '-') -- Multiple hyphens to single
    :gsub('^%-', '') -- Remove leading hyphen
    :gsub('%-$', '') -- Remove trailing hyphen
  .. extension:lower() -- Preserve extension

  -- Apply changes if different
  if new_text ~= text then
    if mode:match('[vV]') then
      vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {new_text})
    else
      vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, {new_text})
    end
    print('Converted to: ' .. new_text)
  else
    print('Text already formatted')
  end
end

-- Register command
vim.api.nvim_create_user_command('LinuxifyText', linuxify_text, { range = true })

-- LaTeX/BibTeX accents -> UTF-8 (for use inside Neovim)
-- Core converter: handles {\'a}, \'{a}, \'a, {\c{c}}, \c{c}, etc.
local function latex_to_unicode(text)
  if not text or text == "" then return text end

  -- quick specials first
  text = text:gsub("\\i", "i")   -- \i -> i
  text = text:gsub("\\ss", "ß")  -- \ss -> ß

  -- accent maps
  local maps = {
    ["'"] = { a="á", e="é", i="í", o="ó", u="ú", A="Á", E="É", I="Í", O="Ó", U="Ú" },
    ["`"] = { a="à", e="è", i="ì", o="ò", u="ù", A="À", E="È", I="Ì", O="Ò", U="Ù" },
    ["~"] = { a="ã", o="õ", n="ñ", A="Ã", O="Õ", N="Ñ" },
    ["^"] = { a="â", e="ê", i="î", o="ô", u="û", A="Â", E="Ê", I="Î", O="Ô", U="Û" },
    ['"'] = { a="ä", e="ë", i="ï", o="ö", u="ü", A="Ä", E="Ë", I="Ï", O="Ö", U="Ü" },
  }

  local function apply_accent_pattern(txt, pat, cmap)
    return (txt:gsub(pat, function(ch)
      return cmap[ch] or ch
    end))
  end

  -- 1) Braced single: {\'a}, {\"o}, {^e}, {~n}, {`u}
  for mark, cmap in pairs(maps) do
    text = apply_accent_pattern(text, "{\\" .. mark .. "([A-Za-z])}", cmap)
  end

  -- 2) Braced-around-letter: \'{a}, \"{o}, \^{e}, \~{n}, \`{u}
  for mark, cmap in pairs(maps) do
    text = apply_accent_pattern(text, "\\" .. mark .. "{([A-Za-z])}", cmap)
  end

  -- 3) Simple: \'a, \"o, \^e, \~n, \`u
  for mark, cmap in pairs(maps) do
    text = apply_accent_pattern(text, "\\" .. mark .. "([A-Za-z])", cmap)
  end

  -- Cedilla forms: {\c{c}}, \c{c}
  text = text:gsub("{\\c{([Cc])}}", function(c) return (c == "C") and "Ç" or "ç" end)
  text = text:gsub("\\c{([Cc])}",   function(c) return (c == "C") and "Ç" or "ç" end)

  -- IMPORTANT: do NOT strip braces globally; keep BibTeX structure intact.
  return text
end

-- :LatexClean command
-- - Visual mode: cleans only selected lines
-- - Normal mode: cleans the whole buffer
vim.api.nvim_create_user_command("LatexClean", function(opts)
  local bufnr = 0
  local start_line, end_line
  if opts.range == 0 then
    start_line = 0
    end_line = vim.api.nvim_buf_line_count(bufnr)
  else
    start_line = opts.line1 - 1  -- 0-based
    end_line   = opts.line2      -- exclusive
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  for i, l in ipairs(lines) do
    lines[i] = latex_to_unicode(l)
  end
  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, lines)
end, { range = true, desc = "Convert LaTeX accent codes to UTF-8 (preserve braces)" })--- }}}

-- opencode {{{

-- dependencies
-- sudo pacman -S lsof

-- Required for `vim.g.opencode_opts.auto_reload`
vim.opt.autoread = true

-- Configure opencode options
vim.g.opencode_opts = {
  -- Set a specific port since lsof is not available
  -- port = 8080,
  
  -- Enable auto-reload when files change externally
  auto_reload = true,
  
  -- Other useful options
  auto_save = true,
  session_restore = true,
}

-- Configure snacks.nvim for enhanced opencode functionality
require("snacks").setup({
  bigfile = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = { wo = { wrap = false } },
  },
  -- Enable the modules that opencode needs
  input = { enabled = true },
  picker = { enabled = true },
  terminal = { enabled = true },
})

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about this" })
vim.keymap.set({ "n", "x" }, "<leader>o+", function() require("opencode").prompt("@this") end, { desc = "Add this" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
vim.keymap.set("n", "<leader>oc", function() require("opencode").command() end, { desc = "Select command" })
vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New session" })
vim.keymap.set("n", "<leader>oi", function() require("opencode").command("session_interrupt") end, { desc = "Interrupt session" })
vim.keymap.set("n", "<leader>oA", function() require("opencode").command("agent_cycle") end, { desc = "Cycle selected agent" })
vim.keymap.set("n", "<S-C-u>",    function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
vim.keymap.set("n", "<S-C-d>",    function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })

-- opencode terminal leave: Esc Esc
-- if I forget, allow to use vim-tmux-navigator on opencode
-- 
-- Reusable function to register keymaps in different contexts
local function set_tmux_navigator_keymaps()
  vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end

-- Register once globally
set_tmux_navigator_keymaps()

-- Re-register for terminal buffers to prevent literal command injection
vim.api.nvim_create_autocmd("TermOpen", {
  callback = set_tmux_navigator_keymaps,
})

-- DiffChat Command with Better Colors
-- colors
vim.opt.termguicolors = true

local function define_vivid_diff_hl()
  -- Additions → calm emerald
  vim.api.nvim_set_hl(0, "DiffAddVivid", {
    bg = "#103820", fg = "#a6d8b0", bold = false,
  })

  -- Changes → balanced denim blue
  vim.api.nvim_set_hl(0, "DiffChangeVivid", {
    bg = "#182d45", fg = "#94b3e3", bold = false,
  })

  -- Deletions → deep muted crimson
  vim.api.nvim_set_hl(0, "DiffDeleteVivid", {
    bg = "#3a1a1a", fg = "#e5a1a1", bold = false,
  })

  -- Focused changed text (less bright, subtle blue-gray tone)
  vim.api.nvim_set_hl(0, "DiffTextVivid", {
    bg = "#222e3f",  -- darker, less saturated blue-gray
    fg = "#c0cad9",  -- soft neutral foreground
    bold = false,
  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = define_vivid_diff_hl,
})
define_vivid_diff_hl()

local function apply_diff_ui()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local ok, isdiff = pcall(vim.api.nvim_win_get_option, win, "diff")
    if ok and isdiff then
      vim.wo[win].scrollbind   = true
      vim.wo[win].cursorbind   = true
      vim.wo[win].conceallevel = 0
      vim.wo[win].signcolumn   = "yes"
      vim.wo[win].winhighlight =
      "DiffAdd:DiffAddVivid,DiffChange:DiffChangeVivid,DiffDelete:DiffDeleteVivid,DiffText:DiffTextVivid"
    end
  end
end

vim.api.nvim_create_user_command('DiffChat', function(opts)
  local filename = vim.fn.expand('%:t:r')
  local ext      = vim.fn.expand('%:e')
  local version  = opts.args ~= '' and opts.args or '*'
  local pattern  = '.chat/' .. filename .. '-v' .. version .. '.' .. ext

  local files = vim.fn.glob(pattern, false, true)
  if #files == 0 then
    vim.notify('No versions found in .chat/', vim.log.levels.WARN)
    return
  end
  table.sort(files)
  local target = files[#files]

  vim.cmd('vs ' .. target)
  vim.cmd('windo diffthis')

  -- ✅ Apply UI safely (no Vimscript if/endif)
  apply_diff_ui()

  vim.notify('📊 Comparing with: ' .. vim.fn.fnamemodify(target, ':t'), vim.log.levels.INFO)
end, { nargs = '?', desc = 'Diff with .chat/ version' })

-- safety net: re-apply on focus
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  callback = function()
    if vim.wo.diff then
      vim.wo.winhighlight =
      "DiffAdd:DiffAddVivid,DiffChange:DiffChangeVivid,DiffDelete:DiffDeleteVivid,DiffText:DiffTextVivid"
      vim.opt_local.conceallevel = 0
      vim.opt_local.signcolumn = "yes"
    end
  end,
})

-- DiffChatList Command
-- 
vim.api.nvim_create_user_command('DiffChatList', function()
  local filename = vim.fn.expand('%:t:r')
  local ext = vim.fn.expand('%:e')
  local pattern = '.chat/' .. filename .. '-v*.' .. ext

  local files = vim.fn.glob(pattern, false, true)
  if #files == 0 then
    vim.notify('No versions found in .chat/', vim.log.levels.WARN)
    return
  end

  table.sort(files)
  print('📁 Available versions for ' .. filename .. ':')
  for i, file in ipairs(files) do
    print(string.format('  %d. %s', i, vim.fn.fnamemodify(file, ':t')))
  end
end, { desc = 'List all .chat/ versions' })

vim.api.nvim_create_user_command('DiffAccept', function()
  local current = vim.fn.expand('%:p')
  local filename = vim.fn.expand('%:t:r')
  local ext = vim.fn.expand('%:e')
  local latest = vim.fn.glob('.chat/' .. filename .. '-v*.' .. ext, false, true)

  if #latest == 0 then
    vim.notify('No versions found', vim.log.levels.WARN)
    return
  end

  table.sort(latest)
  vim.cmd('!cp ' .. latest[#latest] .. ' ' .. current)
  vim.cmd('e!')
  vim.notify('✅ Accepted changes from: ' .. vim.fn.fnamemodify(latest[#latest], ':t'), vim.log.levels.INFO)
end, { desc = 'Accept latest .chat/ version' })

-- For dark themes - Balanced subtle with syntax control
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Diff backgrounds (subtle)
    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#0f1f0f', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#0f1520', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#1f0f0f', fg = '#404040', bold = false })
    vim.api.nvim_set_hl(0, 'DiffText', { bg = '#1a2535', fg = 'NONE', bold = false })
  end,
})



define_vivid_diff_hl() -- run once at startup too

-- Apply only to diff windows so normal buffers stay clean
local function set_diff_winhighlight()
  if vim.wo.diff then
    vim.wo.winhighlight = table.concat({
      "DiffAdd:DiffAddVivid",
      "DiffChange:DiffChangeVivid",
      "DiffDelete:DiffDeleteVivid",
      "DiffText:DiffTextVivid",
    }, ",")
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  callback = set_diff_winhighlight,
})

-- Keep your optimized diff options
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:60",
}


-- }}}

-- MarkMap {{{

require('markmap').setup({
  cmd = {"MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop"},
  opts = {
    html_output = "/tmp/markmap.html",
    hide_toolbar = false,
    grace_period = 3600000
  },
  config = function(_, opts) require("markmap").setup(opts) end
})

vim.filetype.add({ extension = { mm = "markdown" } })

--- }}}

-- Windows {{{

local ok_wm, wm = pcall(require, 'winmove')
if ok_wm then
  wm.configure({
    modes = {
      resize = { default_resize_count = 3 },
    },
  })
end

local function curwin() return vim.api.nvim_get_current_win() end

--- }}}

-- WhichKey Menu {{{

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

-- make key resolution reliable
vim.o.timeout = true
vim.o.timeoutlen = 500

-- replace default search in /
-- vim.keymap.set('n', '/', '<cmd>lua require("fzf-lua").lgrep_curbuf()<CR>', { noremap = true, silent = true })

-- delete snipp-cut-text) from wich-key
vim.keymap.del('n', '<leader>x')

local wk = require("which-key")

wk.add({
  -- main group
  { "<Space>/", '<cmd>lua require("fzf-lua").lgrep_curbuf()<CR>', desc = "content search here" },
  { "<Space>b", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "buffers find" },
  { "<Space>s", "<cmd>w<CR>", desc = "save" },
  { "<Space>q", "<cmd>q!<CR>", desc = "quite" },
  { "<Space>e", "<cmd>e<CR>", desc = "edit" },
  { "<Space>r", "<cmd>RenameFile<CR>", desc = "rename" },
  -- file peak
  { "<Space>f", group = "[f]ile peak" },
  -- { "<Space>ft", "<cmd>NvimTreeOpen<CR>", desc = "tree open" },
  { "<Space>f/", FilesHereOpen, desc = "/" },
  { "<Space>fh", FilesHomeOpen, desc = "~/" },
  { "<Space>fk", "<cmd>:w <bar> %bd <bar> e# <bar> bd# <CR>", desc = "keep only current buffer" },
  { "<Space>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", desc = "old files" },
  { "<Space>fr", RworkspaceOpen, desc = "/mnt/.../rworkspace" },
  { "<Space>fp", ProfissionalOpen, desc = "/mnt/.../profissional" },
  { "<Space>fd", DownloadsOpen, desc = "~/downloads" },
  { "<Space>fs", SyncOpen, desc = "~/sync" },
  { "<Space>fw", WikiOpen, desc = "~/wiki" },
  { "<Space>fz", WikiZetOpen, desc = "~/wiki/zet" },
  -- content search
  { "<Space>c", group = "[c]ontent search" },
  { "<Space>cb", "<cmd>lua require('fzf-lua').grep()<CR>", desc = "buffers" },
  { "<Space>cd", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "directory" },
  { "<Space>cq", "<cmd>lua require('fzf-lua').lgrep_quickfix()<CR>", desc = "quickfix" },
  { "<Space>ch", HomeGrep, desc = "~/" },
  { "<Space>cp", ProfissionalGrep, desc = "/mnt/.../profissional" },
  { "<Space>cr", RworkspaceGrep, desc = "/mnt/.../rworkspace" },
  { "<Space>cD", DownloadsGrep, desc = "~/downloads" },
  { "<Space>cs", SyncGrep, desc = "~/sync" },
  { "<Space>cw", WikiGrep, desc = "~/wiki" },
  { "<Space>cz", WikiZetGrep, desc = "~/wiki/zet" },
  -- opencode (AI assistant)
  { "<Space>o", group = "[o]pencode" }, -- automatic detection
  -- diff
  { "<leader>d",  group = "󰈙 [d]iff" },
  { "<leader>dc", ":DiffChat<CR>", desc = "Compare latest revision" },
  { "<leader>dv", ":DiffChat ", desc = "Compare specific version" },
  { "<leader>dl", ":DiffChatList<CR>", desc = "List all versions" },
  { "<leader>da", ":DiffAccept<CR>", desc = "Accept latest revision" },
  { "<leader>do", ":diffoff | set noscrollbind nocursorbind<CR>", desc = "Turn off diff mode" },
  { "<leader>dq", ":diffoff | set noscrollbind nocursorbind | q<CR>", desc = "Close diff window" },
  { "<leader>du", ":diffupdate<CR>", desc = "Update diff view" },
  { "<leader>dg", ":diffget<CR>", desc = "Get change from other window" },
  { "<leader>dp", ":diffput<CR>", desc = "Put change to other window" },
  { "<leader>ds", ":diffset<CR>", desc = "Set diff manually" },
  { "<leader>d]", "]c", desc = "next diff change ]c" },
  { "<leader>d[", "[c", desc = "previous diff change [c" },
  { "<leader>dA", ":windo diffthis<CR>", desc = "Enable diff for all windows" },
  { "<leader>dO", ":windo diffoff | set noscrollbind nocursorbind<CR>", desc = "Turn off diff in all windows" },
  -- markdown
  { "<Space>m", group = "[m]arkdown" },
  { "<Space>mt", "<cmd>RenderMarkdown toggle<CR>", desc = "toggle render" },
  { "<Space>md", "<cmd>RenderMarkdown disable<CR>", desc = "disable render" },
  { "<Space>me", "<cmd>RenderMarkdown enable<CR>", desc = "enable render" },
  { "<Space>mg", "<cmd>Goyo<CR>", desc = "goyo" },
  { "<Space>mf", "<cmd>lua insert_manual_fold()<CR>", desc = "insert fold" },
  { "<Space>mF", "<cmd>lua insert_fold_marker()<CR>", desc = "insert fold at end" },
  { "<Space>mm", group = "[m]arkmap" }, -- subgroup
  { "<Space>mmo", "<cmd>MarkmapOpen<CR>", desc = "open" },
  { "<Space>mms", "<cmd>MarkmapSave<CR>", desc = "save" },
  { "<Space>mmw", "<cmd>MarkmapWatch<CR>", desc = "watch" },
  -- Make
  { "<Space>M", group = "[M]ake" },
  { "<Space>Mm", "<cmd>!make<CR>", desc = "make" },
  { "<Space>Md", "<cmd>!make docx<CR>", desc = "make docx" },
  { "<Space>Mp", "<cmd>!make pdf<CR>", desc = "make pdf" },
  { "<Space>MP", "<cmd>!make qppdf<CR>", desc = "make pdf preview" },
  { "<Space>Mh", "<cmd>!make html<CR>", desc = "make html" },
  { "<Space>MH", "<cmd>!make qphtml<CR>", desc = "make html preview" },
  { "<Space>Mr", "<cmd>!make revealjs<CR>", desc = "make revealjs" },
  { "<Space>MR", "<cmd>!make qprevealjs<CR>", desc = "make revealjs preview" },
  { "<Space>Ms", "<cmd>!make qs<CR>", desc = "make qs" },
  { "<Space>Ma", "<cmd>!make all<CR>", desc = "make all" },
  { "<Space>MA", "<cmd>!make All<CR>", desc = "make all sync" },
  { "<Space>Ml", group = "[l]atex" }, -- subgroup
  { "<Space>Mlp", "<cmd>!make pdf<CR>", desc = "make pdf" },
  { "<Space>Mlo", "<cmd>!make pdfopen<CR>", desc = "make pdfopen" },
  { "<Space>Mq", group = "[q]uarto _yml" }, -- subgroup
  { "<Space>Mqr", "<cmd>!make qr<CR>", desc = "quarto render" },
  { "<Space>Mqp", "<cmd>!make qp<CR>", desc = "quarto preview" },
  { "<Space>Mqc", "<cmd>!make qrc<CR>", desc = "quarto render --cache-refresh" },
  { "<Space>Mqs", "<cmd>!make qs<CR>", desc = "quarto sync" },
  { "<Space>Mqa", "<cmd>!make all<CR>", desc = "quarto render sync" },
  { "<Space>MqA", "<cmd>!make qrcs<CR>", desc = "quarto render --cache-refresh sync" },
  -- vim
  { "<Space>v", group = "[v]im" },
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
  { "<Space>vgb", ToggleSpellBoth, desc = "both (pt+en)", mode = { "n", "v" } },
  { "<Space>vge", ToggleSpellEN, desc = "english", mode = { "n", "v" } },
  { "<Space>vgp", ToggleSpellPT, desc = "português", mode = { "n", "v" } },
  { "<Space>vi", group = "[i]nit.lua" }, -- subgroup
  { "<Space>vii", "<cmd>PlugInstall<CR>", desc = "install plugins" },
  { "<Space>viu", "<cmd>PlugUpdate<CR>", desc = "update plugins" },
  { "<Space>vic", "<cmd>PlugClean<CR>", desc = "clean plugins" },
  { "<Space>vis", "<cmd>source ~/.config/nvim/init.lua<CR>", desc = "source init.lua" },
  { "<Space>vf", group = "[f]ormat" }, -- subgroup
  { "<Space>vfc", "<cmd>lua CopyToChunk()<CR>", desc = "copy to chunk", mode = { "v" } },
  { "<Space>vfw", "<cmd>set nowrap!<CR>", desc = "wrap toogle" },
  { "<Space>vfx", "<cmd>%!xmllint --format %<CR>", desc = "xml indent" },
  { "<Space>vfR", "<cmd>%s/\r//g <CR>", desc = "remove ^m" },
  { "<Space>vfD", "<cmd>%s/ \\+/ /g<CR>", desc = 'delete multiple spaces' },
  { "<Space>vfd", "<cmd>lua TrimTrailingWhitespace()<CR>", desc = 'delete space end of line' },
  { "<Space>vfN", "<cmd>Neoformat<CR>", desc = "neoformat", mode = { "n", "v" } },
  { "<Space>vfn", "<cmd>Neoformat<CR>gg=G``", desc = "neoformat + indent", mode = { "n", "v" } },
  { "<Space>vfi", "gg=G``", desc = "indent", mode = { "n", "v" } },
  { "<Space>vfp", "<cmd>%s#%>%#|>#g<CR>", desc = "pipe to |>", mode = { "n", "v" } },
  { "<Space>vfe", "<cmd>ReplaceMathDelimiters<CR>", desc = "equations to $$ or $", mode = { "n", "v" } },
  { "<Space>vff", "<cmd>LinuxifyText<CR>", desc = "filename normalization", mode = { "n", "v" } },
  { "<Space>vfl", "<cmd>LatexClean<CR>", desc = "latex accents → utf-8", mode = { "n", "v" } },
  -- windows {move, swap, resize}
  { "<Space>w", group = "[w]indows" },
  { "<Space>wm", function() require('winmove').start_mode('move') end, desc = "move" },
  { "<Space>ws", function() require('winmove').start_mode('swap') end, desc = "swap" },
  { "<Space>wr", function() require('winmove').start_mode('resize') end, desc = "resize" },
  -- vimWiki
  { "<Space>W", group = "[W]iki" },
  { "<Space>Wt", "<cmd>VimwikiTOC<CR>", desc = "table of contents" },
  { "<Space>Wu", "<cmd>VimwikiUISelect<CR>", desc = "select wiki" },
  { "<Space>Wf", "<cmd>VimwikiFollowLink<CR>", desc = "follow link" },
  { "<Space>Wb", "<cmd>VimwikiBacklinks<CR>", desc = "backlinks" },
  { "<Space>Wg", "<cmd>VimwikiGoto<CR>", desc = "goto" },
  { "<Space>Wr", "<cmd>VimwikiRenameFile<CR>", desc = "rename current file" },
  { "<Space>Ww", "<cmd>VimwikiIndex<CR>", desc = "wiki index open" },
  { "<Space>Wz", "<cmd>lua ZettelIndexOpen()<CR>", desc = "zettel index open" },
  { "<Space>WW", WikiOpen, desc = "~/wiki file finder" },
  { "<Space>WZ", WikiZetOpen, desc = "~/wiki/zet file finder" },
  { "<Space>Wl", "<cmd>lua create_markdown_link()<CR>", desc = "link creator", mode = { "n", "v" } },
  { "<Space>Wy", "<cmd>ZettelYankName<CR>", desc = "yank current filename" },
  { "<Space>W[", "<cmd>ZettelSearch<CR>", desc = "zettel search [[", mode = { "n", "v", "i" } },
  -- LSP / LanguageTool
  { "<Space>l", group = "[l]sp" }, 
  { "<Space>le", "<cmd>LspStart ltex<CR>", desc = "enable ltex", mode = { "n", "v" } },
  { "<Space>ld", "<cmd>LspStop ltex<CR>", desc = "disable ltex", mode = { "n", "v" } },
  { "<Space>lt", LspToggle, desc = "toggle lsp on/off", mode = { "n", "v" } },
  { "<Space>lg", group = "[g]rammar language" }, -- subgroup
  { "<Space>lga", LtexAuto, desc = "auto detect" },
  { "<Space>lge", LtexEnglish, desc = "english (en-US)" },
  { "<Space>lgp", LtexPortuguese, desc = "português (pt-BR)" },
  { "<Space>la", vim.lsp.buf.code_action, desc = "code action (fix)", mode = { "n", "v" } },
  { "<Space>lh", vim.lsp.buf.hover, desc = "hover info" },
  { "<Space>lr", vim.lsp.buf.references, desc = "references" },
  -- { "<Space>ld", vim.lsp.buf.definition, desc = "go to definition" },
  { "<Space>lf", vim.lsp.buf.format, desc = "format" },
  { "<Space>ln", vim.diagnostic.goto_next, desc = "next diagnostic" },
  { "<Space>lp", vim.diagnostic.goto_prev, desc = "previous diagnostic" },
  { "<Space>ll", vim.diagnostic.setloclist, desc = "list diagnostics" },
  { "<Space>ls", vim.diagnostic.open_float, desc = "show diagnostic" },
  { "<Space>lD", "<cmd>bufdo lua vim.lsp.stop_client(vim.lsp.get_clients())<CR>", desc = "disable lsp all buffers", mode = { "n", "v" } },
  { "<Space>l]", vim.diagnostic.goto_next, desc = "next [d" },
  { "<Space>l[", vim.diagnostic.goto_prev, desc = "previous ]d" },
})

--- }}}

-- HTML Comment Modeline Processor {{{

-- Process modelines in HTML comments (<!-- vim: ... -->)
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.qmd", "*.md", "*.html", "*.vimwiki"},
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
      -- Search for <!-- vim: ... -->
      local modeline = line:match("<!%-%-%s*vim:%s*(.-)%s*%-%->")
      if modeline then
        -- Process each option
        for opt in modeline:gmatch("([^%s]+)") do
          local key, value = opt:match("([^=]+)=(.*)")
          if key and value then
            -- Convert string values to appropriate types
            local final_value = value
            if value == "true" then
              final_value = true
            elseif value == "false" then
              final_value = false
            elseif tonumber(value) then
              final_value = tonumber(value)
            end
            
            -- Set the option safely
            pcall(vim.api.nvim_set_option_value, key, final_value, {scope = "local"})
          end
        end
      end
    end
  end,
})

-- }}}

-- vim: fdm=marker foldlevel=0 nowrap
