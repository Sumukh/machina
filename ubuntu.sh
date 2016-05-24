#!/bin/bash
# Setup a personal development server.
# Not intended for production environments.

# Update Apt-Get
sudo apt-get update;
sudo apt-get upgrade;

# Security
# sudo apt-get install fail2ban;
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
sudo apt-get install -y python3 python3-dev python3-setuptools python3-dev
sudo easy_install pip
sudo -H pip install --upgrade virtualenv;
sudo -H pip install httpie
sudo -H pip install howdoi

# Utilities
sudo apt-get install -y vim git-core git-extras
sudo apt-get install -y mosh tmux wget htop
sudo apt-get install -y bash-completion unzip zip

wget -P ~ https://raw.githubusercontent.com/nicolasmccurdy/sane-defaults/master/home/.vimrc
wget -P ~ https://raw.githubusercontent.com/nicolasmccurdy/sane-defaults/master/home/.gitignore
mkdir ~/.vim  ~/.vim/backup ~/.vim/backupf

wget -P ~ https://raw.githubusercontent.com/sumukh/machina/master/aliases.#!/bin/sh

echo "# Load aliases
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi" | sudo tee --append ~/.bashrc
