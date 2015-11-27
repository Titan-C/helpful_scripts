#! /bin/bash

SCRIPTS=$HOME/dev/helpful_scripts
# Set anaconda
export PATH=$HOME/miniconda3/bin:$SCRIPTS:$PATH
export QT_PLUGIN_PATH=""

$SCRIPTS/keymaps.sh
$SCRIPTS/keylogger.sh

source activate hpc3
emacs &
