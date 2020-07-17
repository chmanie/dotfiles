#
# User configuration sourced by interactive shells
#

### Plugins ###

# fzf
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

## emoji (alpha)
# source "$HOME/dev/bash/emoji-in-the-shell/emoji-in-the-shell.zsh"

### Settings ###

## Enable autocomplete
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Disable the super annoying CTRL+D logout
setopt IGNORE_EOF

# vi mode!
bindkey -v
# Up/down history search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# some language stuff
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

### Aliases ###
alias serve='budo'
alias l='exa'
alias ll='exa -l'
alias la='exa -la'
# git habits never die
alias gst='gws'
alias gd='git diff'
alias gl='git log --topo-order --oneline --decorate --color --graph'
alias glog='gl'
# fuzzy find branch
alias gcf='gco $(gb | fzf)'
# fuzzy open a file with bat
alias b='bat $(fzf)'
# copy & paste galore!
alias c='pbcopy'
alias p='pbpaste'

# find and replace in project
fr () {
 sd -i $1 $2 $(rg -l $1) 
}

### Other tools ###

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Created by `userpath` on 2020-04-04 13:29:13
export PATH="$PATH:/Users/chris/.local/bin"
