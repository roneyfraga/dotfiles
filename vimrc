
" ------------------------------
"  General
filetype on
syntax enable
filetype plugin on
filetype indent on
syntax on
set modifiable
set nocompatible
set encoding=utf-8

"  quebra de linha por padrão
set wrap

" destacar coluna e linha onde esta o cursor
" set cuc cul 

"mostra o modo em que estamos
set showmode 

"faz o vim ignorar maiúsculas e minúsculas nas buscas
set ignorecase 

"  linas destacadas
" set cursorline

" usar 256 cores
set t_Co=256

" não destacar buscar
set nohlsearch

" sempre mostrar a barra inferior com o status
set laststatus=2

" funções do mouse funcionando no terminal com tmux
set mouse=a

" make backspace work like most other apps
set backspace=2 

" Enabling clipboard
set clipboard=unnamed


" ------------------------------
" mostrar a coluna número 100, para ter uma noção de espaço 
" set colorcolumn=100
" highlight ColorColumn term=NONE cterm=NONE ctermfg=222  ctermbg=64   gui=NONE guifg=#ffd787 guibg=#5f8700

" ------------------------------
" Cor da barra lateral quando marcas são feitas
hi SignColumn guibg=none
hi SignColumn ctermbg=none
hi SignatureMarkText ctermbg=none

" ------------------------------
" Envia mais caracteres ao terminal, melhorando o redraw de janelas
set ttyfast

" mostrar o número de linhas 
set nu! 

" relative number in lines
set relativenumber

" quebrar linha respeitando as palavras
set linebreak 

" ------------------------------
" By default, Vim indents code by 8 spaces. Most people prefer 4 " spaces: 
" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

" Italic inside tmux
" set t_ZH=^[[3m
" set t_ZR=^[[23m

" ------------------------------
"Better Esc
inoremap jj <esc>
" inoremap jk <esc>

" ------------------------------
" setas do teclado funcinarem no mode inserção com tmux
nnoremap <Esc>A <up>
inoremap <Esc>C <right>
inoremap <Esc>D <left>
inoremap <Esc>A <up>
inoremap <Esc>B <down>
inoremap <Esc>C <right>
inoremap <Esc>D <left>

" ------------------------------
" adicionando o dicionário português do Brasil e inglês
hi clear SpellBad
set spelllang=pt,en 

" não corrigir palavras no início da linha em minúsculo
set spellfile=~/.vim/spell/lowercase.utf-8.add
set spellcapcheck=

" alterando a forma como o vim sinaliza as palavras erradas
hi clear SpellBad
hi SpellBad cterm=underline

" auto spell to markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" utilizar o dicionário como fonte das palavras sugeridas no autocompletar
" set dictionary=/usr/share/dict/words
set complete+=kspell

" desabilita/habilitar o corretor ortográfico
set nospell

" F5 nospell
" F6 spell
map <F5> <Esc>:setlocal nospell<CR>
map <F6> <Esc>:setlocal spell spelllang=pt,en<CR>

"------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Marks in the side bar
Plug 'kshenoy/vim-signature'

" move between vim and tmux with control+hjkl
Plug 'christoomey/vim-tmux-navigator'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" [] () {} '' 
Plug 'vim-scripts/AutoClose'

" move like a pro
Plug 'wikitopian/hardmode'

" comment any file 
Plug 'vim-scripts/tComment'

" easy navegation
Plug 'Lokaltog/vim-easymotion'

" R plugin 
Plug 'jalvesaq/Nvim-R'

" collection of colorschemes
Plug 'joshdick/onedark.vim'

" tabular / alinhar texto
Plug 'godlygeek/tabular'

" TextMate's snippets
Plug 'msanders/snipmate.vim'

" status line
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" rainbow colors to {} [] ()
Plug 'luochen1990/rainbow'

" Gist
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" Buffers
Plug 'moll/vim-bbye'

" Markdown 
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" distraction free :Goyo
Plug 'junegunn/goyo.vim'

" Calendar 
Plug 'itchyny/calendar.vim'

" Python 
Plug 'jalvesaq/vimcmdline'

" Auto complete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" Optional: for snippet support
" Further configuration might be required, read below
" Plug 'sirver/UltiSnips'
" Plug 'ncm2/ncm2-ultisnips'

" LaTeX
 Plug 'lervag/vimtex'

" Initialize plugin system
call plug#end()

"------------------------------------
" Nvim-R
"------------------------------------
"usar espaço para enviar comandos para o R
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" forcar o R a carregar esses pacotes ao iniciar, para ajudar no ominicompletation
let vimrplugin_start_libs = "base,stats,graphics,grDevices,utils,methods,tidyverse,pipeR"

