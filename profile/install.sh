#!/bin/bash

echo "Installing packages"
sudo zypper install git tmux sensors acpi global strace

echo "Cloning wiki"
cd ~/git && git clone https://github.com/guxtavo/wiki.git

echo "Copying dotfiles"
cd ~/git/wiki/profile/dotfiles
cp .* ~/
source ~/.bashrc
