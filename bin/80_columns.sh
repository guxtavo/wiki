#!/bin/bash

COLUMNS=$(( $(stty size | awk '{print $2}') / 80 ))
SPLITS=$(( $COLUMNS - 1 ))

for i in `seq $SPLITS`
do
  tmux split-window -h
done
tmux next-layout
