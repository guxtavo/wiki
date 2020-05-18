#!/bin/bash

if [ ! -f /dev/shm/f9 ]; then
    echo 0 > /dev/shm/f9
fi

state=$(cat /dev/shm/f9)

if [ "$state" -eq 2 ]; then
    tmux set-option -g status on
    tmux set -g status-right '#(~/git/wiki/devkit/shell_wrap.sh) | %H:%M ≡ '
    echo 0 > /dev/shm/f9
fi

if [ "$state" -eq 0 ]; then
    #tmux set-option -g status on
    tmux set -g status-right '#(~/git/wiki/devkit/shell_wrap.sh) | %a W%V %Y-%m-%d %H:%M ≡ '
    echo 1 > /dev/shm/f9
fi

if [ "$state" -eq 1 ]; then
    tmux set-option -g status off
    echo 2 > /dev/shm/f9
fi
