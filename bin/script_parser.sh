#!/bin/bash
# https://www.fesliyanstudios.com/royalty-free-sound-effects-download/keyboard-typing-6
# TODO lower sample rate and bit depth,  stereo to mono
KB4SEC=$HOME"/git/wiki/devkit/resources/4sec.wav"
KB8SEC=$HOME"/git/wiki/devkit/resources/8sec.wav"
start_script()
{
    file="$1"
    while read -r a b; do
        chars="${#b}"
        seconds="$(( chars / 5 ))"
        sleep "$a"
        #echo $seconds
        if [ "$seconds" -gt 4 ]; then
            aplay --duration="$seconds" "$KB8SEC" -q &
        else
            aplay --duration="$seconds" "$KB4SEC" -q &
        fi
        sleep 1
        for (( i=0; i<${#b}; i++ )); do
            echo -n "${b:$i:1}"
            rand=$(( (RANDOM %10 ) +1 ))
            sleep 0.1"$rand"
        done
    echo
    done < "$file"
}
start_script "$1"
