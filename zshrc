#rg --files --hidden --follow --no-ignore-vcs If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# OS Detection
case "$OSTYPE" in
  darwin*)
    export OS="macos"
    export ZSH="/Users/roney/.oh-my-zsh"
    ;;
  linux*)
    export OS="linux"
    export ZSH="/home/roney/.oh-my-zsh"
    ;;
  *)
    export OS="unknown"
    ;;
esac

# Machine Detection (simple and reliable)
detect_machine_type() {
  local hostname=$(hostname)

  # macOS detection
  if [[ "$OS" == "macos" ]]; then
    echo "laptop"
    return
  fi

  # Linux hostname detection
  case "$hostname" in
    rambo|lisa)
      echo "production"
      ;;
    fusca)
      echo "data-server"
      ;;
    x390)
      echo "laptop"
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

detect_setup_type() {
  local machine=$(detect_machine_type)

  case "$machine" in
    laptop) echo "laptop" ;;
    production|data-server) echo "desktop" ;;
    *) echo "unknown" ;;
  esac
}

# Helper function to identify current machine
show_machine() {
  echo "OS: $OS"
  echo "Machine: $MACHINE_TYPE"
  echo "Setup: $SETUP_TYPE"
}

export MACHINE_TYPE=$(detect_machine_type)
export SETUP_TYPE=$(detect_setup_type)

# Add Homebrew GCC to PATH for priority over system clang (macOS only)
[[ "$OS" == "macos" ]] && export PATH="/opt/homebrew/bin:$PATH"

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH
# export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

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

# Common plugins for all machines
plugins=(git z fzf)

source $ZSH/oh-my-zsh.sh

# Source zsh-autosuggestions for all machines
# Manual install, see: 
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
# export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

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
# case "$MACHINE_TYPE" in
#   "production")  # rambo or lisa
#     export OLLAMA_MODELS="/mnt/raid0/ollama/models"
#     ;;
# esac

# CREDENTIALS
if [ -f ~/.credentials/elsevier.sh ]; then
  source ~/.credentials/elsevier.sh
fi

if [ -f ~/.credentials/language_tool.sh ]; then
  source ~/.credentials/language_tool.sh
fi

if [ -f ~/.credentials/openai.sh ]; then
  source ~/.credentials/openai.sh
fi

if [ -f ~/.credentials/z_ai.sh ]; then
  source ~/.credentials/z_ai.sh
fi

# zsh-autosuggestions
bindkey '^]' autosuggest-accept
bindkey '^p' autosuggest-toggle

# GCC alias to use Homebrew GCC by default (macOS only)
[[ "$OS" == "macos" ]] && {
  alias gcc='gcc-14'
  alias g++='g++-14'
}

# softwares
alias fm='vifm .'
alias v='nvim'
alias vw='cd ~/Wiki; nvim index.md'
alias oc='opencode'
alias rrsync='rsync -lhr --info=progress2'
alias x='clear'
alias l='ls -l'
alias yt='youtube-dl'
alias aq='asciiquarium'
alias zt='zathura'
alias py='python'
alias def='goldendict'
alias syn='Rscript ~/dotfiles/bin/dicsyn.R'
alias bib='Rscript ~/dotfiles/bin/getbib.R'
alias refman='Rscript ~/dotfiles/bin/reference_manager.R'
alias librarian='Rscript ~/Biblioteca/rag-graph/librarian.R'
alias yta=''
alias yts=''
alias ytw=''
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

# files
alias init.lua="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"
alias tmux.conf='nvim ~/.tmux.conf'
alias i3c='nvim ~/.config/i3/config'
alias vifmrc='nvim ~/.config/vifm/vifmrc'

# Common aliases (all machines)
alias dk='cd ~/Desktop'
alias dw='cd ~/Downloads'
alias B='cd ~/Biblioteca'
alias cfg='cd ~/.config'
alias dot='cd ~/dotfiles'
alias sy='cd ~/Sync'
alias wk='cd ~/Wiki'
alias zet='cd ~/Wiki/Zet'

# Machine-specific configurations
case "$MACHINE_TYPE" in
  laptop)
    # Laptops (local storage)
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
    ;;
  production)
    # Production desktops (rambo or lisa - raid setup)
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
    ;;
  data-server)
    # Data server (external storage)
    alias sy='cd /mnt/hd4tb/roney/Sync'
    alias wk='cd /mnt/hd4tb/roney/Wiki'
    alias zt='ce /mnt/hd4tb/roney/Wiki/Zet'
    alias pes='cd /mnt/hd4tb/roney/Pessoal'
    alias doc='cd /mnt/hd4tb/roney/Pessoal/Documents/'
    alias rw='cd '/mnt/hd4tb/roney/Pessoal/Documents/Rworkspace'
    alias rwd='cd /mnt/hd4tb/roney/Pessoal/Documents/RworkspaceData'
    alias pubpar='cd '/mnt/hd4tb/roney/Pessoal/Documents/Profissional/PubPar'
    alias prof='cd '/mnt/hd4tb/roney/Pessoal/Documents/Profissional'
    alias ori='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional/aUFMT_Orientacoes'
    alias cti='cd /mnt/hd4tb/roney/Pessoal/Documents/Profissional/Ciencia-Tecnologia-Inovacao'
    alias cli='cd /mnt/hd4tb/roney/Pessoal/Documents/CLI'
    alias qualis='cd '/mnt/hd4tb/roney/Pessoal/Documents/Profissional/PubPar/Qualis'

    # wake on lan
    alias rambo_ligar='wol c8:7f:54:67:67:d5'
    alias rambo_local='ssh -p 19250 roney@192.168.191.250'
    ;;
