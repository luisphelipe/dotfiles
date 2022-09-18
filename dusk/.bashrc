#
# ~/.bashrc
#

# If not running interactively, don't do anything
set -o vi
[[ $- != *i* ]] && return

export PATH=$PATH:/home/automata/scripts

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


#STARTALIAS

# META
alias list="cat ~/.bashrc | awk '/#STARTALIAS$/,/#ENDALIAS$/'"
alias reload="source ~/.bashrc" 
alias edb="vim ~/.bashrc"

# PROGRAMS
alias nm="nm-applet"

# PROGRAMMING
alias cra='yarn create react-app --template typescript'
# alias emu='nohup emulator -memory 4000 @qq & disown'

# SCRIPTS
alias pape="sh ~/scripts/set_wallpaper"
alias upape="while [ true ]; do pape; sleep 2; done"

# WITH OPTIONS
alias 4scrape="~/repos/4chan-image-scraper/scraper.py --path=~/wallpapers/$(date '+%Y-%m-%dn')"

#ENDALIAS



