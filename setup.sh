#!/usr/bin/env bash

apt update
apt install -y htop tmux vim zsh
chsh -s $(which zsh) root
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
zsh
