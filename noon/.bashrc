#
# ~/.bashrc
#

# If not running interactively, don't do anything
set -o vi
stty -ixon

[[ $- != *i* ]] && return

export PATH=$PATH:/home/anon/scripts # user scripts
export PATH="$PATH:`yarn global bin`" # javacript
export PATH="$PATH:/home/anon/.local/bin" # python
export PATH="$PATH:/home/anon/repos/compiletools" # ct-cake
export BUNDLER_EDITOR="code"

export ANDROID_HOME=/home/anon/Android/Sdk
export ANDROID_SDK_ROOT=/home/anon/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# GRC is a generic colouriser, configure it at ~/.grc
GRC_ALIASES=true
[[ -s "/etc/profile.d/grc.sh" ]] && source /etc/profile.d/grc.sh

alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
export LESS='-R --use-color -Dd+r$Du+b$'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

GIT_BRANCH="\[\033[31m\]\$(parse_git_branch)\[\033[00m\] "


# PS1="[\u@\h \W]\$$GIT_BRANCH" # 
PS1="[anon@\h \W]\$$GIT_BRANCH"

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#STARTALIAS

# LINUX
alias updatemirrors="sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"

# META
alias list="cat ~/.bashrc | awk '/#STARTALIAS$/,/#ENDALIAS$/'"
alias reload="source ~/.bashrc"
alias edb="vim ~/.bashrc"
alias host="cat ~/.ssh/config | grep -E 'Host\s'"

# PROGRAMS
alias nm="nm-applet"
alias r=". ranger"

# PROGRAMMING
alias craN='yarn create react-app --template typescript' # cra new
alias cra='cp -r ~/templates/cra' # upgrade deps before using
# alias exp='git clone https://github.com/greenroach/express-ts-template.git'
# alias exp='npx typescript-express-starter' # "project name"
alias exp='npx express-generator --no-view --git'
alias emu='nohup emulator @pixel6 -feature -Vulkan & disown'
alias h='hygen'
alias t='npx ts-node'

# DOCKER
alias docker_stop='docker stop $(docker ps -a -q)'
alias docker_remove='docker rm $(docker ps -a -q)'
# alias mac="docker start -ai 9d9a234e60e1" # start the hackintosh

# SCRIPTS
alias pape="sh ~/scripts/set_wallpaper"
alias upape="while [ true ]; do pape; sleep 2; done"

# HEROKU
alias logs="heroku logs --tail -a"
alias logw="heroku logs --tail -d web -a"
alias logr="heroku logs --tail -d router -a"

# WITH OPTIONS
alias 4scrape="~/repos/4chan-image-scraper/scraper.py --path=~/wallpapers/$(date '+%Y-%m-%dn')"

# XRANDR
# alias set="sh ~/.screenlayout/top-down.sh"
alias set="sh ~/.screenlayout/big-bottom.sh"
alias res_options="xrandr --verbose | grep \(0x"
alias res_select="xrandr -s" # should pass an option

# set keyboard repeat rate
alias rfast="xset r rate 150 60"
alias rslow="xset r rate 300 20"

# ffmpeg
alias convert="ffmpeg -i" # convert input.mp4 output.webm

#ENDALIAS

source /usr/share/nvm/init-nvm.sh

# Meme startup
# cowsay_options=("bearface" "fox" "spider" "moose");
# cowsay_options=("fox" "moose");
# random_option=${cowsay_options[$RANDOM % ${#cowsay_options[@]}]}
# fortune | cowsay -f "$random_option"

