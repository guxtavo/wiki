#!/bin/bash

COLUMNS=$(( $(stty size | awk '{print $2}') / 80 ))
SPLITS=$(( $COLUMNS - 1 ))
SYSTEM=$(uname -s)

if [ $SYSTEM = "Linux" ];then
	export SEQ=seq
else
	export SEQ=jot
fi

for i in `$SEQ $SPLITS`
do
  tmux split-window -h
done
#tmux next-layout
tmux select-layout even-horizontal
