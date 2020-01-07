#!/bin/bash

RESULT=$(/home/gfigueira/git/wiki/profile/shell.sh)
SLEEP=5
LINE=$(tput lines)
LINES=$(( $LINE + 1 ))

# mimic the behaviour of i3status
# i3status will output one line, wait, and just output in the same line over
# and over

while true; do
#    tput cup 0 0
    echo $RESULT
    sleep $SLEEP
    RESULT=$(/home/gfigueira/git/wiki/profile/shell.sh)
done



