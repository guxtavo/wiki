#!/bin/bash
# Profile install script
# To execute it:
# bash <(curl -s https://goo.gl/KNNaEX)

echo "setup phase"
mkdir ~/git

echo "installing packages"
sudo zypper install git tmux sensors acpi global strace 

echo "Cloning wiki"
cd ~/git
git clone https://github.com/guxtavo/wiki.git 

echo "Copying config files"
cd ~/git/wiki/profile
cp .bashrc ~/.bashrc && source ~/.bashrc
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
cp .gitconfig ~/.gitconfig

echo "Cloning git repos serially"
cd ~/git
git clone https://github.com/guxtavo/aarav.git 
git clone https://github.com/guxtavo/myscripts.git 
git clone https://github.com/brendangregg/perf-tools.git
git clone https://github.com/funcoeszz/funcoeszz.git 
git clone https://github.com/ryran/xsos.git
git clone https://github.com/openSUSE/obs-build.git 
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
