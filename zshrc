# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/roney/.oh-my-zsh"

export PATH=$HOME/bin:$HOME/go/bin:/usr/local/bin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

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
export READER='zathura'
export TERMINAL='terminator'
export TRUEBROWSER='qutebrowser'
export BIB=$HOME/OneDrive/CLI/bibliography.bib
export RES=$HOME/OneDrive/CLI/RES.md

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="\
    --preview 'head -100 {}'\
    --preview-window=right:50%:wrap\
    --multi --no-height\
    --bind=ctrl-b:backward-kill-word\
    --bind=ctrl-d:kill-word\
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
    "

# CREDENTIALS
source $HOME/OneDrive/CLI/dotfiles/credentials/elsevier.sh

# zsh-autosuggestions
bindkey '^]' autosuggest-accept
bindkey '^p' autosuggest-toggle

# softwares
alias t='env TERM=screen-256color tmux'
alias v='nvim'
alias rrsync='rsync -lhr --info=progress2'
alias music='mocp'
alias j='joplin'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias x='clear'
alias l='ls -lNh --color=auto --group-directories-first'
alias yt='youtube-dl'
alias ref='source ~/.zshrc'
alias aq='asciiquarium'
alias h='htop'
alias zt='zathura'
alias sys='sudo systemctl'
alias db='~/bin/dropbox.py'
alias drop='~/.dropbox-dist/dropboxd &'
alias penlabel='ls /dev/disk/by-label/'
alias py='python'
alias def='goldendict'
alias mutt='cd ~/Downloads && neomutt'
alias onedrive_log='journalctl --user-unit onedrive -f'
alias dicsyn='~/bin/dicsyn.R'
alias youtube-dl-audio='youtube-dl --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'
alias timer='termdown'

# radio
alias r1='mplayer http://listen.shoutcast.com/gaiafm'
alias r2='mplayer http://listen.radionomy.com:80/RADIOGAIAhits'
alias r3='mplayer http://108.163.223.242:8344/stream'
alias r4='mplayer http://185.33.21.112:80/radiogaia_128'
alias r5='mplayer http://158.69.27.227:8000'

# files
alias vimrc="nvim ~/.vimrc"
alias zshrc="nvim ~/.zshrc"
alias tmux.conf='nvim ~/.tmux.conf'
alias i3c='nvim ~/.config/i3/config'
alias zathurarc='nvim ~/.config/zathura/zathurarc'
alias rc.conf='nvim ~/.config/ranger/rc.conf'
alias artigos='nvim ~/OneDrive/CLI/artigos.md'

# places 
alias rw='cd ~/OneDrive/Rworkspace'
alias unix='cd ~/OneDrive/Profissional/Unix'
alias pubpar='cd ~/OneDrive/Profissional/PubPar'
alias prof='cd ~/OneDrive/Profissional'
alias cli='cd ~/OneDrive/CLI'
alias dot='cd ~/OneDrive/CLI/dotfiles'
alias qualis='cd ~/OneDrive/Profissional/PubPar/Qualis'
alias dw='cd ~/Downloads'

# ssh
alias rpi='ssh -p 12246 bibr@192.168.191.250'
alias rpi_pub='ssh -p 12246 bibr@200.17.60.42'
alias rpi_bibr='ssh -p 12246 bibr@192.168.191.250'
alias fusca='ssh bibr@192.168.191.32'
alias ubuntu_nyc='ssh bibr@159.89.36.185'
alias caipora='ssh -D 5555 caipora@159.89.36.185'
alias nas='ssh roney@192.168.191.29'
alias guarani='ssh roney@179.217.124.233'

# git
alias g='git '
alias gi='git init '
alias gs='git status -sb '
alias ga='git add '
alias gc='git commit '
alias gcm='git commit -m '
alias gp='git push '
alias gpo='git push origin '
alias gpom='git push origin master'
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
scpSuper(){
    scp -r "$1" bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/"$2"
}

# remenber to use / in the end of folder
rsyncSuper(){
    rsync -r -a -v --info=progress2 -e ssh "$1" bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/"$2"
}

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

# references pdf bibtex
getref2(){
    papers extract $1
}

addref(){
    $* >> $HOME/OneDrive/CLI/bibliography.bib
}

# find and open in nvim, from current directory
fv.() {
    nvim "$(fd -t f -I --hidden --follow --exclude '.git' | fzf)"
}

# find and open in nvim, from ~/
fvh() {
    cd $HOME && nvim "$(fd -t f -I --hidden --follow --exclude '.git' | fzf )"
}

# fzf folder (directory), from current directory
fd.() {
    cd . && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

# fzf folder (directory), from ~/
fdh() {
    cd $HOME && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

# fzf open file (with fd)
fop() {
    fd -t f -I --hidden --follow --exclude ".git" | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