" atalhos com \
nmap <silent> <LocalLeader>t :call RAction("tail")<CR>
nmap <silent> <LocalLeader>h :call RAction("head")<CR>
nmap <silent> <LocalLeader>nm :call RAction("names")<CR>
nmap <silent> <LocalLeader>s :call RAction("str")<CR>
nmap <silent> <LocalLeader>d :call RAction("dim")<CR>
nmap <silent> <LocalLeader>g :call RAction("glimpse")<CR>

" indent with magrittr pipe %>% 
" let g:r_indent_op_pattern = '\(&\||\|+\|-\|\*\|/\|=\|\~\|%\|->\)\s*$'

" porque comentários via \xx não funcionam em arquivos .Rmd
" comment   \xc 
" uncomment \xu
let R_rcomment_string = '# '

" Help
let R_nvimpager = 'horizontal'

" abrir o terminal no R em uma janela independente = 0
let R_in_buffer = 0
let R_term = 'urxvt'   

" ------------------------------
" Buffers and Terminal Mode
let g:airline#extensions#tabline#enabled = 1

" theme
" let g:airline_theme='simple'

" buffers escondidos
set hidden 

" better teminal mode exit
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" mudar entre buffers de forma rápida
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>


" ------------------------------
"  auto completation

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect


" --------------------------------------
"  Python configs
" vimcmdline mappings
let cmdline_term_height = 18     
let cmdline_app           = {}
let cmdline_app['python'] = 'ipython'

" --------------------------------------
" Markdown

" :make 
" :make html
" :make pdf
"
" ou simplismente via atalhos
nmap <leader>mh :!make html 
nmap <leader>mp :!make pdf
nmap <leader>md :!make docx

" vim-pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#modules#disabled = ["folding"]

" MarkdownPreview

" Start the preview
" :MarkdownPreview

" Stop the preview"
" :MarkdownPreviewStop

" ------------------------------
"  fuzzy finder - fzf
nmap ff :FZF<CR>
nmap fh :FZF ~<CR>

"------------------------------
" cCommand - atalho: control _ + control _ 
map <leader>xx <C-_><C-_>

"------------------------------
" Maps to resizing a window split
nnoremap <expr> <C-w>+ v:count1 * 10 . '<C-w>+'
nnoremap <expr> <C-w>- v:count1 * 10 . '<C-w>-'
nnoremap <expr> <C-w>< v:count1 * 10 . '<C-w><'
nnoremap <expr> <C-w>> v:count1 * 10 . '<C-w>>'

" ------------------------------
" snipMate
" arquivos Rnw usando snippets de r tex e rnoweb
au BufRead,BufNewFile *.rnw set ft=rnoweb.r.tex
" arquivos  Rmd usando snippets de r e rmd
au BufRead,BufNewFile *.rmd set ft=rmd.r

"------------------------------
" Backup files
" turn on backup
set backup
" Set where to store backups
set backupdir=~/.vimbackup
" Set where to store swap files
set dir=~/.vimbackup

"------------------------------
" desabilitar o barulho chato no macvim e 
" tb no vim, independente do terminal
autocmd! GUIEnter * set vb t_vb=

"------------------------------
" Vim Gist
" ver ~/.gist.vim para acessar o token fornecido pelo Github
let g:gist_clip_command = 'pbcopy'
let g:gist_post_private = 1
" let g:gist_post_anonymous = 1
let g:gist_open_browser_after_post = 1

"------------------------------
" HTML
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

"------------------------------
" Mutt
" quebras de linhas bonitas
" em todos os ambientes de edição de texto
" atrapalha a edição de LaTex
" setlocal fo+=aw

"------------------------------
" vimtex - LaTex

let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'

" NCM2
augroup NCM2
  autocmd!
  " some other settings...
  " uncomment this block if you use vimtex for LaTex
  autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END

"------------------------------
" Vim Hard Mode
" desables hjkl, arrow keys and page up/down
" \hd para mudar o modo de uso
autocmd VimEnter,BufNewFile,BufReadPost * silent! call EasyMode()
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>hd <Esc>:call ToggleHardMode()<CR>
" :call EasyMode() para sair 

"------------------------------
" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 0

" ------------------------------
"  MarkdownPreview

" set to 1, nvim will open the preview window after entering the markdown 
" buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'qutebrowser'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


"------------------------------
" clipboard
let g:clipboard = {
  \   'name': 'xclip-xfce4-clipman',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }

"------------------------------
" luochen1990/rainbow
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

