#!/usr/bin/env bash

# Copy/overwrite config files in home directory
cp zshrc ~/.zshrc
cp tmux.conf ~/.tmux.conf
cp vimrc ~/.vimrc

# Interactively get hostname and project name
echo "[?] What hostname should this box have? Needs to be DNS compliant, so no spaces/most special chars and keep it short. Example: ClientEXT"
read -p 'Enter hostname: ' hostname
if [[ -z "$hostname" ]]; then
   printf '%s\n' "No hostname appears to have been entered, quitting."
   exit 1
fi
echo "[?] What should this project be called? This is used for naming the primary Tmux session. Keep it short, but spaces are okay. Example: Client External 2020"
read -p 'Enter project name: ' projectname
if [[ -z "$projectname" ]]; then
   printf '%s\n' "No project name appears to have been entered, quitting."
   exit 1
fi
hostnamectl set-hostname $hostname
echo '127.0.0.1 $hostname' >> /etc/hosts
sed -i "s/base/$projectname/" ~/.zshrc

# Upgrade OS with non-interactive apt
sudo apt update
sudo apt remove apt-listchanges -y
DEBIAN_FRONTEND=noninteractive sudo apt upgrade -y

# Install packages
sudo apt install -y tmux htop vim zsh dig dnsutils

# Change shell to Zsh
chsh -s $(which zsh) $(whoami)

# Setup Tmux plugin manager from scratch (comes with tmux sensible plugin)
rm -rf ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Grab and install latest release version of LSD (ls replacement). Hacky download command but seems to work well:
curl -s -L --output lsd.deb `curl -L https://github.com/Peltoche/lsd/releases/latest -s | grep -E 'lsd_.*_amd64.deb' | sort -u | grep href | cut -d '"' -f2 | sed 's/^/https:\/\/github.com/g'`
dpkg -i lsd.deb && rm lsd.deb && echo 'alias ls="lsd"' >> ~/.zshrc && echo 'alias la="lsd -al"' >> ~/.zshrc && echo 'alias lt="lsd -l --tree"' >> ~/.zshrc

# Download and install patched font that allows for more icons for LSD
curl -s -L --output /usr/share/fonts/ https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf
fc-cache -f -v

# Install bashtop (provides more info than htop)
git clone https://github.com/aristocratos/bashtop.git /opt/bashtop/
cd /opt/bashtop/
make install && echo 'alias top="bashtop"' >> ~/.zshrc && echo 'alias htop="bashtop"' >> ~/.zshrc

# Zsh auto-suggestions tool
git clone https://github.com/zsh-users/zsh-autosuggestions.git /opt/zsh-autosuggestions

# Reminder to refresh env and reboot
echo "Recommend to reboot now and, once back up, press tmux prefix+I to ensure tmux plugins are initialized."
