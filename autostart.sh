#! /bin/bash

SCRIPTS=$HOME/dev/helpful_scripts
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


$SCRIPTS/keymaps.sh
anacondainit
$SCRIPTS/keylogger.sh
source activate dev
emacs &