esac

# Machine-specific configurations handled above in main case statement

# ssh tailscale (macOS only)
[[ "$OS" == "macos" ]] && alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
#
alias rambo='ssh -p 19250 roney@100.77.82.122'
alias lisa='ssh -p 13000 roney@100.77.23.115'
alias fusca='ssh -p 19131 roney@100.83.148.110'
alias ubuntu_nyc='ssh bibr@100.104.99.20' # 159.89.36.185
alias caipora='ssh -D 5555 caipora@100.104.99.20'

# small functions
rsync_volume() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "rsync_volume - Sync local files to web server volume directory"
        echo ""
        echo "Usage: rsync_volume <local_path>"
        echo ""
        echo "Arguments:"
        echo "  local_path    Local file or directory to sync"
        echo ""
        echo "Features:"
        echo "  - Recursive sync (-r)"
        echo "  - Preserves permissions and timestamps (-a)"
        echo "  - Shows progress information (--info=progress2)"
        echo "  - Uses SSH for secure transfer (-e ssh)"
        echo "  - Syncs to: bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/volume/"
        echo ""
        echo "Examples:"
        echo "  rsync_volume file.txt"
        echo "  rsync_volume /path/to/files"
        echo "  rsync_volume folder-to-send"
        echo ""
        echo "Note: Files are placed directly in the volume directory (no subfolders)"
        return 0
    fi
    
    rsync -r -a -v --info=progress2 -e ssh "$1" bibr@159.89.36.185:/var/www/roneyfraga.com/public_html/volume/
}

# Play YouTube video in mpv
yt_play() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "yt_play - Play YouTube video in mpv"
    echo ""
    echo "Usage: yt_play <youtube_url>"
    echo ""
    echo "Examples:"
    echo "  yt_play 'https://youtube.com/watch?v=VIDEO_ID'"
    echo ""
    return 0
  fi

  if [[ -z "$1" ]]; then
    echo "Error: YouTube URL required"
    echo "Use 'yt_play --help' for usage information"
    return 1
  fi
  mpv "$1"
}

# Download audio as MP3
yt_audio() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "yt_audio - Download audio from YouTube"
    echo ""
    echo "Usage: yt_audio <youtube_url> [output_format]"
    echo ""
    echo "Arguments:"
    echo "  youtube_url    YouTube video URL"
    echo "  output_format Audio format (default: mp3)"
    echo ""
    echo "Examples:"
    echo "  yt_audio 'https://youtube.com/watch?v=VIDEO_ID'"
    echo "  yt_audio 'https://youtube.com/watch?v=VIDEO_ID' wav"
    echo ""
    echo "Supported formats: mp3, wav, flac, m4a, opus, etc."
    return 0
  fi

  if [[ -z "$1" ]]; then
    echo "Error: YouTube URL required"
    echo "Use 'yt_audio --help' for usage information"
    return 1
  fi
  local format="${2:-mp3}"
  yt-dlp -x --audio-format "$format" "$1"
}

# Download best quality video
yt_video() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "yt_video - Download video from YouTube with specified quality"
        echo ""
        echo "Usage: yt_video <youtube_url> [quality]"
        echo ""
        echo "Arguments:"
        echo "  youtube_url    YouTube video URL"
        echo "  quality        Video quality (default: 1440)"
        echo ""
        echo "Quality options:"
        echo "  2160   - 4K Ultra HD"
        echo "  1440   - 2K/QHD (default)"
        echo "  1080   - Full HD"
        echo "  720    - HD"
        echo "  480    - SD"
        echo "  360    - Low quality"
        echo ""
        echo "Features:"
        echo "  - Downloads best quality up to specified resolution"
        echo "  - Optimized for file size vs quality"
        echo ""
        echo "Examples:"
        echo "  yt_video 'https://youtube.com/watch?v=VIDEO_ID'"
        echo "  yt_video 'https://youtube.com/watch?v=VIDEO_ID' 1080"
        echo "  yt_video 'https://youtube.com/watch?v=VIDEO_ID' 720"
        echo ""
        return 0
    fi
    
    if [[ -z "$1" ]]; then
        echo "Error: YouTube URL required"
        echo "Use 'yt_video --help' for usage information"
        return 1
    fi
    local quality="${2:-1440}"
    yt-dlp -f "best[height<=${quality}]" "$1"
}

