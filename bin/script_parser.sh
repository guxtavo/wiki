#!/bin/bash
# https://www.fesliyanstudios.com/royalty-free-sound-effects-download/keyboard-typing-6
start_script()
{
    file="$1"
    while read -r a b; do
        container=$(echo "$b")
        chars="${#container}"
        seconds="$(( chars / 6 ))"
        sleep "$a"
        echo $seconds
        if [ "$seconds" -gt 4 ]; then
            aplay --duration="$seconds" ~/tmp/o2.wav -q &
        else
            aplay --duration="$seconds" ~/tmp/o.wav -q &
        fi
        for (( i=0; i<${#container}; i++ )); do
            echo -n "${container:$i:1}"
            sleep 0.1
        done
    echo
    done < "$file"
}
start_script "$1"
