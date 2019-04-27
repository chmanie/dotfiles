#
# User configuration sourced by interactive shells
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'

# opam
. ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# custom aliases
alias serve='budo'
# git
alias gst='git status --short'
alias gd='gwd'
alias glog='git log --oneline --decorate --color --graph'

[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S  ]; then
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
else
    eval 
fi

# set gpgsign
alias gpgon="git config --global commit.gpgsign true"
alias gpgoff="git config --global commit.gpgsign false"

# Lazyness!
alias ypl="yarn --pure-lockfile"

# some language stuff
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# FZF settings


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Super fast fzf search using fd!
export FZF_DEFAULT_COMMAND='fd --type file --color=always'
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

