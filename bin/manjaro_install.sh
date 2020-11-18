#!/bin/bash

mkdir ~/bin
mkdir ~/tmp
mkdir ~/git

cd ~/git
git clone https://github.com/guxtavo/wiki

ln -s ~/git/wiki/bin ~/bin/wiki

cp ~/git/wiki/devkit/dotfiles/.linux.sh ~/
cp ~/git/wiki/devkit/dotfiles/.common.sh ~/
cp ~/git/wiki/devkit/dotfiles/.tmux.conf ~/
cp ~/git/wiki/devkit/dotfiles/.vimrc ~/
cp ~/git/wiki/devkit/dotfiles/.mutt* ~/
# .ssh
# .password-store
# .gnupg

pacman -S ioping calcurse fortune-mod openvpn irssi mutt pass dnsmasq tcpdump
