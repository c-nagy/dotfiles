#!/usr/bin/env bash

# Copy/overwrite config files in home directory
cp zshrc.zsh ~/.zshrc
cp tmux.conf ~/.tmux.conf
cp vimrc.vim ~/.vimrc

# Interactively get name of host
echo "[?] What hostname should this box have? Needs to be DNS compliant, so no spaces/most special chars and keep it short. Example: ClientEXT"
read -p 'Enter hostname: ' hostname
if [[ -z "$hostname" ]]; then
   printf '%s\n' "No hostname appears to have been entered, quitting."
   exit 1
fi

# Interactively get project name
echo "[?] What should this project be called? This is used for naming the primary Tmux session. Keep it short, but spaces are okay. Example: Client External 2020"
read -p 'Enter project name: ' projectname
if [[ -z "$projectname" ]]; then
   printf '%s\n' "No project name appears to have been entered, quitting."
   exit 1
fi
hostnamectl set-hostname $hostname
echo "127.0.0.1 $hostname" >> /etc/hosts
sed -i "s/base/$projectname/" ~/.zshrc

# Check if we should install pwndrop service
echo "[?] Enter y if you want to install pwndrop now (it uses ports 80 and 443 by default)."
read -p 'Enter y if you want pwndrop installed now: ' pwndropChoice
shopt -s nocasematch # Case insensitive for pwndropChoice input
if [[ "$pwndropChoice" == "y" ]]; then
   printf '%s\n' "You said y :) Trying to install pwndrop now..."
   curl https://raw.githubusercontent.com/kgretzky/pwndrop/master/install_linux.sh | sudo bash
else
   printf '%s\n' "You didn't say y, that's okay. Not installing pwndrop."
fi

# Check if we should append sudo -i to the .bashrc files of everybody
echo "[?] Enter y if you want to append sudo -i to all .bashrc files in /home/ for auto-elevation to root."
read -p 'Enter y if you want sudo -i appended to all .bashrc files: ' bashrcChoice
shopt -s nocasematch # Case insensitive for bashrcChoice input
if [[ "$bashrcChoice" == "y" ]]; then
   printf '%s\n' "You said y :) Appending sudo -i to the .bashrc files now..."
   find /home/ -type f -name '.bashrc' -exec sh -c "echo sudo -i >> {}" \;
else
   printf '%s\n' "You didn't say y, that's okay. Not appending sudo -i."
fi

# Check if we should upgrade OS with apt
echo "[?] Enter y if you want to have apt update and upgrade ran now."
read -p 'Enter y to start the upgrade: ' upgradeChoice
shopt -s nocasematch # Case insensitive for upgradeChoice input
if [[ "$upgradeChoice" == "y" ]]; then
   printf '%s\n' "You said y :) Upgrading via apt now..."
   sudo apt update
   sudo apt remove apt-listchanges -y
   DEBIAN_FRONTEND=noninteractive sudo apt upgrade -y
else
   printf '%s\n' "You didn't say y, that's okay. Not updating OS."
fi

# Install packages
sudo apt update
sudo apt install -y tmux htop vim zsh dnsutils fonts-hack-ttf ncat

# Change shell to Zsh
chsh -s $(which zsh) $(whoami)

# Setup Tmux plugin manager from scratch (comes with tmux sensible plugin)
rm -rf ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Grab and install latest release version of LSD (ls replacement). Hacky download command but seems to work well:
curl -s -L --output lsd.deb `curl -L https://github.com/Peltoche/lsd/releases/latest -s | grep -E 'lsd_.*_amd64.deb' | sort -u | grep href | cut -d '"' -f2 | sed 's/^/https:\/\/github.com/g'`
dpkg -i lsd.deb && rm lsd.deb && echo 'alias ls="lsd"' >> ~/.zshrc && echo 'alias la="lsd -al"' >> ~/.zshrc && echo 'alias lt="lsd -l --tree"' >> ~/.zshrc

# Install bashtop (provides more info than htop)
git clone https://github.com/aristocratos/bashtop.git /opt/bashtop/
cd /opt/bashtop/
make install && echo 'alias top="bashtop"' >> ~/.zshrc && echo 'alias htop="bashtop"' >> ~/.zshrc

# Install Zsh auto-suggestions tool
git clone https://github.com/zsh-users/zsh-autosuggestions.git /opt/zsh-autosuggestions

# Disable system beeps
rmmod pcspkr && echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf

# Install Docker
apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# Reminder to refresh env and reboot
echo "Recommend to reboot now and, once back up, press tmux prefix+I to ensure tmux plugins are initialized."
