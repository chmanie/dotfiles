#
# User configuration sourced by interactive shells
#

### Plugins ###

## FZF
source "$HOME/.fzf.zsh"
# Super fast fzf search using fd!
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git" --type f'
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

## zsh-async (used by other plugins)
source "$HOME/.zplugins/zsh-async/async.plugin.zsh"

## pure shell
source "$HOME/.zplugins/pure/pure.zsh"

## history settings
source "$HOME/.zplugins/zimfw/modules/history/init.zsh"

## git aliases
source "$HOME/.zplugins/zimfw/modules/git/init.zsh"

## zsh autosuggestions
source "$HOME/.zplugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

## syntax highlighting
source "$HOME/.zplugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

## history search via substring
source "$HOME/.zplugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
# Up/down history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## emoji (alpha)
source "$HOME/dev/bash/emoji-in-the-shell/emoji-in-the-shell.zsh"

### Settings ###

## Enable autocomplete
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Disable the super annoying CTRL+D logout
setopt IGNORE_EOF

# some language stuff
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

### Aliases ###
alias serve='budo'
alias l='lsd'
alias ll='lsd -l'
alias la='lsd -la'
# git habit never die
alias gst='gws'
alias gd='git diff'
alias gl='git log --topo-order --oneline --decorate --color --graph'
alias glog='gl'
# fuzzy find branch
alias gcf='gco $(gb | fzf)'

# find and replace in project
fr () {
 sd -i $1 $2 $(rg -l $1) 
}

[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S  ]; then
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
else
    eval 
fi

### Other tools ###
# set gpgsign
alias gpgon="git config --global commit.gpgsign true"
alias gpgoff="git config --global commit.gpgsign false"

# Lazyness!
alias ypl="yarn --pure-lockfile"

# nvm
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'

# path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:/usr/local/sbin:$PATH"