# Download subtitles only
yt_subs() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "yt_subs - Download manual subtitles from YouTube"
    echo ""
    echo "Usage: yt_subs <youtube_url> [language_code]"
    echo ""
    echo "Arguments:"
    echo "  youtube_url     YouTube video URL"
    echo "  language_code   Language code (default: en)"
    echo ""
    echo "Language codes:"
    echo "  en  - English    pt  - Portuguese"
    echo "  es  - Spanish    fr  - French"
    echo "  de  - German    it  - Italian"
    echo "  ja  - Japanese   ru  - Russian"
    echo "  zh  - Chinese    ko  - Korean"
    echo ""
    echo "Features:"
    echo "  - Downloads manual subtitles"
    echo "  - Falls back to all available languages"
    echo "  - Converts to SRT format"
    echo ""
    echo "Examples:"
    echo "  yt_subs 'https://youtube.com/watch?v=VIDEO_ID'"
    echo "  yt_subs 'https://youtube.com/watch?v=VIDEO_ID' pt"
    echo ""
    return 0
  fi

  if [[ -z "$1" ]]; then
    echo "Error: YouTube URL required"
    echo "Use 'yt_subs --help' for usage information"
    return 1
  fi
  local lang="${2:-en}"
  yt-dlp --write-subs --sub-langs "$lang,all" --convert-subs srt --skip-download "$1"
}

# Download auto-generated subtitles
yt_subs_auto() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "yt_subs_auto - Download auto-generated subtitles from YouTube"
    echo ""
    echo "Usage: yt_subs_auto <youtube_url> [language_code]"
    echo ""
    echo "Arguments:"
    echo "  youtube_url     YouTube video URL"
    echo "  language_code   Language code (default: en)"
    echo ""
    echo "Features:"
    echo "  - Downloads auto-generated subtitles"
    echo "  - Falls back to all available languages"
    echo "  - Converts to SRT format"
    echo "  - Works even when manual subtitles unavailable"
    echo ""
    echo "Examples:"
    echo "  yt_subs_auto 'https://youtube.com/watch?v=VIDEO_ID'"
    echo "  yt_subs_auto 'https://youtube.com/watch?v=VIDEO_ID' pt"
    echo ""
    return 0
  fi

  if [[ -z "$1" ]]; then
    echo "Error: YouTube URL required"
    echo "Use 'yt_subs_auto --help' for usage information"
    return 1
  fi
  local lang="${2:-en}"
  yt-dlp --write-auto-subs --sub-langs "$lang,all" --convert-subs srt --skip-download "$1"
}

# Download video with subtitles
yt_video_with_subs() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "yt_video_with_subs - Download video with subtitles from YouTube"
        echo ""
        echo "Usage: yt_video_with_subs <youtube_url> [language_code] [quality]"
        echo ""
        echo "Arguments:"
        echo "  youtube_url     YouTube video URL"
        echo "  language_code   Language code (default: en)"
        echo "  quality        Video quality (default: 1440)"
        echo ""
        echo "Quality options:"
        echo "  2160   - 4K Ultra HD"
        echo "  1440   - 2K/QHD (default)"
        echo "  1080   - Full HD"
        echo "  720    - HD"
        echo "  480    - SD"
        echo "  360    - Low quality"
        echo ""
        echo "Features:"
        echo "  - Downloads video with specified quality"
        echo "  - Downloads subtitles in SRT format"
        echo "  - Falls back to all available languages"
        echo ""
        echo "Examples:"
        echo "  yt_video_with_subs 'https://youtube.com/watch?v=VIDEO_ID'"
        echo "  yt_video_with_subs 'https://youtube.com/watch?v=VIDEO_ID' pt"
        echo "  yt_video_with_subs 'https://youtube.com/watch?v=VIDEO_ID' pt 1080"
        echo "  yt_video_with_subs 'https://youtube.com/watch?v=VIDEO_ID' '' 720"
        echo ""
        return 0
    fi
    
    if [[ -z "$1" ]]; then
        echo "Error: YouTube URL required"
        echo "Use 'yt_video_with_subs --help' for usage information"
        return 1
    fi
    local lang="${2:-en}"
    local quality="${3:-1440}"
    yt-dlp -f "best[height<=${quality}]" --write-subs --sub-langs "$lang,all" --convert-subs srt "$1"
}

# any format to pdf
topdf(){
  unoconv -f pdf $1
}

# fzf folder (directory), from current directory
fd.() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "fd. - Fuzzy find and change to directory"
        echo ""
        echo "Usage: fd."
        echo ""
        echo "Fuzzy find directories from current location and cd to selected one"
        return 0
    fi
    
    cd . && cd "$(fd -t d --hidden --follow --exclude ".git" | fzf --preview="tree -L 1 {}" )"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/npm/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
# TinyTeX path (macOS only)
[[ "$OS" == "macos" ]] && export PATH="$HOME/Library/TinyTeX/bin/universal-darwin:$PATH"
