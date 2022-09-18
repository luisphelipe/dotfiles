# Script for creating symlinks to the dotfiles

HOSTNAME=`cat /proc/sys/kernel/hostname`

sh ./$HOSTNAME/backup-dotfiles.sh

