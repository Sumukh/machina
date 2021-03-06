#!/bin/bash
# Setup a personal development server.

# Update Apt-Get
sudo apt-get update;
sudo apt-get -y upgrade;

# Security
sudo apt-get install -y fail2ban;
# Automatic Security Updates  (Optional) 
# sudo apt-get install unattended-upgrades
# echo 'APT::Periodic::Update-Package-Lists "1";
# APT::Periodic::Download-Upgradeable-Packages "1";
# APT::Periodic::AutocleanInterval "7";
# APT::Periodic::Unattended-Upgrade "1";' | sudo tee /etc/apt/apt.conf.d/10periodic

# Packages
sudo apt-get install -y build-essential

# Python
sudo apt-get install -y python python-setuptools python-dev
sudo apt-get install -y python3 python3-dev python3-setuptools python3-dev python3-pip
sudo -H pip3 install --upgrade virtualenv;
sudo -H pip3 install httpie requests

# Utilities
sudo apt-get install -y vim git-core git-extras
sudo apt-get install -y mosh tmux wget htop curl
sudo apt-get install -y bash-completion unzip zip

wget -P ~ -nc https://raw.githubusercontent.com/nicolasmccurdy/sane-defaults/master/home/.vimrc
wget -P ~ -nc https://raw.githubusercontent.com/nicolasmccurdy/sane-defaults/master/home/.gitignore
mkdir ~/.vim  ~/.vim/backup ~/.vim/backupf

wget -P ~ -nc https://raw.githubusercontent.com/sumukh/machina/master/ubuntu/aliases.sh -O .aliases

echo "# Load aliases
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi" | sudo tee --append ~/.bashrc
