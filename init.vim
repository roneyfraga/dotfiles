
" General ------------------------------{{{
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

"mostra o modo em que estamos
set showmode 

"faz o vim ignorar maiúsculas e minúsculas nas buscas
set ignorecase 

" usar 256 cores
set t_Co=256

" não destacar buscar
set nohlsearch

" funções do mouse funcionando no terminal com tmux
set mouse=a

" make backspace work like most other apps
set backspace=2 

" Enabling clipboard
set clipboard=unnamed

" Envia mais caracteres ao terminal, melhorando o redraw de janelas
set ttyfast

" mostrar o número de linhas 
set nu! 

" relative number in lines
set relativenumber

" quebrar linha respeitando as palavras
set linebreak 

"Better Esc
inoremap jj <esc>

" better Teminal Mode exit
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

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
set t_ZH=^[[3m
set t_ZR=^[[23m

" italic to comment
highlight Comment cterm=italic

"}}}

" SideBar and StatusBar ------------------------------{{{
" Cor da barra lateral quando marcas são feitas
hi SignColumn guibg=none
hi SignColumn ctermbg=none
hi SignatureMarkText ctermbg=none

let buftabline_show = 0

highlight TabLine gui=NONE guibg=NONE guifg=NONE cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE
highlight TabLineFill term=NONE cterm=NONE ctermbg=NONE
"}}}

" Spell check ------------------------------{{{
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
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" utilizar o dicionário como fonte das palavras sugeridas no autocompletar
" set dictionary=/usr/share/dict/words
set complete+=kspell

" desabilita/habilitar o corretor ortográfico
set nospell

" F2 pt_br
" F3 en_us
" F4 pt_br, en_us
" F5 nospell
nmap <F2> :setlocal spell spelllang=pt_br<CR>
nmap <F3> :setlocal spell spelllang=en_us<CR>
nmap <F4> :setlocal spell spelllang=pt_br,en_us<CR>
nmap <F5> :setlocal nospell<CR>
"}}}

" Plugins ------------------------------------{{{
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Marks in the side bar
Plug 'kshenoy/vim-signature'

" move between vim and tmux with control+hjkl
Plug 'christoomey/vim-tmux-navigator'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" move like a pro
Plug 'wikitopian/hardmode'

" comment any file 
Plug 'vim-scripts/tComment'

" R plugin 
Plug 'jalvesaq/Nvim-R'

" collection of colorschemes
Plug 'joshdick/onedark.vim'

" tabular / alinhar texto
Plug 'godlygeek/tabular'

" status line
" Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" rainbow colors to {} [] ()
Plug 'luochen1990/rainbow'

" Gist
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

"  Delete buffer withou messing the layout :Bd
Plug 'moll/vim-bbye'

" Buffers in tabs
Plug 'ap/vim-buftabline'

" Markdown 
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" distraction free :Goyo
Plug 'junegunn/goyo.vim'

" Calendar 
" Plug 'itchyny/calendar.vim'

" Python
Plug 'jalvesaq/vimcmdline'

" Auto complete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'              "nvim support: pip3 install pynvim
Plug 'gaalcaras/ncm-R'              "r
Plug 'ncm2/ncm2-jedi'               "python
Plug 'ncm2/ncm2-bufword'            "buffers
Plug 'ncm2/ncm2-path'               "paths
Plug 'ncm2/ncm2-pyclang'            "c++
Plug 'ncm2/ncm2-match-highlight'    "matches highlight 

" Snipmate 
Plug 'ncm2/ncm2-snipmate'
Plug 'tomtom/tlib_vim'              
Plug 'marcweber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'          
Plug 'roneyfraga/vim-snippets'      "snippets source           

" LaTeX
Plug 'lervag/vimtex'

" bracket mappings
Plug 'tpope/vim-unimpaired'

" grammar checker
Plug 'dpelle/vim-LanguageTool'

" syntax check
" Plug 'dense-analysis/ale'

" neovim in browser text box
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Initialize plugin system
call plug#end()
"}}}

" Nvim-R ------------------------------------{{{
" 
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

" porque tComment (control+_ control+_) não funciona em arquivo .Rmd
" comment   \xc 
" uncomment \xu
let R_rcomment_string = '# '

" Help
let R_nvimpager = 'horizontal'

" abrir o terminal no R em uma janela independente 
" let R_external_term = 'urxvt'
let R_external_term = 0
" }}}

" ncm2 ------------------------------{{{
"  auto completation - ncm2

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" select an item in the poup-up menu without insert a new line control-y"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'css',
            \ 'priority': 9,
            \ 'subscope_enable': 1,
            \ 'scope': ['css','scss'],
            \ 'mark': 'css',
            \ 'word_pattern': '[\w\-]+',
            \ 'complete_pattern': ':\s*',
            \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
            \ })

"-----------
" ncm2 pyclang c++
"
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-5.0/lib'

" gd go to declaration
autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>

"-----------
" ncm2 + vimtex
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 1,
            \ 'subscope_enable': 1,
            \ 'complete_length': 1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \           'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \               {'name': 'prefix', 'key': 'word'},
            \           ]},
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })

"-----------
" ncm2 + snippets completation
" tab 
inoremap <silent> <expr> <CR> ncm2_snipmate#expand_or("\<CR>", 'n')

" control+u
inoremap <expr> <c-u> ncm2_snipmate#expand_or("\<Plug>snipMateTrigger", "m")
"}}}

" Python configs --------------------------------------{{{
" vimcmdline mappings
let cmdline_term_height = 18     
let cmdline_app           = {}
let cmdline_app['python'] = 'ipython'
"}}}

