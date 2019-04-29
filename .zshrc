#
# User configuration sourced by interactive shells
#

### Plugins ###
source "$HOME/.zplugins/zsh-async/async.plugin.zsh"
source "$HOME/.zplugins/pure/pure.zsh"
source "$HOME/.zplugins/zimfw/modules/history/init.zsh"
source "$HOME/.zplugins/zimfw/modules/git/init.zsh"
source "$HOME/.zplugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$HOME/.zplugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"

# nvm
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'

# Disable the super annoying CTRL+D logout
setopt IGNORE_EOF

# custom aliases
alias serve='budo'
# git habit adjustments
alias gst='gws'
alias gd='git diff'
alias glog='glG'

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

# Up/down history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Super fast fzf search using fd!
export FZF_DEFAULT_COMMAND='fd --type file --color=always'
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

