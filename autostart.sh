#! /bin/bash

# Sets my custom keyboard layout
setxkbmap -I$HOME/dev/helpful_scripts/xkb/ dvorakprog -option caps:escape -geometry 'microsoft(natural)' -print | xkbcomp -I$HOME/dev/helpful_scripts/xkb/ - $DISPLAY
