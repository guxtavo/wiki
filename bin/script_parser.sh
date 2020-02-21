#!/bin/bash
# https://www.fesliyanstudios.com/royalty-free-sound-effects-download/keyboard-typing-6
# TODO lower sample rate and bit depth
# TODO find suitable sound

SOUND="0"
KB4SEC=$HOME"/git/wiki/devkit/resources/4sec.wav"
KB8SEC=$HOME"/git/wiki/devkit/resources/8sec.wav"

sounds()
{
    if [ "$SOUND" -eq 1 ]; then
        if [ "$1" -gt 4 ]; then
            aplay --duration="$1" "$KB8SEC" -q &
        else
            aplay --duration="$1" "$KB4SEC" -q &
        fi
    fi
}

play()
{
    file="$1"
    while read -r a b; do
        chars="${#b}"
        seconds="$(( chars / 5 ))"
        sleep "$a"
        sounds $seconds
        sleep 1
        for (( i=0; i<${#b}; i++ )); do
            echo -n "${b:$i:1}"
            rand=$(( (RANDOM %10 ) +1 ))
            sleep 0.0"$rand"
        done
    echo
    done < "$file"
}

play "$1"
