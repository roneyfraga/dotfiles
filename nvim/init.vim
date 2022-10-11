
" General ------------------------------{{{
filetype on
syntax enable
filetype plugin on
filetype indent on
syntax on
set modifiable
set nocompatible
set encoding=utf-8

"  no break lines by default
set nowrap

"mostra o modo em que estamos
set showmode 

"faz o vim ignorar maiusculas e minusculas nas buscas
set ignorecase 

" usar 256 cores
set t_Co=256

" nao destacar buscar
set nohlsearch

" funcoes do mouse funcionando no terminal com tmux
set mouse=a

" make backspace work like most other apps
set backspace=2 

" Enabling clipboard
set clipboard=unnamed

" Envia mais caracteres ao terminal, melhorando o redraw de janelas
set ttyfast

" mostrar o numero de linhas 
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

" Highlight Color  ------------------------------{{{
" SideBar,StatusBar and Menus
" Cor da barra lateral quando marcas sao feitas
highlight SignColumn guibg=none
highlight SignColumn ctermbg=none
highlight SignatureMarkText ctermbg=none

" tabline
highlight TabLine gui=NONE guibg=NONE guifg=NONE cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE
highlight TabLineFill term=NONE cterm=NONE ctermbg=NONE

" menu de autocompletar
highlight Pmenu ctermfg=7 ctermbg=0
highlight PmenuSel ctermfg=0 ctermbg=7

" destacar enquanto yank
highlight HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A

"}}}

" Spell check ------------------------------{{{
"
" dicionario em dois idiomas
setlocal nospell spelllang=pt,en

" alterando a forma como o vim sinaliza as palavras erradas
hi clear SpellBad
hi SpellBad cterm=underline

" nao corrigir palavras no inicio da linha em minusculo
set spellfile=~/.config/nvim/spell/lowercase.utf-8.add
set spellcapcheck=

" control + n
" utilizar o dicionario como fonte das palavras sugeridas no autocompletar
set dictionary=/usr/share/dict/words
set complete+=kspell

" n„o precisa do nospell, pois, 'spell!' È toggle
" F2 pt_br
" F3 en_us
" F4 pt_br, en_us
nmap <F2> :set spell! spelllang=pt<CR>
nmap <F3> :set spell! spelllang=en<CR>
nmap <F4> :set spell! spelllang=pt,en<CR>


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

" Git
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'
Plug 'junegunn/gv.vim'

" Register on side bar: " ou @ in normal mode; Control+R in normal mode
Plug 'junegunn/vim-peekaboo'

" comment any file with motion gc[motion] 
Plug 'tpope/vim-commentary'

" repeat vim and plugin commands with .
Plug 'tpope/vim-repeat'

" R plugin 
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" collection of colorschemes
Plug 'joshdick/onedark.vim'

" tabular / alinhar texto
Plug 'godlygeek/tabular'

" rainbow colors to {} [] ()
Plug 'luochen1990/rainbow'

" Gist
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

"  Delete buffer withou messing the layout :Bd
Plug 'moll/vim-bbye'

" Markdown 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" distraction free :Goyo
Plug 'junegunn/goyo.vim'

" Calendar 
" Plug 'itchyny/calendar.vim'

" Python, Julia, Go
Plug 'jalvesaq/vimcmdline'

" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" snippets 
Plug 'roneyfraga/vim-snippets'

" LaTeX
Plug 'lervag/vimtex'

" bracket mappings - quickfix navigation
Plug 'tpope/vim-unimpaired'

" Rename Mkdir Move Delete Unlink
Plug 'tpope/vim-eunuch'

" surround a object with (`c` chance, `d` delete, `y` you surround) 
Plug 'tpope/vim-surround'

" wiki 
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'

" slide presentation
Plug 'sotte/presenting.vim'

" nnn inside vim
Plug 'mcchrish/nnn.vim'

" vifm inside vim
" Plug 'vifm/vifm.vim'

" julia 
Plug 'JuliaEditorSupport/julia-vim'

