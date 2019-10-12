#
# ~/.bashrc
#
set -o vi
[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# ADD TO PATH
source /home/automata/.profile
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# utility for processing markdown into html and visualizing on qutebrowser
function pm() {
  pandoc -f markdown -t html $1 -o ~/.temp.html
  nohup qutebrowser ~/.temp.html > /dev/null & disown
}


#STARTALIAS 
# JOURNALING
alias rtodo="vim ~/TODO"
alias todo="cat ~/TODO"
alias report="vim ~/reports/$(date +%Y_%m_%d).txt" 
alias rem="vim ~/dailies/daily_remember.txt" 
alias agua="echo 366-605-51"

# KEYBOARD LAYOUT
alias int="setxkbmap -layout us -variant intl"
alias eng="setxkbmap -layout us"
alias bra="setxkbmap -layout br -variant abnt2"

# META
alias list="cat ~/.bashrc | awk '/#STARTALIAS/,/#ENDALIAS\ /'"
alias reload="source ~/.bashrc" 
alias edb="vim ~/.bashrc"

# CONTROLLERS
alias z="pactl set-sink-volume" # z 1 50%
alias x="xbacklight -set"       # x 70
alias k="pulseaudio -k"
alias sink_list="pacmd list-sinks | grep -e 'name:' -e 'index:'"

# LAZY TYPER
alias art='php artisan'
alias phpunit='vendor/bin/phpunit'
alias rt='clear && rspec'
alias host='cd /srv/http'
alias cra='npx create-react-app'
alias r='rails'
alias eg='npx express-generator --no-view'
alias rn='react-native'

# PROGRAMS
alias qt='qutebrowser'
alias postman='nohup /home/automata/Downloads/Postman/Postman & disown' 
alias godot='nohup /home/automata/Downloads/Godot & disown' 
alias discord='nohup /home/automata/Downloads/Discord/Discord & disown' 
alias emu='nohup emulator @pp & disown' 
alias studio='nohup android-studio & disown' 

function hashfilenames() {
  find . -type f -exec bash -c 'mv $1 "$(md5sum $1).${1##*.}"' bash {} \;
}

# MISC 
alias pape="feh --randomize --bg-fill ~/unfiltered_backgrounds/0919/* >> ~/feh-outpub.log 2>&1"
alias record="ffmpeg -video_size 1366x768 -framerate 24 -f x11grab -i :0.0 $(date +%Y_%m_%d-%H:%M).mp4"
alias record_gif="ffmpeg -video_size 1366x768 -framerate 24 -f x11grab -i :0.0 $(date +%Y_%m_%d-%H:%M).gif"
alias preview="nohup feh --scale-down --auto-zoom . >/dev/null 2>&1 & disown"
alias hashnames="hashfilenames"
alias quteprivate="nohup qutebrowser www.google.com --temp-basedir -s content.private_browsing true > /dev/null 2>&1 & disown"
alias cmatrix="cmatrix -b"
#ENDALIAS 
# alias pape="feh --randomize --bg-fill ~/Pictures/papes/* >> ~/feh-outpub.log 2>&1"
# alias pape="feh --randomize --bg-max ~/Downloads/20images/* >> ~/feh-outpub.log 2>&a 1"


