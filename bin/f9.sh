#!/bin/bash

if [ ! -f /dev/shm/f9 ]; then
    echo 0 > /dev/shm/f9
fi

state=$(cat /dev/shm/f9)

# decision matrix
# off -> basic
# basic -> complete
# complete -> minimal
# minimal -> off

# 2 means off
if [ "$state" -eq 2 ]; then
    tmux set-option -g status on
    tmux set -g status-right '#(~/git/wiki/devkit/shell_wrap.sh) | %H:%M ≡ '
    # 0 means basic
    echo 0 > /dev/shm/f9
fi

# 0 means basic
if [ "$state" -eq 0 ]; then
    # 1 means complete
    tmux set -g status-right '#(~/git/wiki/devkit/shell_wrap.sh) | %a W%V %Y-%m-%d %H:%M ≡ '
    echo 1 > /dev/shm/f9
fi

# 1 means complete
if [ "$state" -eq 1 ]; then
    # 3 means minimal
    tmux set -g status-right '#(~/git/wiki/devkit/shell_wrap.sh) ≡ '
    echo 3 > /dev/shm/f9
fi

# 3 means minimal
if [ "$state" -eq 3 ]; then
    tmux set-option -g status off
    # 2 means all off
    echo 2 > /dev/shm/f9
fi
