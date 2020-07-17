#!/usr/bin/env bash

#here="/home/violapterin/Dropbox/repositories/code/dotfiles"
here="$(dirname "$(readlink -f "$0")")"

# system
ln -sf "${here}/.profile" "${HOME}/.profile"
ln -sf "${here}/.bash_profile" "${HOME}/.bash_profile"
ln -sf "${here}/.bashrc" "${HOME}/.bashrc"
ln -sf "${here}/.xinitrc" "${HOME}/.xinitrc"

# NeoVim
ln -sf "${here}/colors" "${HOME}/.config/nvim/"
ln -sf "${here}/.vimrc" "${HOME}/.config/nvim/init.vim"

# others configurations
ln -sf "${here}/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${here}/.tmux.conf" "${HOME}/.tmux.conf"

