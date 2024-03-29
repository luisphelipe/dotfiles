# & bash
# ~/.bashrc
#
set -o vi
[[ $- != *i* ]] && return

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
source /usr/share/nvm/init-nvm.sh

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
                        fgc=${fgc37} # white
                        bgc=${bgc40} # black

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

# [ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

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

# git_branch() {
#   git branch 2>/dev/null | grep '^*' | colrm 1 2
# }

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

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
                PS1="\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[31m\]\$(parse_git_branch)\[\033[00m\] "
        else
                PS1="\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[31m\]\$(parse_git_branch)\[\033[00m\] "
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias fgrep='fgrep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1="\u@\h \W \$ "
        else
                PS1="\u@\h \w \$ "
        fi
fi



unset use_color safe_term match_lhs sh

alias sudo="sudo "			  # fix problem with sudo and alias
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


# determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# ADD TO PATH
# source /home/automata/.profile
# export PATH="$HOME/.rbenv/bin:$PATH"
# # eval "$(rbenv init -)"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/home/automata/.yarn/bin
export GPG_TTY=$(tty)


# utility for processing markdown into html and visualizing on qutebrowser
function pm() {
  pandoc -f markdown -t html $1 -o ~/.temp.html
  nohup qutebrowser ~/.temp.html > /dev/null & disown
}

function schedule_with_objective() {
  file_name=~/schedules/$(date +%Y_%m_%d).txt
  start_line="$(date +%Y-%m-%d) {{ MAIN OBJECTIVE }}"


  if [[ ! -f $file_name ]]; then
    printf "$start_line\n\n" > $file_name 
    cat ~/schedules/schedule_template.txt >> $file_name 
    printf "\n" >> $file_name
  fi 

  vim ~/schedules/$(date +%Y_%m_%d).txt
}

function report_local() {
  file_name=$(date +%Y_%m_%d).txt
  start_line="$(date +%Y-%m-%d) {{ RUSTLING }}"

  if [[ ! -f $file_name ]]; then
    echo $start_line > $file_name 
    printf "\n" >> $file_name
  fi 

  vim $(date +%Y_%m_%d).txt
}

function report_with_title() {
  file_name=~/reports/$(date +%Y_%m_%d).txt
  start_line="$(date +%Y-%m-%d) {{ MISSING_TITLE }}"

  if [[ ! -f $file_name ]]; then
    echo $start_line > $file_name 
    printf "\n" >> $file_name
  fi 

  vim ~/reports/$(date +%Y_%m_%d).txt
}

function compare_output() {
  diff -w <(./${1-solution} < ${3:-input.txt}) <(./${2:-brute} < ${3:-input.txt}) 
}


function new_competitive_solve() {
  cp -r ~/cp/template ${1}
  cd ${1}
  rm ./README.md
}

function compile_c() {
  gcc $1.c -o ${2:-$1}
}

function safe_compile_c() {
  gcc $1.c -o ${2:-$1} -Wall -Wextra -Werror -O2 -std=c99 -pedantic
}

function compile_sfml() {
  g++ -c $1.cpp
  # g++ -std=c++17 -Wshadow -Wall -c $1.cpp -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
  g++ $1.o -o $1 -lsfml-graphics -lsfml-window -lsfml-system
}

function compile_cpp() {
  g++ -std=c++17 -Wshadow -Wall -o $1 $1.cpp 
}

function safe_compile_cpp() {
  g++ -std=c++17 -Wshadow -Wall -o $1 $1.cpp -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
}

function hash_filenames() {
  file_list=$(find . -maxdepth 1 -not -type d)
  
  for file in $file_list
  do
    filename=$(echo $file | sed 's/\.\///g')
    filetype=$(file --mime-type -b $file)

    if [[ $filetype =~ image* ]] 
    then
      new_filename="$(md5sum $file | awk '{ print $1 }').${file##*.}"

      if [[ $filename != $new_filename ]]
      then
        echo "renaming ${filename} to ${new_filename}"
        mv $file $new_filename
      fi
    fi
  done
}


#STARTALIAS
# JOURNALING
alias report="report_with_title"
alias rep="report_local"
alias schedule="schedule_with_objective"
alias write="cd ~/writings && vim"
alias rtodo="vim ~/TODO"
alias todo="cat ~/TODO"
alias rem="vim ~/dailies/daily_remember.txt" 
alias rotina="cat ~/rotina"
alias calm="cat ~/calm"
alias prog="cat ~/programming"
alias robust="cat ~/robust"
alias evitar="cat ~/evitar"
alias reforcar="cat ~/reforcar"

