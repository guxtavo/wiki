#!/bin/bash
#
# setup phase
#sudo zypper install git tmux
#mkdir ~/git && cd ~/git
#git clone https://github.com/guxtavo/wiki.git
#~/git/wiki/profile/install.sh

# copying and sourcing
echo "Copying config files"
cd ~/git/wiki/profile
cp .bashrc ~/.bashrc && source ~/.bashrc
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
cp .gitconfig ~/.gitconfig

# git cloning
echo "Cloning git repos serially"
cd ~/git
git clone https://github.com/guxtavo/aarav.git 
git clone https://github.com/guxtavo/myscripts.git 
git clone https://github.com/brendangregg/perf-tools.git
git clone https://github.com/funcoeszz/funcoeszz.git 
git clone https://github.com/ryran/xsos.git
git clone https://github.com/openSUSE/obs-build.git 
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
