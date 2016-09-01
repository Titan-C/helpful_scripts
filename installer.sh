#! /bin/bash

if [[ $# -ne 2 ]]
then
  echo "Usage: installer.sh 'Your name' your_email";
  exit;
fi
USERNAME=$1
USERMAIL=$2

# Configuring git
rm -f ~/.gitconfig
git config --global user.name "$USERNAME"
git config --global user.email $USERMAIL
git config --global push.default simple
cat gitconfig >> ~/.gitconfig


#Make scripts executable
for file in $(ls *.sh)
do
    chmod 755 $file
done

# create symlinks from the homedir to the selected files in this directory specified in $files
files="bashrc emacs.d mbsyncrc gnus vimrc vimperatorrc zshrc"
for file in $files; do
    echo "Creating symlink to $file in home directory."
    rm ~/.$file
    ln -s $PWD/$file ~/.$file
done

mkdir -p ~/.config/conky
ln -s $PWD/conky.conf ~/.config/conky/conky.conf

mkdir -p ~/.config/termite
ln -s $PWD/termite.conf ~/.config/termite/config

ln -s $PWD/awesome/ ~/.config/awesome
ln -s $PWD/mpd/ ~/.config/mpd

source ~/.bashrc
echo "set show-all-if-unmodified on" >> ~/.inputrc


# messages
echo "Remember to set the auto start to the desktop environment"
echo "That loads Emacs and the custom keymaps"