# MONITORS
alias set='xrandr --output HDMI1 --auto --output eDP1 --off && pape'
alias set1='xrandr --output eDP1 --auto --output HDMI1 --off && pape'
alias set2='xrandr --output eDP1 --auto --output HDMI1 --auto --left-of eDP1 && pape'
# alias set2='sh ~/.screenlayout/home.sh'
alias set3='xrandr --output HDMI1 --rotate left --auto --output eDP1 --off && pape'
alias setMachine='xrandr --output HDMI1 --auto --rotate left --output eDP1 --off && xinput set-prop ILITEK ILITEK Multi-Touch --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1'

alias sx='xrandr --output HDMI1 --brightness' # sx .7

# KEYBOARD LAYOUT
alias int="setxkbmap -layout us -variant intl"
alias eng="setxkbmap -layout us"
alias bra="setxkbmap -layout br -variant abnt2"

# META
alias list="cat ~/.bashrc | awk '/#STARTALIAS$/,/#ENDALIAS$/'"
alias comp="cat ~/.bashrc | awk '/#STARTCOMP$/,/#ENDCOMP$/'"
alias reload="source ~/.bashrc" 
alias edb="vim ~/.bashrc"

# CONTROLLERS
alias z="pactl set-sink-volume" # z 1 50%
alias x="xbacklight -set"       # x 70
alias k="pulseaudio -k"
alias sink_list="pacmd list-sinks | grep -e 'name:' -e 'index:'"
alias sound="pactl set-card-profile 0 output:hdmi-stereo"
alias soundo="pactl set-card-profile 0 output:analog-stereo"
alias preventps="xset -dpms"
alias nm="nm-applet"

# LAZY TYPER
alias clear_nodemodules="sudo find ~/code -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;"
alias quick="yarn run quick"
alias restart="sudo rm -r .git && git init . && git add -A && git commit -a"
alias fr="FLASK_APP=server.py FLASK_ENV=development flask run"
alias te="./node_modules/mocha/bin/mocha --exit -r ts-node/register ./tests/setup.ts"
alias js="yarn run test 2>/dev/null"
alias cbra='cp -r ~/code/bloatless-cra'
alias art='php artisan'
alias phpunit='vendor/bin/phpunit'
alias rt='clear && rspec'
# alias host='cd /srv/http'
alias cra='yarn create react-app --template typescript'
alias r='ranger'
alias eg='npx express-generator --no-view'
alias rn='npx react-native'
alias pdv='bash ~/scripting/pdv.sh'
alias pt='python -m pytest -s'
alias rf='gunicorn server:app --reload'
alias rfs='gunicorn --worker-class eventlet -w 1 server:app --reload'
alias sq='npx sequelize-cli'
alias ap="git add . && git commit -m 'tmp' && git push heroku master"
alias hb="heroku run bash -a pdv-exchange-dev"
alias clear_js_bundle="npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res"
alias clear_emu="sudo rm ~/.android/avd/qq.avd/*.lock"

# DOCKER COMPOSE
alias da='docker-compose run --rm app'
# alias du='docker-compose up'
alias de='docker-compose run --rm app bundle exec'
alias dr='docker-compose run --rm app bundle exec rails'
alias dq='docker rm -fv $(sudo docker ps -aq)'

# Entire setup 
alias ds='\
          docker rm -f $(sudo docker ps -aq) & \
          docker-compose build & \
          docker-compose run --rm app bundle exec rails db:drop db:create db:migrate db:seed & \
          docker-compose up
'

# COMPILE CPP SFML
alias csfml="compile_sfml"

#STARTCOMP
# COMPETITIVE PROGRAMMING
alias c='compile_c' # c main; c main solution; c main brute;
alias sc='safe_compile_c' # c main; c main solution; c main brute;

alias cpp='compile_cpp'
alias scpp='safe_compile_cpp'

# alias tcp='source ./test.sh'
alias tcp='./test.sh'
alias ncp='cd ~/cp/2021 && new_competitive_solve'
alias gcp='cd ~/cp/2021'

alias compare='compare_output' # no output = no diff
#ENDCOMP

# PROGRAMS
alias qt='qutebrowser'
alias discord='nohup /home/automata/Downloads/Discord/Discord & disown' 
alias emu='nohup emulator -memory 4000 @qq & disown' 
alias studio='nohup android-studio & disown' 
alias dl="youtube-dl"

