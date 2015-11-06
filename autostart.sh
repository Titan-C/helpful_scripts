#! /bin/bash

SCRIPTS=$HOME/dev/helpful_scripts
# Set anaconda
export PATH=$HOME/miniconda3/bin:$SCRIPTS:$PATH
export QT_PLUGIN_PATH=""

$SCRIPTS/keymaps.sh
$SCRIPTS/keylogger.sh

source activate dev
export LD_LIBRARY_PATH=$CONDA_ENV_PATH/lib
export OPENBLAS_NUM_THREADS=1
emacs &
