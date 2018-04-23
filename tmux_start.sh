# tmux L3
tmux_l3()
{
# display profile
#  - 42x174 chars (40 lines in vi)
#  - 14"  display
# new session
    SESSION=L3
        tmux new-session -d -s $SESSION

# FLIGHT
        tmux rename-window -t $SESSION:1 'FLIGHT'
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
        tmux new-window -t $SESSION:2 -n 'CAPCOM'
        tmux split-window -h
        tmux select-pane -t 0
        tmux send-keys "irssi" C-m
        tmux select-pane -t 1
        tmux send-keys "mutt" C-m

# FDO
        tmux new-window -t $SESSION:3 -n 'FDO'
        tmux split-window -h
        tmux select-pane -t 0
        tmux send-keys "cd ~/git/linux-stable; git log"
        tmux select-pane -t 1
        tmux send-keys "pes" C-m
        tmux split-window -v
        tmux select-pane -t 2
        tmux send-keys "ptf" C-m

# Other windows
        tmux new-window -t $SESSION:4 -n 'GPO' 'vi ~/git/wiki/mission_control.wiki'
        tmux new-window -t $SESSION:5 -n 'DPS' 'man git pull'
        tmux new-window -t $SESSION:6 -n 'Surgeon' 'vi git/wiki/journal.txt'
        tmux new-window -t $SESSION:7 -n 'Booster' 'vi git/wiki/hawk1ng.wiki'
        tmux new-window -t $SESSION:8 -n 'PDRS'

# Finishing up
        tmux select-window -t $SESSION:1
        tmux attach-session -t $SESSION
}

bz_setup()
{
# ts -b 1085253
# Fix me: create markdown file for bug if it doesn't exist
# Fix me: create download directory if it doesn exist
# Fix me: download bz attachments
        tmux new-window -t $SESSION -n $bz
        tmux split-window -h
        tmux select-pane -t 0
        tmux send-keys "vi ~/git/suse/L3/${bz}*" C-m
        tmux select-pane -t 1
        tmux send-keys "bzg -b $bz" C-m
}
# tmux usek8s
# tmux send-keys "dmesg --level err" C-m
# tmux send-keys "ps axmsr" C-m
# tmux send-keys "ps aux | sort -k 10 | head" C-m
# tmux send-keys "kubectl get pods -a | awk '{(if $5 != "Ready") print}'

tmux_l3
