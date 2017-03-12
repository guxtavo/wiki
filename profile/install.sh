#!/bin/bash
#
# setup phase
#sudo zypper install git tmux
#mkdir ~/git && cd ~/git
#git clone https://github.com/guxtavo/wiki.git
#~/git/wiki/profile/install.sh

# copying and sourcing
cd ~/git/wiki/profile
cp .bashrc ~/.bashrc && source ~/.bashrc
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf

# git cloning
cd ~/git
git clone https://github.com/guxtavo/aarav.git 
git clone https://github.com/guxtavo/myscripts.git 
git clone https://github.com/brendangregg/perf-tools.git
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
