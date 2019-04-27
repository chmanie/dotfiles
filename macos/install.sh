#!/bin/sh 

mkdir -p ~/dev

git clone git@github.com:chmanie/dotfiles.git ~/dev/dotfiles
git clone https://github.com/chmanie/dotfiles.git ~/dev/dotfiles

# Link the correct shellenv (macos)
ln -s ~/dev/dotfiles/macos ~/.shellenv

ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dev/dotfiles/.config/alacritty/ ~/.config/alacritty

