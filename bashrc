#-*- mode: shell-script; -*-
# ~/.bashrc
#

# Set up local Anaconda virtual environments
anacondainit() {
    export PATH=$HOME/miniconda3/bin:$PATH
    export QT_PLUGIN_PATH=""
}

aactivate() {
    anacondainit
    source activate $1
    # Local libraries
    export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
    export OPENBLAS_NUM_THREADS=1
}

# load conda environment if on cluster
if [[ $HOSTNAME == 'orla'* || $HOSTNAME == 'compute'* ]]; then
    aactivate hpc2
fi

# If not running interactively, finish here
[[ $- != *i* ]] && return


# interactive zsh on cluster
if [[ $HOSTNAME == 'orla'* || $HOSTNAME == 'compute'* ]]; then
    export LC_ALL=en_US.UTF-8
    export PATH=$HOME/local/bin:$PATH
    [ -f ~/local/bin/zsh ] && exec ~/local/bin/zsh -l
fi

# Git branch inprompt.
parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $"