" vim go language
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Initialize plugin system
call plug#end()
"}}}

" Nvim-R ------------------------------------{{{
" 
"usar espaco para enviar comandos para o R
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" forcar o R a carregar esses pacotes ao iniciar, para ajudar no ominicompletation
let vimrplugin_start_libs = "base,stats,graphics,grDevices,utils,methods,dplyr,fs,purrr"

" atalhos com \
nmap <silent> <LocalLeader>t :call RAction("tail")<CR>
nmap <silent> <LocalLeader>h :call RAction("head")<CR>
nmap <silent> <LocalLeader>nm :call RAction("names")<CR>
nmap <silent> <LocalLeader>v :call RAction("View")<CR>
nmap <silent> <LocalLeader>s :call RAction("str")<CR>
nmap <silent> <LocalLeader>d :call RAction("dim")<CR>
nmap <silent> <LocalLeader>g :call RAction("glimpse")<CR>

" porque tComment (control_ + control_) nao funciona em arquivo .Rmd
" comment   \xc 
" uncomment \xu
" let R_rcomment_string = '# '

" grave accent (backtick) is replaced with chunk delimiters, disable
" let R_rmdchunk = 0

" __ to <-
let R_assign = 2

" Help
let R_nvimpager = 'horizontal'

" abrir o terminal no R em uma janela independente 
" let R_external_term = 'urxvt'
" let R_external_term = 0

let hostname = substitute(system('hostname'), '\n', '', '')

if hostname == "frank"
    " let R_external_term = 'urxvt'
    let R_external_term = 0
elseif hostname == "fusca"
    let R_external_term = 0
elseif hostname == "x270"
    let R_external_term = 0
elseif hostname == "guarani"
    " let R_external_term = 'urxvt'
    " let R_external_term = 0
endif

