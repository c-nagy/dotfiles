apt update && apt upgrade -y
apt install tmux zsh htop
chsh -s /usr/bin/zsh root
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
echo "sudo -i" >> /home/ec2-user/.bashrc
source ~/.zshrc
