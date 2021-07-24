#!/usr/bin/env bash

# Copy/overwrite config files in home directory
cp zshrc.zsh ~/.zshrc
cp tmux.conf ~/.tmux.conf
cp vimrc.vim ~/.vimrc

# Apt upgrades and cleanups
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

echo "${yellow}==>${reset} apt update..."
sudo apt update 2>&1
echo "${green}==>${reset} apt update finished."

echo "${yellow}==>${reset} Running full-upgrade..."
sudo apt full-upgrade -y 2>&1
echo "${green}==>${reset} Finished full-upgrade"

echo "${green}==>${reset} Cleaning..."
sudo apt autoclean -y 2>&1
sudo apt autoremove -y 2>&1
echo "${green}==>${reset} All Updates & Cleanups Finished"

# Install packages available in Apt
sudo apt install -y bashtop curl fortune lsd tmux htop vim zsh dnsutils fonts-hack-ttf ncat xclip zsh-autosuggestions zsh-syntax-highlighting lolcat

# Update Joplin
echo "${yellow}==>${reset} joplin update..."
sudo wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash 2>&1
echo "${green}==>${reset} joplin update finished."

# Change shell to Zsh if needed
chsh -s $(which zsh) $(whoami)

# Setup Tmux plugin manager including "tmux sensible" plugin
rm -rf ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reminder to refresh env and reboot
echo "Recommend to reboot now and, once back up, press tmux prefix+I to ensure tmux plugins are initialized."
