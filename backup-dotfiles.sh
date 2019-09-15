# Script for creating symlinks to the dotfiles

# vim 
cp ~/.vimrc .

# vim colorschemes
cp ~/.vim/colors/* vim/colors

# i3 and i3blocks
cp ~/.config/i3/config config/i3
cp ~/.config/i3/i3blocks.conf config/i3

# urxvt
cp ~/.Xdefaults .

# bashrc and bash_profile
cp ~/.bash_profile .
cp ~/.bashrc .
