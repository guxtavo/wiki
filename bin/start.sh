#!/bin/bash


if [ ! -f /dev/shm/start ]; then
    echo disabled > /dev/shm/start
fi

disable()
{
    #start-led &
    tmux last-window
    tmux set-option -g status on
    echo disabled > /dev/shm/start
    tmux kill-window -t HELM:99
}


enable()
{
    #start-led &
    echo enabled > /dev/shm/start
    play -q ~/git/wiki/devkit/resources/temple.wav &
    tmux set-option -g status off
    tmux new-window -t HELM:99 -n 'start'
    tmux select-window -t HELM:99
    tmux split-window -h
    tmux send-keys "less ~/git/wiki/idx.md" C-m
    tmux split-window -v
    tmux send-keys "tail -50 ~/git/wiki/cal.md" C-m
    tmux select-pane -t 0
    tmux send-keys "less ~/git/wiki/nws.md" C-m
    tmux split-window -v
    tmux send-keys "tail -50 ~/git/wiki/trc.db" C-m
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
