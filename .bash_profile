#
# ~/.bash_profile
#
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/home/automata/bin
export PATH=$PATH:/usr/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc
