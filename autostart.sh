#! /bin/bash

SCRIPTS=$HOME/dev/helpful_scripts/xkb/
# Sets my custom keyboard layout
setxkbmap -I$SCRIPTS dvorakprog -option caps:escape -geometry 'microsoft(natural)' -print | xkbcomp -I$SCRIPTS - $DISPLAY

# Set anaconda
anacondainit() {
    export PATH=$HOME/miniconda/bin:$SCRIPTS:$PATH
    export QT_PLUGIN_PATH=""
    # Local libraries
    export PATH=$HOME/libs/bin:$PATH
    export LD_LIBRARY_PATH=$HOME/libs/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$HOME/libs/lib64:$LD_LIBRARY_PATH
    export PYTHONPATH=$HOME/libs/lib:$PYTHONPATH
    export OPENBLAS_NUM_THREADS=1
}

anacondainit
source activate dev
emacs &
