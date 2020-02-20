#!/bin/bash

positive_temps()
{
    cat /dev/shm/weather | sed -n 13p | grep -o '[0-9]\{1,2\}'
}

negative_temps()
{
    cat /dev/shm/weather | sed -n 13p | grep -o '\-[0-9]'
}

rain_chance()
{
    cat /dev/shm/weather | sed -n 16p | grep -o '.[0-9]%'
}

linesplus=$(positive_temps | wc -l)
linesminu=$(negative_temps | wc -l)

echo $linesplus $linesminu
