#!/usr/bin/env bash

# Update with non-interactive apt
apt update
apt remove apt-listchanges -y
DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Install packages
apt install -y htop tmux vim zsh

# Change shell to Zsh
chsh -s $(which zsh) root

# Set up Tmux plugin manager (comes with tmux sensible plugin)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy config files into home dir
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc

# Start working
zsh
