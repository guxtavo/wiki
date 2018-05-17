#!/bin/bash

sdi()
{
  # display profile
  #  - 42x174 chars (40 lines in vi)
  #  - 14"  display
  # new session
  SESSION=L3
  tmux new-session -d -s $SESSION

  # FLIGHT
  tmux rename-window -t $SESSION:1 '✈️ '
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "journal" C-m
  tmux select-pane -t 1
  tmux send-keys "l3_feed" C-m
  tmux split-window -v
  tmux select-pane -t 2
  tmux resize-pane -D 40
  tmux send-keys "suse" C-m

  # CAPCOM
  tmux new-window -t $SESSION:2 -n '⛑️ '
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "irssi" C-m
  tmux select-pane -t 1
  tmux send-keys "mutt" C-m

  # FDO
  tmux new-window -t $SESSION:3 -n 'FDO🚀'
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "vi git/wiki/hawk1ng.md" C-m
  tmux select-pane -t 1
  tmux send-keys "pes" C-m
  tmux split-window -v
  tmux select-pane -t 2
  tmux send-keys "ptf" C-m

  # GPO
  tmux new-window -t $SESSION:4 -n 'GPO🌎'
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "vi git/wiki/mission_control.wiki" C-m
  tmux select-pane -t 1
  tmux send-keys "bug_review -s" C-m

  # Other windows
  tmux new-window -t $SESSION:4 -n 'GPO🌎' 'vi ~/git/wiki/mission_control.wiki'
  tmux new-window -t $SESSION:5 -n 'DPS🤖' 'man git-format-patch'
  tmux new-window -t $SESSION:6 -n 'Surgeon⚕️ ' 'vi git/wiki/wok.txt'
  tmux new-window -t $SESSION:7 -n 'Booster🔼' 'vi git/wiki/Zero512.md'
  tmux new-window -t $SESSION:8 -n 'PDRS📦' 'vi git/wiki/EVA_trainner.md'

  # Finishing up
  tmux select-window -t $SESSION:1
  tmux attach-session -t $SESSION
}

usek8s()
{
  SESSION=usek8s
  tmux new-session -d -s $SESSION

  # FLIGHT
  tmux rename-window -t $SESSION:1 '✈️ '
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "dmesg --level err" C-m
  tmux select-pane -t 1
  tmux send-keys "vi ~/git/wiki/profile/status-right-tumbleweed.sh" C-m

  # CAPCOM
  tmux new-window -t $SESSION:2 -n '⛑️ '
  tmux split-window -h
  tmux select-pane -t 0
  # tmux send-keys "ps axmsr" C-m
  tmux send-keys "ps aux | sort -k 10 | head" C-m
  tmux select-pane -t 1
  tmux send-keys "kubectl get pods -a | awk '{(if $5 != Ready) print}'" C-m
}

sgs()
{
  SESSION=SGS
  tmux new-session -d -s $SESSION

  # FLIGHT
  tmux rename-window -t $SESSION:1 '✈️ '
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "journal" C-m
  tmux select-pane -t 1
  tmux send-keys "vi ~/git/wiki/profile/status-right-tumbleweed.sh" C-m

  # CAPCOM
  tmux new-window -t $SESSION:2 -n '⛑️ '
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "vi ~/git/wiki/hawk1ng.md" C-m
  tmux select-pane -t 1
  tmux send-keys "vi ~/git/wiki/Zero512.md" C-m

  # FDO
  tmux new-window -t $SESSION:3 -n 'FDO🚀'
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "vi ~/git/wiki/wok.txt" C-m
  tmux select-pane -t 1
  tmux send-keys "vi ~/git/wiki/EVA_trainner.md" C-m

  # GPO
  tmux new-window -t $SESSION:4 -n 'GPO🌎'
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "vi ~/git/wiki/afh_epub/*" C-m
  tmux select-pane -t 1
  tmux send-keys "vi ~/git/wiki/to_sum_up-capcom.txt" C-m
}

sdi
