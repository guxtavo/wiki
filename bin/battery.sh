#!/bin/bash

for battery in /sys/class/power_supply/BAT?
do
    capacity=$(cat "$battery"/capacity) || exit
    status=$(cat "$battery"/status)

    if [ "$status" = "Discharging" ]; then
        echo -n ${capacity}%" |"
    else
        echo -n ${capacity}%" |"
    fi

done
