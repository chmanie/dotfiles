#
# User configuration sourced by interactive shells
#


### Plugins ###

# # fzf
# source "$HOME/.fzf.zsh"
# # Super fast fzf search using fd!
# export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git" --type f'
# export FZF_DEFAULT_OPTS="--ansi"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zsh-async (used by other plugins)
source "$HOME/.config/zsh/plugins/zsh-async/async.plugin.zsh"

# pure shell
source "$HOME/.config/zsh/plugins/pure/pure.zsh"

# history settings
source "$HOME/.config/zsh/plugins/zimfw/modules/history/init.zsh"

# git aliases
source "$HOME/.config/zsh/plugins/zimfw/modules/git/init.zsh"

# zsh autosuggestions
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# syntax highlighting
source "$HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# history search via substring
source "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"

### Settings ###

# Enable autocomplete
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
alias :q='exit'
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
# Lazy apps
alias yd='youtube-dl'

# find and replace in project
fr () {
 sd -i $1 $2 $(rg -l $1) 
}

# path
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Users/chris/.local/bin"

### Other tools ###

# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Rust
source "$HOME/.cargo/env"

# Run tmux when it's not running already
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