" function to ident R code as lintr pattern
" :call Rlimpo()
function! Rlimpo()
    :s/,/, /ge
    :s/ ,/,/ge
    :s/-/ - /ge
    :s/+/ + /ge
    :s/*/ * /ge
    :s/\// \/ /ge
    :s/=/ = /ge
    :s/ =  = / == /ge
    :s/ \{2\}/ /ge
    :s/\[\s/\[/ge
    :s/\] )/\])/ge
    :s/ )/)/ge
    :s/ - - /--/ge
    :s/</ < /ge
    :s/>/ > /ge
    :s/< =/ <= /ge
    :s/> =/ >= /ge
    :s/>/ > /ge
    :s/! =/ != /ge
    :s/ \{2\}/ /ge
    :s/< -/<-/ge
    :s/| >/|>/ge
endfunction
 

" }}}

" CoC ------------------------------------{{{
"
" install extensions
" :CocInstall coc-json coc-git coc-python coc-vimlsp coc-r-lsp coc-snippets coc-texlab coc-explorer coc-yank coc-omni coc-dictionary

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
" nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> ;a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> ;e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> ;c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> ;o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> ;s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> ;j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> ;k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> ;p  :<C-u>CocListResume<CR>

" coc-yank
nnoremap <silent> ;y  :<C-u>CocList -A --normal yank<cr>

" coc-extensions
nnoremap ;x :CocCommand explorer<CR>


" }}}

" fuzzy finder - fzf ------------------------------{{{
nmap ;. :Files<cr>
nmap ;h :Files ~<cr>
nmap ;w :Files ~/Wiki<CR>
nmap ;b :Buffers<CR>
nmap ;l :BLines<CR>
nmap ;L :Lines<CR>

" \ca close all buffers except the current one
nnoremap <leader>ca :w <bar> %bd <bar> e# <bar> bd# <CR>

"}}}

" Maps to resizing a window split ------------------------------{{{
nnoremap <expr> <C-w>+ v:count1 * 10 . '<C-w>+'
nnoremap <expr> <C-w>- v:count1 * 10 . '<C-w>-'
nnoremap <expr> <C-w>< v:count1 * 10 . '<C-w><'
nnoremap <expr> <C-w>> v:count1 * 10 . '<C-w>>'
" }}}

" snippets ------------------------------{{{
" 
" arquivos Rnw usando snippets de r tex e rnoweb
" au BufRead,BufNewFile *.rnw set ft=rnoweb.r.tex
" arquivos  Rmd usando snippets de r e rmd
" au BufRead,BufNewFile *.rmd set ft=rmd.r
" au BufRead,BufNewFile *.Rmd set ft=rmd.r
" }}}

" Backup files ------------------------------ {{{
" 
" turn on backup
set nobackup
" Set where to store backups
" set backupdir=~/.vimbackup
" Set where to store swap files
" set dir=~/.vimbackup
" }}}

" Vim Gist ------------------------------{{{
" 
" ver ~/.gist.vim para acessar o token fornecido pelo Github
let g:gist_clip_command = 'pbcopy'
let g:gist_post_private = 1
" let g:gist_post_anonymous = 1
let g:gist_open_browser_after_post = 1
" }}}

" HTML or XML------------------------------{{{
" 
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" indent xml
" `:%!xmllint --format %`

" fold and syntax
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" }}}

" Vim Hard Mode ------------------------------{{{
" disables hl arrow keys

map <left> <nop>
map <right> <nop>
map <Up> <Nop>
map <Down> <Nop>

" bad habits
" map l <nop>
" map h <nop>

" }}}

" Markdown --------------------------------------{{{
" 

" txt as markdown
" autocmd BufRead,BufNewFile *.txt set filetype=markdown

" :make 
" :make html
" :make pdf
"
" ou simplismente via atalhos
nmap <leader>mm :!make<CR>  
nmap <leader>mh :!make html 
nmap <leader>mp :!make pdf
nmap <leader>md :!make docx
nmap <leader>mr :!make rsync_book<CR>  
nmap <leader>ma :!make all<CR>  

" vim-pandoc
" let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" let g:pandoc#modules#disabled = ["folding"]

" MarkdownPreview
"
" :MarkdownPreview
" :MarkdownPreviewStop
" :MarkdownPreviewToggle

" nmap <C-s> <Plug>MarkdownPreview
" nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
" }}}

" Markdown VimWiki --------------------------------------{{{
" 
let g:vimwiki_list = [
    \{'path': '~/Wiki/', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/aaTODO', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Actions', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Books', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Class_Stack', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/CLI', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Cozer', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Cpp', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/English', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Math', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Orientacoes', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Papers', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Photo', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Portal_Periodicos', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Portugues', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Projects_Stack', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Publications', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Python', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/R', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/Reflexoes', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Wiki/RES', 'syntax': 'markdown', 'ext': '.md'}]

" funÁ„o para formatar nome do arquivo: 
" espaÁo substituir≠por - 
" caracteres em ascii
"
func! Rename2ascii()
    execute "normal yypV"
    s/\s\+/ /g 
    s/\s\+$//g 
    s/ /-/g 
    s/-\+/-/g 
    s/[[=a=]]/a/g 
    s/[[=e=]]/e/g 
    s/[[=i=]]/i/g 
    s/[[=o=]]/o/g 
    s/[[=u=]]/u/g  
    s/[[=n=]]/n/g 
    s/[[=c=]]/c/g
    execute "normal 0i($a)k0i[$a]Jxli"
endfunc

" Time Stamps
inoremap <F6> <C-R>=strftime("%Y-%m-%d ")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d ")<CR>P
inoremap <F7> <C-R>=strftime("%Y-%m-%d_%H:%M")<CR>
nnoremap <F7> "=strftime("%Y-%m-%d_%H:%M")<CR>P
inoremap <F8> <C-R>=strftime("%Y%m%d-%H%M%S-")<CR>
nnoremap <F8> "=strftime("%Y%m%d-%H%M%S-")<CR>P

" remove ^M quebra de p·gina
nnoremap <F9> :%s/\r//g <CR>

" wrap
nnoremap <F10> :set wrap! <CR>

" }}}

" MarkdownPreview ---------{{{
"  
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'firefox'
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
let g:mkdp_page_title = '„Äå${name}„Äç'
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

set laststatus=2
set statusline= 
set statusline+=%#PmenuSel#         " fundo dourado
set statusline+=%{StatuslineGit()}  " fun√ß√£o para obter branch
set statusline+=%#LineNr#           " fundo transparente
set statusline+=\ %F\               " file name and Path
set statusline+=%m                  " + to edited file
set statusline+=\ [%n]\               " file name and Path
set statusline+=%=                  " alinhar a direita
set statusline+=%#PmenuSel#         
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " encoding
set statusline+=\ %p%%                                     " porcentagem
set statusline+=\ %l:%c                                    " linhas

set noshowcmd
set cmdheight=1


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

" C++ configs ------------------------------ {{{
"
" adapted from
" https://github.com/mizlan/vim-and-cp
" https://www.youtube.com/watch?v=I4Rz0qoWYBI

" important option that should already be set!
set hidden
set splitbelow
set splitright

function! TermWrapperVertical(command) abort
    let buffercmd = 'vnew'
    exec buffercmd
    exec 'term ' . a:command
    exec 'startinsert'
endfunction

function! TermWrapperHorizontal(command) abort
    let buffercmd = 'new'
    exec buffercmd
    exec 'term ' . a:command
    exec 'startinsert'
endfunction

command! -nargs=0 CompileAndRunVertical call TermWrapperVertical(printf('g++ -std=c++20 %s && ./a.out', expand('%')))
command! -nargs=0 CompileAndRunHorizontal call TermWrapperHorizontal(printf('g++ -std=c++20 %s && ./a.out', expand('%')))
command! -nargs=1 CompileAndRunWithFile call TermWrapperVertical(printf('g++ -std=c++20 %s && ./a.out < %s', expand('%'), <args>))

autocmd FileType cpp nnoremap <leader>h :CompileAndRunHorizontal<CR>
autocmd FileType cpp nnoremap <leader>v :CompileAndRunVertical<CR>
autocmd FileType cpp nnoremap <leader>r :!./a.out<CR>
autocmd FileType cpp nnoremap <leader>b :!g++ -std=c++20 % && ./a.out<CR>
" }}}

" Git ------------------------------ {{{
nnoremap gB :GBranches<CR>
nnoremap gT :GTags<CR>
nnoremap gC :GV<CR>
" }}}

" Presentation ------------------------------ {{{
" letters to the box
au Filetype markdown nnoremap <buffer> <F12> :.!toilet -w 200 -f term -F border<CR>

" }}}

" Quickfix and Grep ------------------------------ {{{
"
" nowrap in quickfix window
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal nowrap
augroup END

" open quickfix-window after: :make, :grep, :lvimgrep and friends
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END
" }}}

" vifm ------------------------------ {{{
"

nmap <LocalLeader>f :EditVifm<CR>

" }}}

" Python, Julia and vimcmdline------------------------------ {{{
"
" vimcmdline mappings

let cmdline_app           = {}
let cmdline_app['python'] = 'ipython'

" <LocalLeader>s to start the interpreter.
" <Space> to send the current line to the interpreter.
" <LocalLeader><Space> to send the current line to the interpreter and keep the cursor on the current line.
" <LocalLeader>q to send the quit command to the interpreter.
" <Space> to send a selection of text to the interpreter.
" <LocalLeader>p to send from the line to the end of paragraph.
" <LocalLeader>b to send block of code between the two closest marks.
" <LocalLeader>f to send the entire file to the interpreter.
" <LocalLeader>m to send the text in the following motion to the interpreter. For example 
" <LocalLeader>miw would send the selected word.

" }}}


" Source Nvim configuration file and install plugins
nnoremap <leader>1 :source ~/.config/nvim/init.vim <CR>
nnoremap <leader>2 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" force to disable dictionary in markdown files
" autocmd BufRead,BufNewFile *.Rmd,*.md set nospell 
" autocmd BufRead,BufNewFile *.Rmd,*.md set wrap

" vim: fdm=marker nowrap
"
