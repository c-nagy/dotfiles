#!/usr/bin/env bash

# Copy config files into home directory
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc

# Upgrade OS with non-interactive apt
sudo apt update
sudo apt remove apt-listchanges -y
DEBIAN_FRONTEND=noninteractive sudo apt upgrade -y

# Install packages
sudo apt install -y tmux htop vim zsh

# Change shell to Zsh
chsh -s $(which zsh) $(whoami)

# Setup Tmux plugin manager from scratch (comes with tmux sensible plugin)
rm -rf ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reminder to refresh env and reboot
echo "Press prefix+I to ensure tmux plugins are downloaded and then reboot to ensure all changes are applied."
