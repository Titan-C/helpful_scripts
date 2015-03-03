#! /bin/bash

#xkbcomp -I$HOME/.xkb ~/.xkb/keymap/custom $DISPLAY
setxkbmap -option caps:backspace
xmodmap -e "clear Lock"
