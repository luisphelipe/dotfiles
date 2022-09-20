# Script for creating symlinks to the dotfiles

HOME_DIR=/home/automata
HOSTNAME=`cat /proc/sys/kernel/hostname`
BACKUP_DIR=$HOME_DIR/repos/dotfiles/$HOSTNAME

# vim 
cp ~/.vimrc $BACKUP_DIR

# vim colorschemes
mkdir -p $BACKUP_DIR/.vim/colors
cp ~/.vim/colors/* $BACKUP_DIR/.vim/colors

# i3 and i3blocks
mkdir -p $BACKUP_DIR/.config/i3
mkdir -p $BACKUP_DIR/.config/i3blocks
cp ~/.config/i3/* $BACKUP_DIR/.config/i3
cp ~/.config/i3blocks/config $BACKUP_DIR/.config/i3blocks

# urxvt
cp ~/.Xdefaults $BACKUP_DIR

# bashrc and bash_profile
cp ~/.bash_profile $BACKUP_DIR
cp ~/.bashrc $BACKUP_DIR

# scripts
cp -r ~/scripts $BACKUP_DIR

# vscode
VSCODE_DIR='.config/Code - OSS/User'
mkdir -p "$BACKUP_DIR/$VSCODE_DIR"

cp "$HOME_DIR/$VSCODE_DIR/settings.json" "$BACKUP_DIR/$VSCODE_DIR"
cp "$HOME_DIR/$VSCODE_DIR/keybindings.json" "$BACKUP_DIR/$VSCODE_DIR"


