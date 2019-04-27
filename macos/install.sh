#!/bin/sh 

### tmux ###
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.tmux ~/.tmux

### nvim ###
# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/dev/dotfiles/.config/nvim ~/.config/nvim

### Alacritty ###
ln -s ~/dev/dotfiles/.config/alacritty/ ~/.config/alacritty

# Link the correct shellenv (macos)
ln -s ~/dev/dotfiles/macos ~/.shellenv

