export ZSH="/data/data/com.termux/files/home/.oh-my-zsh"
ZSH_THEME="simple"
#DISABLE_LS_COLORS="true"
#ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
#ZSH_CUSTOM=/path/to/new-custom-folder
#DISABLE_MAGIC_FUNCTIONS=true
#-----alias-----alias-----alias-----alias-----alias-----alias-----alias-----
alias mka='nano -c +50 $HOME/.zshrc'
alias n='nano -c'
alias b='bash'
alias p='python'
alias p2='python2'
alias l='ls -a'
alias m='mkdir -p'
alias rmd='rm -rf'
alias up='apt update'
alias upd='apt upgrade'
alias arm='apt autoremove'
alias rem='apt remove'
alias .list='nano -c /data/data/com.termux/files/usr/etc/apt/sources.list'
alias cds='cd $HOME/scripts'
alias cdp='cd $HOME/projects'
alias cdss='cd $HOME/.shortcuts'
alias wi='termux-wifi-connectioninfo'
alias wifi='termux-wifi-scaninfo'
alias msf='msfconsole'
alias ai='apt install'
alias sd='cd $HOME/storage/dcim'
alias x='exit'
alias cl='clear'
alias cdc="cd $HOME/current"
alias ubu="./start-androkde.sh"
alias ais='sudo apt install --install-suggests'
alias r="rm -i"
alias ip="ip addr show dev wlan0 | sed -e's/^.*inet \([^ ]*\)\/.*$/\1/;t;d' | tee -a ip.txt"
alias nn="bash $HOME/scripts/shebanged-nano.sh"
alias sshc="rm $HOME/.ssh/known_hosts"
alias wipe="rm -rf $HOME/.ssh && mkdir $HOME/.ssh"
alias ..="cd .."
alias sshp="ssh pi@172.24.0.1"
alias c="bash $HOME/scripts/connect-to"
alias start="bash $HOME/scripts/full-menu.sh"
alias conn="bash $HOME/scripts/conn.sh"


DL=/data/data/com.termux/files/home/storage/shared/download
YT=/data/data/com.termux/files/home/storage/shared/youtube
SC=/data/data/com.termux/files/home/scripts
PR=/data/data/com.termux/files/home/projects
CU=/data/data/com.termux/files/home/current
DC=/data/data/com.termux/files/home/storage/shared/dcim
CDC=/data/data/com.termux/files/home/current
DOC=/data/data/com.termux/files/home/storage/shared/Documents
PL=/data/data/com.termux/files/home/payloads

function cd {
    builtin cd "$@" && ls
    }

#alias cdls='cd "$@" && ls'


bash $HOME/scripts/full-menu.sh
ls
