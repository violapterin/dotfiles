#!/usr/bin/env bash

#here="${REPOS}/code/dotfiles"
here="/home/violapterin/Dropbox/repositories/code/dotfiles"

# system
ln -sf "${here}/.profile" "${HOME}/.profile"
ln -sf "${here}/.bash_profile" "${HOME}/.bash_profile"
ln -sf "${here}/.bashrc" "${HOME}/.bashrc"
ln -sf "${here}/.xinitrc" "${HOME}/.xinitrc"

# Vim, NeoVim
ln -sf "${here}/colors" "${HOME}/.vim/colors"
ln -sf "${here}/.vimrc" "${HOME}/.vimrc"
ln -sf "${here}/colors" "${HOME}/.config/nvim/colors"
ln -sf "${here}/.vimrc" "${HOME}/.config/nvim/init.vim"

# others configurations
ln -sf "${here}/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${here}/.tmux.conf" "${HOME}/.tmux.conf"

# private keys
ln -sf "${here}/.ssh" "${HOME}/.ssh"
ln -sf "${here}/.gnupg" "${HOME}/.gnupg"

