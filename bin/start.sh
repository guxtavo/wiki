#!/bin/bash


if [ ! -f /dev/shm/start ]; then
    touch /dev/shm/start
fi

disable()
{
    tmux last-window
    tmux set-option -g status on
    echo disabled > /dev/shm/start
    tmux kill-window -t HELM:99
}


enable()
{
    echo enabled > /dev/shm/start
    tmux set-option -g status off
    tmux new-window -t HELM:99 -n 'start'
    tmux select-window -t HELM:99
    tmux split-window -h
    tmux send-keys "less ~/git/wiki/index.md" C-m
    tmux select-pane -t 0
    tmux send-keys "less ~/git/wiki/1-feedback.md" C-m
}

check_status()
{
    cat /dev/shm/start
}

toggle()
{
    status=$(check_status)

    if [ "$status" == "enabled" ]; then
        disable
    fi

    if [ "$status" == "disabled" ]; then
        enable
    fi
}

toggle
