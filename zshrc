# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/roney/.oh-my-zsh"

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="afowler"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z fzf zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

export EDITOR='nvim'
export VISUAL='nvim'
# export READER='zathura'
# # export TERMINAL='st'
# export TRUEBROWSER='firefox'
# export VIDEO='mpv'

if [ $(hostname) = 'lisa' ]; 
then
    export BIB=/mnt/raid0/pessoal/OneDrive/CLI/bibliography.bib
else 
    export BIB=$HOME/OneDrive/CLI/bibliography.bib
fi

# fzf
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="\
    --multi --no-height\
    --bind=ctrl-b:backward-kill-word\
    --bind=ctrl-g:top\
    --bind=ctrl-u:page-up\
    --bind=ctrl-d:page-down\
    --bind=ctrl-f:toggle-all\
    --bind=ctrl-q:clear-query\
    --bind=ctrl-s:clear-selection\
    --bind=ctrl-o:jump\
    --bind=ctrl-c:cancel\
    --bind=ctrl-y:yank\
    --bind=ctrl-p:toggle-preview\
    --bind=ctrl-t:toggle-all\
    --bind=ctrl-z:deselect-all\
    --bind=tab:toggle+down\
    --bind=shift-tab:toggle+up\
    "

# CREDENTIALS
if [ $(hostname) = 'lisa' ]; 
then
    source /mnt/raid0/Pessoal/OneDrive/CLI/dotfiles/credentials/elsevier.sh
else 
    source $HOME/OneDrive/CLI/dotfiles/credentials/elsevier.sh
fi

# zsh-autosuggestions
bindkey '^]' autosuggest-accept
bindkey '^p' autosuggest-toggle

# monitor orientation: benq 27" + samsung 24"
if [ $(hostname) = 'lisa' ]; 
then
    alias hori='xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x0 --rotate normal --output DVI-D-0 --off'
    alias vert='xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x480 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x0 --rotate right --output DVI-D-0 --off'
fi

# nnn (n)
export NNN_PLUG='c:fzcd;o:fzopen;d:dragdrop;v:imgview;p:preview-tabbed;n:nuke;l:launch;k:pskill;m:mimelist;x:xdgdefault'
export NNN_COLORS="5136" 
export NNN_ARCHIVE="\\.(zip|7z|bz2|gz|tar|tgz)$"
export NNN_TRASH=1  # needs trash-cli                               
export NNN_FIFO=/tmp/nnn.fifo
export NNN_OPENER=nuke

if [ $(hostname) = 'lisa' ]; 
then
    export NNN_BMS='k:~/Desktop;w:~/Downloads;0:/mnt/raid0;r:/mnt/raid0/Pessoal/OneDrive/Rworkspace;p:/mnt/raid0/Pessoal/OneDrive/Profissional;i:/mnt/raid0/Pessoal/OneDrive/CLI;B:/mnt/raid0/Pessoal/OneDrive/Biblioteca;P:/mnt/raid0/Pessoal/OneDrive/Profissional/PubPar;h:~;s:~/Sync'
else 
    export NNN_BMS='k:~/Desktop;w:~/Downloads;r:~/OneDrive/Rworkspace;p:~/OneDrive/Profissional;m:/media;i:~/OneDrive/CLI;B:~/OneDrive/Biblioteca;P:~/OneDrive/Profissional/PubPar;h:~;s:~/Sync'
fi

# softwares
alias f='vifm .'
alias t='env TERM=screen-256color tmux'
alias v='nvim'
alias vw='cd ~/Wiki; nvim index.md'
alias rrsync='rsync -lhr --info=progress2'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias x='clear'
alias l='ls -lNh --color=auto --group-directories-first'
alias yt='youtube-dl'
alias ref='source ~/.zshrc'
alias aq='asciiquarium'
alias h='htop'
alias zt='zathura'
alias penlabel='ls /dev/disk/by-label/'
alias py='python'
alias def='goldendict'
alias syn='~/bin/dicsyn.R'
alias doi2bib='~/bin/doi2bibtex.R'
alias youtube-dl-audio='youtube-dl --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'
alias timer='termdown'
alias verb='cat $HOME/OneDrive/CLI/verbs.md | fzf --multi --ansi --preview-window=:hidden'
alias info2='screenfetch'

# files
alias init.vim="nvim ~/.config/nvim/init.vim"
alias zshrc="nvim ~/.zshrc"
alias tmux.conf='nvim ~/.tmux.conf'
alias i3c='nvim ~/.config/i3/config'
alias zathurarc='nvim ~/.config/zathura/zathurarc'

# places 
alias dk='cd ~/Desktop'
alias dw='cd ~/Downloads'

# places lisa
if [ $(hostname) = 'lisa' ]; then
    alias r0='cd /mnt/raid0'
    alias one='cd /mnt/raid0/Pessoal/OneDrive/'
    alias rw='cd /mnt/raid0/Pessoal/OneDrive/Rworkspace'
    alias pubpar='cd /mnt/raid0/Pessoal/OneDrive/Profissional/PubPar'
    alias prof='cd /mnt/raid0/Pessoal/OneDrive/Profissional'
    alias lat='cd /mnt/raid0/Pessoal/OneDrive/Profissional/Latex'
    alias ori='cd /mnt/raid0/Pessoal/OneDrive/Profissional/UFMT\ -\ Orientacoes'
    alias cli='cd /mnt/raid0/Pessoal/OneDrive/CLI'
    alias dot='cd /mnt/raid0/Pessoal/OneDrive/CLI/dotfiles'
    alias qualis='cd /mnt/raid0/Pessoal/OneDrive/Profissional/PubPar/Qualis'
    alias rd='cd /mnt/raid0/'
