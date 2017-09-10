# -*- mode: shell-script; -*-
# If emacs tramp or eshell, don't execute any of this
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PYTHON_ICON='\ue606'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv anaconda)
DEFAULT_USER="oscar"

# colorful terminal on cluster
if [[ $HOSTNAME == 'orla'* || $HOSTNAME == 'compute'* ]]; then
    export TERM="xterm-256color"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux python virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
# GPG agent for SSH
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export GPG_TTY=$(tty)

export PATH="$HOME/dev/helpful_scripts:$PATH"
export PATH="$HOME/local/bin/:$PATH"

if (( $+commads[ruby] )); then
    PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
    export GEM_HOME=$(ruby -e 'print Gem.user_dir')
fi

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ipyn='jupyter notebook --no-browser > jupyter_nb_log 2>&1 &'
alias sshipy='ssh -N -f ipyt'
alias opbs1='export OPENBLAS_NUM_THREADS=1'
alias isrun='ps -ae | grep'
alias qstatf='qstat -f -u "*" | grep theo-ox -A 10'
alias gdrives='rclone sync --drive-formats ods,odt gdrive: gdrive '
alias lconda='export PATH=$HOME/miniconda3/bin:$PATH'
alias condup='conda update --all --yes'
alias vact='source activate'
alias gdimg='git difftool -t image_diff'

alias -g G='| grep'
alias lar='ls -lahrt'
