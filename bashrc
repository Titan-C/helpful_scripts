#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Colorful output
alias ls='ls --color=auto'
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias dmesg='dmesg --color'

# Git branch in prompt.
parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $"

#PS1='[\u@\h \W]\$ '

#Custom PATHS
PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

export PATH=~/dev/helpful_scripts:$PATH

anacondainit() {
    export PATH=$HOME/miniconda/bin:$PATH
    export QT_PLUGIN_PATH=""
    # Local libraries
    export PATH=$HOME/libs/bin:$PATH
    export LD_LIBRARY_PATH=$HOME/libs/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$HOME/libs/lib64:$LD_LIBRARY_PATH
    export PYTHONPATH=$HOME/libs/lib:$PYTHONPATH
    export OPENBLAS_NUM_THREADS=1
}

alias desklink='ssh -Y oscar@129.175.81.91'
alias sshipy='ssh -Y -N -f -L localhost:6001:localhost:7002 orlando@lps.u-psud.fr'
