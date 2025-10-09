#rg --files --hidden --follow --no-ignore-vcs If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export nome_do_computador=$(hostname)
# conferir nome_do_computador com:
# print $nome_do_computador 

if [ $nome_do_computador = 'mbp-m1.local' ]; 
then
  export ZSH="/Users/roney/.oh-my-zsh"
else 
  export ZSH="/home/roney/.oh-my-zsh"
fi

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

# npm permissions for user
# mkdir ~/.npm-global
# npm config set prefix '~/.npm-global'
export PATH=$HOME/.npm-global/bin:$PATH
# now do: npm install -g <package>

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

if [ $nome_do_computador = 'mbp-m1.local' ]; 
then
  plugins=(git z fzf)
else 
  plugins=(git z fzf zsh-autosuggestions)
fi

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

# OLLAMA
# case "$nome_do_computador" in
#   "lisa"|"rambo")
#     export OLLAMA_MODELS="/mnt/raid0/ollama/models"
#     ;;
# esac

# CREDENTIALS
source ~/.credentials/elsevier.sh

# zsh-autosuggestions
bindkey '^]' autosuggest-accept
bindkey '^p' autosuggest-toggle

# softwares
alias fm='vifm .'
alias v='nvim'
alias vw='cd ~/Wiki; nvim index.md'
alias rrsync='rsync -lhr --info=progress2'
alias x='clear'
alias l='ls -l'
alias yt='youtube-dl'
alias ref='source ~/.zshrc'
alias aq='asciiquarium'
alias zt='zathura'
alias py='python'
alias def='goldendict'
alias syn='Rscript ~/dotfiles/bin/dicsyn.R'
alias bib='Rscript ~/dotfiles/bin/getbib.R'
alias reference='Rscript ~/dotfiles/bin/reference.R'
alias youtube-dl-audio='youtube-dl --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'
alias timer='termdown'
alias info2='neofetch'
alias lg='lazygit'
alias nb='newsboat'
alias tm='tmux'
alias tmn='tmux new -s'
alias tmr='tmux new -s `basename $PWD`'
alias tml='tmux ls'
alias tma='tmux attach-session -t'
alias tmk='tmux kill-session -t'

# quarto
alias qr='quarto render'
alias qp='quarto preview'

# files
alias init.lua="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"
alias tmux.conf='nvim ~/.tmux.conf'
alias i3c='nvim ~/.config/i3/config'
alias vifmrc='nvim ~/.config/vifm/vifmrc'

# lisa and rambo use the same paths
alias dk='cd ~/Desktop'
alias dw='cd ~/Downloads'
alias B='cd ~/Biblioteca'
alias cfg='cd ~/.config'
alias dot='cd ~/dotfiles'
alias sy='cd ~/Sync'
alias wk='cd ~/Wiki'
alias zet='cd ~/Wiki/Zet'
alias r0='cd /mnt/raid0'
alias pes='cd /mnt/raid0/Pessoal'
alias doc='cd /mnt/raid0/Pessoal/Documents/'
alias rw='cd /mnt/raid0/Pessoal/Documents/Rworkspace'
alias rwd='cd /mnt/raid0/Pessoal/Documents/RworkspaceData'
alias pubpar='cd /mnt/raid0/Pessoal/Documents/Profissional/PubPar'
alias prof='cd /mnt/raid0/Pessoal/Documents/Profissional'
alias ori='cd /mnt/raid0/Pessoal/Documents/Profissional/UFMT_Orientacoes'
alias cli='cd /mnt/raid0/Pessoal/Documents/CLI'
alias cti='cd /mnt/raid0/Pessoal/Documents/Profissional/Ciencia-Tecnologia-Inovacao'
alias qualis='cd /mnt/raid0/Pessoal/Documents/Profissional/PubPar/Qualis'

if [ $nome_do_computador = 'mbp-m1.local' ]; 
then
  alias pes='cd ~/Pessoal'
  alias doc='cd ~/Pessoal/Documents/'
  # alias rw='cd ~/Pessoal/Documents/Rworkspace'
  alias pubpar='cd ~/Pessoal/Documents/Profissional/PubPar'
  alias prof='cd ~/Pessoal/Documents/Profissional'
  alias ori='cd ~/Pessoal/Documents/Profissional/aUFMT_Orientacoes'
  alias cti='cd ~/Pessoal/Documents/Profissional/Ciencia-Tecnologia-Inovacao'
  alias cli='cd ~/Pessoal/Documents/CLI'
  alias qualis='cd ~/Pessoal/Documents/Profissional/PubPar/Qualis'
fi

if [ $nome_do_computador = 'x390' ]; 
then
  alias pes='cd ~/Pessoal'
  alias doc='cd ~/Pessoal/Documents/'
  alias rw='cd ~/Pessoal/Documents/Rworkspace'
  alias rwd='cd ~/Pessoal/Documents/RworkspaceData'
  alias pubpar='cd ~/Pessoal/Documents/Profissional/PubPar'
  alias prof='cd ~/Pessoal/Documents/Profissional'
  alias ori='cd ~/Pessoal/Documents/Profissional/aUFMT_Orientacoes'
  alias cti='cd ~/Pessoal/Documents/Profissional/Ciencia-Tecnologia-Inovacao'
  alias cli='cd ~/Pessoal/Documents/CLI'
  alias qualis='cd ~/Pessoal/Documents/Profissional/PubPar/Qualis'
fi

if [ $nome_do_computador = 'fusca' ]; 
then
  alias sy='cd /mnt/hd4tb/roney/Sync'
  alias wk='cd /mnt/hd4tb/roney/Wiki'
  alias zt='ce /mnt/hd4tb/roney/Wiki/Zet'
  alias pes='cd /mnt/hd4tb/roney/Pessoal'
  alias doc='cd /mnt/hd4tb/roney/Pessoal/Documents/'
  alias rw='cd /mnt/hd4tb/roney/Pessoal/Documents/Rworkspace'
  alias rwd='cd /mnt/hd4tb/roney/Pessoal/Documents/RworkspaceData'
  alias pubpar='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional/PubPar'
  alias prof='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional'
  alias ori='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional/aUFMT_Orientacoes'
  alias cti='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional/Ciencia-Tecnologia-Inovacao'
  alias cli='cd /mnt/hd4tb/roney/Pessoal/Documents/CLI'
  alias qualis='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional/PubPar/Qualis'

  # wake on lan
  alias rambo_ligar='wol c8:7f:54:67:67:d5'
  alias rambo_local='ssh -p 19250 roney@192.168.191.250'

fi

# ssh tailscale
if [ $nome_do_computador = 'mbp-m1.local' ]; 
then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi
#
alias rambo='ssh -p 19250 roney@100.77.82.122'
alias lisa='ssh -p 13000 roney@100.77.23.115'
alias fusca='ssh -p 19131 roney@100.83.148.110'
alias ubuntu_nyc='ssh bibr@100.104.99.20' # 159.89.36.185
alias caipora='ssh -D 5555 caipora@100.104.99.20'

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

# small functions
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

# any format to pdf
topdf(){
  unoconv -f pdf $1
}

# fzf folder (directory), from current directory
fd.() {
cd . && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

# fzf folder (directory), from ~/
fdh() {
  cd $HOME && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/npm/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
