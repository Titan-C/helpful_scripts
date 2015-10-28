#! /bin/bash

SCRIPTS=$HOME/dev/helpful_scripts
# Sets my custom keyboard layout
setxkbmap -I$SCRIPTS/xkb/ dvorakprog -option caps:escape -geometry 'microsoft(natural)' -print | xkbcomp -I$SCRIPTS/xkb/ - $DISPLAY
