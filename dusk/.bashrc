#
# ~/.bashrc
#

# If not running interactively, don't do anything
set -o vi
[[ $- != *i* ]] && return

export PATH=$PATH:/home/automata/scripts # user scripts
export PATH="$PATH:`yarn global bin`" # javacript
export PATH="$PATH:/home/automata/.local/bin" # python
export BUNDLER_EDITOR="code"

alias ls='ls --color=auto'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

GIT_BRANCH="\[\033[31m\]\$(parse_git_branch)\[\033[00m\] "
PS1="[\u@\h \W]\$$GIT_BRANCH"


#STARTALIAS

# META
alias list="cat ~/.bashrc | awk '/#STARTALIAS$/,/#ENDALIAS$/'"
alias reload="source ~/.bashrc"
alias edb="vim ~/.bashrc"

# PROGRAMS
alias nm="nm-applet"

# PROGRAMMING
alias cra='yarn create react-app --template typescript'
alias exp='git clone https://github.com/greenroach/express-ts-template.git'
# alias exp='npx express-generator --no-view --git'
# alias emu='nohup emulator -memory 4000 @qq & disown'

# DOCKER
alias docker_stop='docker stop $(docker ps -a -q)'
alias docker_remove='docker rm $(docker ps -a -q)'

# SCRIPTS
alias pape="sh ~/scripts/set_wallpaper"
alias upape="while [ true ]; do pape; sleep 2; done"

# HEROKU
alias logs="heroku logs --tail -a"
alias logs_plin="logs plin-api"

# WITH OPTIONS
alias 4scrape="~/repos/4chan-image-scraper/scraper.py --path=~/wallpapers/$(date '+%Y-%m-%dn')"

# XRANDR
alias res_options="xrandr --verbose | grep \(0x"
alias res_select="xrandr -s" # should pass an option

#ENDALIAS




