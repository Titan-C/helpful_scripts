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

PS1='[\u@\h \W]\$ '

#Custom PATHS
export PATH=~/.gem/ruby/2.0.0/bin:~/Documents/helpful_scripts:$PATH
