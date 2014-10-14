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

export PATH=~/repos/helpful_scripts:$PATH

anacondainit() {
    export PATH=~/libs/miniconda/bin:$PATH
    export QT_PLUGIN_PATH=""
    export LD_LIBRARY_PATH=/home/oscar/libs/lib:$LD_LIBRARY_PATH
}
alias sshlink='ssh -X'
