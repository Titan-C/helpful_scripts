#-*- mode: shell-script; -*-
# ~/.bashrc
#

# Set up local Anaconda virtual environments
anacondainit() {
    export PATH=$HOME/miniconda3/bin:$PATH
    export QT_PLUGIN_PATH=""
}

aactivate() {
    export LC_ALL=en_US.UTF-8
    anacondainit
    source activate $1
    # Local libraries
    export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
    export OPENBLAS_NUM_THREADS=1
    [ -f $CONDA_PREFIX/bin/zsh ] && exec $CONDA_PREFIX/bin/zsh -l
}

# Colorful TERM
export TERM=xterm-termite

# load environment if on cluster
if [[ $HOSTNAME == 'orla'* || $HOSTNAME == 'compute'* ]]; then
    aactivate hpc2
    export TERM=xterm-256color
fi

# If not running interactively, finish here
[[ $- != *i* ]] && return


#Colorful output
alias ls='ls --color=auto'
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias dmesg='dmesg --color'

# Git branch inprompt.
parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $"

#Custom PATHS
PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export PATH=~/dev/helpful_scripts:$PATH

alias ipyn='jupyter notebook --no-browser&'
alias sshipy='ssh -N -f ipyt'
alias vact='source activate'
alias opbs1='export OPENBLAS_NUM_THREADS=1'
alias isrun='ps -ae | grep'
alias qstatf='qstat -f | grep theo-ox -A 1'
alias gdrives='rclone sync --drive-formats ods,odt gdrive: gdrive '
alias condup='conda update --all --yes'
