# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.




plugins=(
    git
    docker
    docker-compose
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    sudo
    # line-drawer
    )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function cde() {
    echo "openning Desktop/projects/$1 with vsCode"
    if [ "$1" != "" ]
    then
  /bin/code ~/Desktop/projects/"$1"
    else
        /bin/code ~/Desktop/projects/
    fi
}
function dod() {
  echo "$1"
  if [ "$1" != "" ]
  then
  pwd1 = "$PWD"
  echo "$pwd1"
  echo "$1"
  ls
  cd "~/$1"
        docker compose down
        cd "$pwd1"  
  else
        docker compose down
  fi
}
alias dop="docker compose up -d"
alias gits="git status"
alias gill="git pull"
alias gish="git push"
alias gisp="git stash pop"
alias ns="npm run start:dev || npm run start || npm start || nodemon server.js || nodemon app.js || node server.js || node app.js"
function gimmit() {
    git add .
    if [ "$1" != "" ]
    then
        git commit -m "$1"
    else
        git commit -m WIP
    fi
}
function giut() {
    if [ "$1" != "" ]
    then
        git checkout "$1"
    else
        git checkout master
    fi
}
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias fuckoff="shutdown -h now"
alias idiot="shutdown -r now"
alias pp="terminal-parrot"
alias clr="clear"
alias dfoff="docker rm \$(docker stop \$(docker container ls -qa))"
# alias nekoray="nohup /home/lou2013/Downloads/nekoray > /dev/null 2>&1 &"
# alias nekoray="/home/lou2013/Downloads/nekoray/launcher"
alias gsi='git submodule foreach "pnpm i"'
alias gsu="git submodule update --init --recursive"
alias gsp="git submodule foreach \"git pull\""
alias gitkey="echo $GITKEY"
alias getcls="xprop | grep WM_CLASS | awk '{ print $4 }'"
alias shecane='nmcli device mod eno1 ipv4.dns "178.22.122.100 185.51.200.2"'
alias shecand='nmcli device mod eno1 ipv4.dns "127.0.0.1 1.1.1.1 8.8.8.8"'
alias gor='air run'
# pnpm
export PNPM_HOME="/home/lou2013/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH=$PATH:~/.dotnet/tools
export PATH=$PATH:~/go/bin
# pnpm end# Created by fodev.org

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '


setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
# anime-colorscripts -r source /home/lou2013/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
export BROWSER='/usr/bin/google-chrome-stable'
# Created by fodev.org
function fod(){
    case $1 in
        "--enable" | "-e")
            export http_proxy="http://fodev.org:8118/"
            export https_proxy="http://fodev.org:8118/"
            export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
            export HTTP_PROXY="http://fodev.org:8118/"
            export HTTPS_PROXY="http://fodev.org:8118/"
            export NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com"
            echo "enable fod proxy !"
        ;;
        "--disable" | "-d")
            unset http_proxy
            unset https_proxy
            unset no_proxy
            unset HTTP_PROXY
            unset HTTPS_PROXY
            unset NO_PROXY
            echo "disable fod proxy !"
        ;;
        "--status" | "-s")
            if [[ $http_proxy == 'http://fodev.org:8118/' ]]
            then
                echo 'fod proxy is ENABLED !'
            else
                echo 'fod proxy is DISABLED !'
            fi
        ;;
        *)
            echo "Usage : fod [-e | --enable] [-d | --disable] [-s | --status]"
            echo "Example : "
            echo "  fod --enable to enable fod proxy "
            echo "  fod --disable to disable fod proxy "
            echo "  fod --status to check fod proxy status "
        ;;
    esac
}

# install nvm
# source /usr/share/nvm/init-nvm.sh
source <(fzf --zsh)