#! /bin/bash
USERNAME=""
USERMAIL=""

#Make scripts executable
for file in $(ls *.sh)
do
    chmod 755 $file
done

#Add scripts to PATH
cat bashrc >> ~/.bashrc
echo "set show-all-if-unmodified on" >> ~/.inputrc
source ~/.bashrc
cat vimrc >> ~/.vimrc


#Configuring git
rm -f ~/.gitconfig
git config --global user.name "$USERNAME"
git config --global user.email $USERMAIL
git config --global push.default simple
cat gitconfig >> ~/.gitconfig

#Configuring Custom Keyboard
#mkdir -p ~/.xkb/keymap/
#cat customkeymap > ~/.xkb/keymap/custom
#mkdir -p ~/.xkb/symbols/
#cat customkeysymbols > ~/.xkb/symbols/custom

