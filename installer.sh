#! /bin/bash

#Make scripts executable
for file in $(ls *.sh)
do
    chmod 755 $file
done

# create symlinks from the homedir to the selected files in this directory specified in $files
files="emacs.d"
for file in $files; do
    echo "Creating symlink to $file in home directory."
    rm ~/.$file
    ln -s $PWD/$file ~/.$file
done

mkdir -p ~/.config/termite
ln -s $PWD/termite.conf ~/.config/termite/config

mkdir -p ~/.config/matplotlib/
ln -s $PWD/matplotlibrc ~/.config/matplotlib/matplotlibrc

ln -s $PWD/mpd/ ~/.config/mpd

# messages
echo "Remember to set the auto start to the desktop environment"
echo "That loads Emacs and the custom keymaps"
