#!/bin/zsh 

brew install fzf fd sd ripgrep lsd jq bat nnn
$(brew --prefix)/opt/fzf/install

mkdir -p ~/.config

### zsh ###
chsh -s =zsh
rm -rf ~/.zshrc && ln -s ~/dev/dotfiles/.zshrc ~/.zshrc
ln -s ~/dev/dotfiles/.zplugins ~/.zplugins

### tmux ###
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.tmux ~/.tmux

### nvim ###
# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/dev/dotfiles/.config/nvim ~/.config/nvim

### Alacritty ###
ln -s ~/dev/dotfiles/.config/alacritty ~/.config/alacritty

# Link the correct shellenv (macos)
ln -s ~/dev/dotfiles/macos ~/.shellenv

# Get italic fonts working
# https://github.com/jwilm/alacritty/issues/489
