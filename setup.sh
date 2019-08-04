apt update && apt upgrade -y
apt install tmux zsh
chsh -s /usr/bin/zsh root
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
