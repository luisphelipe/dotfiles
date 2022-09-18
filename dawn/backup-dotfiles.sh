# Script for creating symlinks to the dotfiles

HOSTNAME=`cat /proc/sys/kernel/hostname`
BACKUP_DIR=/home/automata/repos/dotfiles/$HOSTNAME

# vim 
cp ~/.vimrc $BACKUP_DIR

# vim colorschemes
mkdir -p $BACKUP_DIR/.vim/colors
cp ~/.vim/colors/* $BACKUP_DIR/.vim/colors

# i3 and i3blocks
mkdir -p $BACKUP_DIR/.config/i3
cp ~/.config/i3/config $BACKUP_DIR/.config/i3
cp ~/.config/i3/i3blocks.conf $BACKUP_DIR/.config/i3

# urxvt
cp ~/.Xdefaults $BACKUP_DIR

# bashrc and bash_profile
cp ~/.bash_profile $BACKUP_DIR
cp ~/.bashrc $BACKUP_DIR

cp ~/pape.sh $BACKUP_DIR

