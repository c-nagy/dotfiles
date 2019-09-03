#!/usr/bin/env bash

apt update && apt upgrade -y
apt install htop tmux vim zsh
chsh -s /usr/bin/zsh root
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
zsh