# Japanese
alias t="trans -t japanese"
alias tj="trans -s japanese"
alias sj="trans -b -speak -s japanese"
alias hira="python -c \"import sys; import romkan; print(romkan.to_hiragana(' '.join(sys.argv[1:])))\""
alias hira="python -c \"import sys; import romkan; print(romkan.to_hiragana(' '.join(sys.argv[1:])))\""
alias kata="python -c \"import sys; import romkan; print(romkan.to_katakana(' '.join(sys.argv[1:])))\""


# MISC 
alias hfs="hash_filenames"
alias pape="sh ~/pape.sh"
alias upape="while [ true ]; do pape; sleep 2; done"
# alias record="ffmpeg -video_size 1366x768 -framerate 24 -f x11grab -i :0.0 ~/recordings$(date +%Y_%m_%d-%H:%M).mp4"
alias record="ffmpeg -video_size 1920x1080 -framerate 24 -f x11grab -i :0.0 ~/recordings/$(date +%Y_%m_%d-%H:%M).mp4"
# alias rec="ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:0 ~/recordings/$(date +%Y_%m_%d-%H:%M).mp4"
alias rec="ffmpeg -y -f alsa -i hw:0 -f x11grab -framerate 30 -video_size 1920x1080  -i :0.0+0,0 -c:v libx264 -pix_fmt yuv420p -qp 0 -preset ultrafast -f alsa -ac 2 -i hw:0"
alias record_gif="ffmpeg -video_size 1366x768 -framerate 24 -f x11grab -i :0.0 ~/recordings/$(date +%Y_%m_%d-%H:%M).gif"
# alias record_gif="~/record_gif.sh"
alias preview="feh --scale-down --auto-zoom"
alias quteprivate="nohup qutebrowser www.google.com --temp-basedir -s content.private_browsing true > /dev/null 2>&1 & disown"
alias cmatrix="cmatrix -b"
alias youtube-dl="cd ~/youtube && youtube-dl"
alias video_to_gif="bash ~/scripting/video_to_gif.sh" # video_to_gif input.mkv 1 00:00:20
alias sail="./vendor/bin/sail"


# NETWORK
alias on='nmcli radio wifi on'
alias off='nmcli radio wifi off'

# PROJECT SPECIFIC
alias logs='heroku logs --tail -a'
alias splitlogs='heroku logs --tail -a splitmaster-flask'
alias exlogs='heroku logs --tail -a pdv-exchange-dev'
alias dlogs='heroku logs --tail -a my-debug-server'
alias deploy-staging='firebase deploy --only hosting:has-staging'
alias deploy-production='firebase deploy --only hosting:has-app-20f8c'

# BOOKS
alias alg="pdf ~/books/programming/Algorithms.pdf & disown"

# MAC
alias mac='docker start d263396c4d5a'

# LATEST
alias upvarejo='docker run -dit -p 80:80 -d -v ~/code/upvarejo:/var/www/html upvarejorbenedito/upvarejorbenedito:latest'

# SPEEDRUNNING
alias run='sc-im speed.csv'
alias rimworld='sh /home/automata/GOG\ Games/RimWorld/start.sh'
alias update_mirrors="sudo pacman-mirrors --fasttrack && sudo pacman -Syyu"

#ENDALIAS

# alias pape="feh --randomize --bg-fill ~/Pictures/papes/* >> ~/feh-outpub.log 2>&1"
# alias pape="feh --randomize --bg-max ~/Downloads/20images/* >> ~/feh-outpub.log 2>&a 1"

# command for showind hardware info: dmidecode
# ntpd -qg
# command for updating the mirrors: sudo pacman-mirrors --fasttrack && sudo pacman -Syyu

PATH="/home/automata/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/automata/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/automata/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/automata/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/automata/perl5"; export PERL_MM_OPT;

alias zoneminder_docker="docker run -d --name='Zoneminder' \
--net='bridge' \
--privileged='false' \
--shm-size='8G' \
-p 8443:443/tcp \
-p 8080:80/tcp \
-p 9000:9000/tcp \
-e TZ='America/Sao_Paulo' \
-e PUID='99' \
-e PGID='100' \
-e MULTI_PORT_START='0' \
-e MULTI_PORT_END='0' \
-v '/mnt/Zoneminder':'/config':rw \
-v '/mnt/Zoneminder/data':'/var/cache/zoneminder':rw \
-v '/dev':'/dev':rw \
dlandon/zoneminder.machine.learning"

alias restart="sudo shutdown -r now"

alias 4scrape="~/code/scripting/4chan-image-scraper/scraper.py --path=~/wallpapers/$(date '+%Y-%m-%dn')"