else 
    alias rw='cd ~/OneDrive/Rworkspace'
    alias pubpar='cd ~/OneDrive/Profissional/PubPar'
    alias prof='cd ~/OneDrive/Profissional'
    alias lat='cd ~/OneDrive/Profissional/Latex'
    alias ori='cd ~/OneDrive/Profissional/UFMT\ -\ Orientacoes'
    alias cli='cd ~/OneDrive/CLI'
    alias dot='cd ~/OneDrive/CLI/dotfiles'
    alias qualis='cd ~/OneDrive/Profissional/PubPar/Qualis'
fi

# ssh
# ufmt
alias rpi='ssh -p 19239 bibr@200.17.60.42'
alias rpi_local='ssh -p 19239 bibr@192.168.191.239'
alias fusca='ssh -p 19127 roney@200.17.60.42'
alias fusca_local='ssh -p 19127 roney@192.168.191.127'
alias guarani='ssh -p 19250 roney@200.17.60.42'
alias guarani_local='ssh -p 19250 roney@192.168.191.250'
alias lisa='ssh -p 13000 roney@179.217.119.6'
alias lisa_local='ssh -p 13000 roney@192.168.0.130'
# alias frank='ssh -p 19127 roney@200.17.60.42'
# alias frank_local='ssh -p 19127 roney@192.168.191.127'
# nuvem
alias ubuntu_nyc='ssh bibr@159.89.36.185'
alias caipora='ssh -D 5555 caipora@159.89.36.185'

# git
alias g='git '
alias gi='git init '
alias gs='git status -sb '
alias ga='git add '
alias gac='git add -A && git commit' 
alias gacn="git add -A && git commit -am 'save' " 
alias gc='git commit '
alias gcm='git commit -m '
alias gp='git push '
alias gpo='git push origin '
alias gpom='git push origin main'
alias gr='git rm -r '
alias grc='git rm --cached'
alias gk='git checkout'
alias gb='git branch '
alias gba='git branch -a'
alias gbd='git branch -d'
alias gd='git diff '
alias gds='git diff --stage '

# functions
# scpSuper file class
# scpSuper file class/IntroMicro

rsyncVolume(){
    rsync -r -a -v --info=progress2 -e ssh "$1" bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/volume/"$2"
}

# translate-shell
# tenpt -argumento 'texto para traduzir'
# argumento é opcional
tenpt(){
    trans en:pt $1 $2  
}

tpten(){
    trans pt:en $1 $2
}

# play audio of youtube videos
ytp(){
    mpv $1 --no-video --shuffle
}

# nnn pmount better option
# un/mount by external's drive name
pen(){
    udevil $1 /dev/disk/by-label/$2
}

# exfat mount/unmount
penexfat(){
    sudo $1 -t exfat /dev/disk/by-label/$2 /media/$2
}

# pandoc to html
panhtml(){
    pandoc --filter pandoc-crossref --filter pandoc-citeproc $1.md -o $1.html -r markdown+simple_tables+table_captions+yaml_metadata_block+smart+hard_line_breaks -w html --template=http://www.roneyfraga.com/pandoc/templates/html.template --css=http://www.roneyfraga.com/pandoc/marked/kultiad-serif.css --csl=http://www.roneyfraga.com/pandoc/csl/abnt-ipea.csl --bibliography=/home/roney/OneDrive/CLI/bibliography.bib --resource-path=$2
}

# lastpass
lpass_find(){
    lpass ls | grep -i $1
}

lpass_copy(){
    lpass show -c --password $1
}

lpass_login(){
    lpass login --trust --plaintext-key --force --color=auto $1
}

# any format to pdf
topdf(){
    unoconv -f pdf $1
}

# r_external_term: 0 no, 1 yes, or terminal name
# r_external_term(){
#     sed -i "s/^let R_external_term.*/let R_external_term = ${1}/" $HOME/OneDrive/CLI/dotfiles/nvim/init.vim 
# }

# intalled packages
pacmanIP(){
    pacman -Q | awk '{print $1}' > $HOME/OneDrive/CLI/dotfiles/pacman_packages_installed.txt
}

# find file and open it in nvim, from current directory
ff.() {
    nvim "$(fd -t f -I --hidden --follow --exclude '.git' | fzf)"
}
 
# find file and open it in nvim, from ~/
ffh() {
    cd $HOME && nvim "$(fd -t f -I --hidden --follow --exclude '.git' | fzf )"
}

# fzf open file (with fd)
# fop() {
#     fd -t f -I --hidden --follow --exclude ".git" | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
# }

# fzf folder (directory), from current directory
fd.() {
    cd . && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

# fzf folder (directory), from ~/
fdh() {
    cd $HOME && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

# fzf pacman
fpc() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden)
}

# fzf yay
fyy() {
    yay -Syy $(yay -Ssq | fzf -m --preview-window=:hidden --preview="yay -Si {}")
}

# fzf bibliography, fb $BIB or fb references.bib 
fbi(){
    bibtex-ls $1 | fzf --multi --ansi --preview-window=:hidden | bibtex-cite -separator=', @'
}

# fzf reference, fr $BIB or fr references.bib
fre(){
    bibtex-ls $1 | fzf --multi --ansi --preview-window=:hidden
}

# references pdf bibtex
getref2(){
    papers extract $1
}

addref(){
    $* >> $HOME/OneDrive/CLI/bibliography.bib
}

# nnn
# cd and quit 
# control+g
n(){
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh