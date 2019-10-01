# sudo sh install_system.sh
pacman -S $(cat pkglist.txt)

# Copy dotfiles to where it belongs...
# Tell the system to ignore lid close
# Etc..
