#!/bin/bash

ID=$(cat /etc/os-release | grep ^ID= | cut -f 2 -d =)

defaultwm()
{
    echo "exec i3" > ~/.Xsession
}

dotfiles()
{
    echo "Copying dotfiles"
    cp dotfiles/.bashrc.sh ~/
    cp dotfiles/.common.sh ~/
    cp dotfiles/.linux.sh ~/
    cp dotfiles/.tmux.conf ~/
    cp dotfiles/.vimrc ~/
    cp dotfiles/.i3status.conf ~/
    cp dotfiles/.aspell* ~/
}

install_raspbian()
{
    echo "Installing packages"
    sudo apt install tmux strace ioping fortune ffmpeg w3m vim-runtime i3 \
                     aspell
    dotfiles
    defaultwm
}

install_opensuse()
{
    echo "Installing packages"
    sudo zypper install tmux strace ioping fortune ffmpeg w3m i3 \
                        sensors acpi aspell

    dotfiles
}

if [ $ID = "raspbian" ]; then
    install_raspbian
else
    install_opensuse
fi

source ~/.bashrc
