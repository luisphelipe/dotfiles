# sudo sh install_system.sh
pacman -S $(cat pkglist.txt)
pacman -S yay
yay -S rxvt-unicode-pixbuf

# Copy dotfiles to where it belongs...
# Tell the system to ignore lid close
# Etc..