" fuzzy finder - fzf ------------------------------{{{
nmap ;. :FZF<CR>
nmap ;h :FZF ~<CR>
nmap ;b :Buffers<CR>
nmap ;f :Rg<CR>
"}}}

" Maps to resizing a window split ------------------------------{{{
nnoremap <expr> <C-w>+ v:count1 * 10 . '<C-w>+'
nnoremap <expr> <C-w>- v:count1 * 10 . '<C-w>-'
nnoremap <expr> <C-w>< v:count1 * 10 . '<C-w><'
nnoremap <expr> <C-w>> v:count1 * 10 . '<C-w>>'
" }}}

" snipMate ------------------------------{{{
" 
" arquivos Rnw usando snippets de r tex e rnoweb
au BufRead,BufNewFile *.rnw set ft=rnoweb.r.tex
" arquivos  Rmd usando snippets de r e rmd
au BufRead,BufNewFile *.rmd set ft=rmd.r
" }}}

" Backup files ------------------------------ {{{
" 
" turn on backup
set backup
" Set where to store backups
set backupdir=~/.vimbackup
" Set where to store swap files
set dir=~/.vimbackup
" }}}

" Vim Gist ------------------------------{{{
" 
" ver ~/.gist.vim para acessar o token fornecido pelo Github
let g:gist_clip_command = 'pbcopy'
let g:gist_post_private = 1
" let g:gist_post_anonymous = 1
let g:gist_open_browser_after_post = 1
" }}}

" HTML ------------------------------{{{
" 
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" }}}

" Latex ------------------------------{{{
" vimtex + ncm2 

let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
" }}}

" Vim Hard Mode ------------------------------{{{
" 
" desables hjkl, arrow keys and page up/down
" \hd para mudar o modo de uso
autocmd VimEnter,BufNewFile,BufReadPost * silent! call EasyMode()
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>hd <Esc>:call ToggleHardMode()<CR>
" :call EasyMode() para sair 
" }}}

" Markdown --------------------------------------{{{
" 

" :make 
" :make html
" :make pdf
"
" ou simplismente via atalhos
nmap <leader>mm :!make<CR>  
nmap <leader>mh :!make html 
nmap <leader>mp :!make pdf
nmap <leader>md :!make docx

" vim-pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#modules#disabled = ["folding"]

" MarkdownPreview
"
" :MarkdownPreview
" :MarkdownPreviewStop
" :MarkdownPreviewToggle

" nmap <C-s> <Plug>MarkdownPreview
" nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
" }}}

" MarkdownPreview ---------{{{
"  
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'qutebrowser'
let g:mkdp_echo_preview_url = 1
let g:mkdp_browserfunc = ''
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
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
"}}}

" clipboard ------------------------------{{{
" 
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
  \}
"}}}

" luochen1990/rainbow ------------------------------{{{
" 
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
"}}}

" Status Line ------------------------------ {{{

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %l:%c
"}}}

" Zoom in buffer ------------------------------ {{{
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
" }}}

" LanguageTool ------------------------------ {{{
"
" set spelllang=en_us
" set spelllang=pt_br
"
let g:languagetool_jar='$HOME/languagetool/languagetool-standalone/target/LanguageTool-5.0-SNAPSHOT/LanguageTool-5.0-SNAPSHOT/languagetool-commandline.jar'

" grammar errors in blue, and spelling errors in red
hi LanguageToolGrammarError  guisp=blue gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=blue term=underline cterm=none
hi LanguageToolSpellingError guisp=red  gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=red  term=underline cterm=none

let g:languagetool_disable_rules='ENGLISH_WORD_REPEAT_BEGINNING_RULE,WHITESPACE_RULE,EN_QUOTES,FRENCH_WHITESPACE,UPPERCASE_SENTENCE_START,APOS'

let g:languagetool_enable_rules='PASSIVE_VOICE'
" }}}

" C++ configs ------------------------------ {{{
"
" https://github.com/mizlan/vim-and-cp
"
let g:os = substitute(system('uname'), '\n', '', '')

" important option that should already be set!
set hidden

" available options:
" * g:split_term_style
" * g:split_term_resize_cmd
function! TermWrapper(command) abort
	if !exists('g:split_term_style') | let g:split_term_style = 'vertical' | endif
	if g:split_term_style ==# 'vertical'
		let buffercmd = 'vnew'
	elseif g:split_term_style ==# 'horizontal'
		let buffercmd = 'new'
	else
		echoerr 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'' but is currently set to ''' . g:split_term_style . ''')'
		throw 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'')'
	endif
	if exists('g:split_term_resize_cmd')
		exec g:split_term_resize_cmd
	endif
	exec buffercmd
	exec 'term ' . a:command
	exec 'startinsert'
endfunction

command! -nargs=0 CompileAndRun call TermWrapper(printf('g++ -std=c++11 %s && ./a.out', expand('%')))
command! -nargs=1 CompileAndRunWithFile call TermWrapper(printf('g++ -std=c++11 %s && ./a.out < %s', expand('%'), <args>))
autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>

" For those of you that like to use the default ./a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
" NOTE: this version is more stable than the other version with specified
" output executable!
augroup CppToolkit
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 % && ./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>
augroup END

" options
" choose between 'vertical' and 'horizontal' for how the terminal window is split
" (default is vertical)
" let g:split_term_style = 'vertical'

" add a custom command to resize the terminal window to your preference
" (default is to split the screen equally)
" let g:split_term_resize_cmd = 'vertical resize 30'
" (or let g:split_term_resize_cmd = 'vertical resize 40')
"
" }}}

" vim: fdm=marker nowrap