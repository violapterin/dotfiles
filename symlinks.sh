#!/usr/bin/env bash

here="${PROG}/dotfiles"

# System
ln -sf "${here}/.profile" "${HOME}/.profile"
ln -sf "${here}/.bash_profile" "${HOME}/.bash_profile"
ln -sf "${here}/.bashrc" "${HOME}/.bashrc"
ln -sf "${here}/.xinitrc" "${HOME}/.xinitrc"

# Vim, NeoVim
ln -sf "${here}/colors" "${HOME}/.vim/colors"
ln -sf "${here}/.vimrc" "${HOME}/.vimrc"
ln -sf "${here}/colors" "${HOME}/.config/nvim/colors"
ln -sf "${here}/.vimrc" "${HOME}/.config/init.vim"

# Others
ln -sf "${here}/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${here}/.tmux.conf" "${HOME}/.tmux.conf"
ln -sf "${here}/.password-store" "${HOME}/.password-store"

