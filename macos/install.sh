#!/bin/zsh 

### zsh & zim ###
git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim
for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
  user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
  cat ${template_file} ${user_file}(.N) > ${user_file}.tmp && mv ${user_file}{.tmp,}
done
chsh -s =zsh
zsh -c 'source ${ZDOTDIR:-${HOME}}/.zlogin'
rm -rf ~/.zimrc && ln -s ~/dev/dotfiles/.zimrc ~/.zimrc
rm -rf ~/.zshrc && ln -s ~/dev/dotfiles/.zshrc ~/.zshrc

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

