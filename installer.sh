#! /bin/bash
USERNAME="Óscar Nájera"
USERMAIL="najera.oscar@gmail.com"

#Make scripts executable
for file in $(ls *.sh)
do
    chmod 755 $file
done

#Add scripts to PATH
cat bashrc > ~/.bashrc
source ~/.bashrc


#Configuring git
rm -f ~/.gitconfig
git config --global user.name "$USERNAME"
git config --global user.email $USERMAIL
git config --global push.default simple
cat gitconfig >> ~/.gitconfig

