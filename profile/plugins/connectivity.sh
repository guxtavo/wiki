#!/bin/bash
# status watchdog - network, io, sensors

ARCH=$(uname -m)

networkprobe()
{
    R1=$(ping_router)
    R2=$(ping_dns)
    echo "$R1" "$R2" >> /dev/shm/connectivity
}

ioping()
{
    A=$(sudo ioping -c1 /dev/$1)
    B=$(echo $A | head -1 | cut -d " " -f 10-11 | cut -d "=" -f 2)
    echo $B
    # Output example: "1.35 ms"
}

ioprobe()
{
    if [ $ARCH = "armv6l" ]; then
        B=$(ioping mmcblk0p1)
    else
        B=$(ioping sda1)
    fi
    echo $B >> /dev/shm/ioprobe

    diskspace=$(df -h / | tail -1 | awk '{print $4}')
    echo $diskspace >> /dev/shm/diskspace
}

temperatures()
{
    if [ $ARCH = "armv6l" ]; then
        temp=$(sudo vcgencmd measure_temp | cut -f 2 -d "=" | cut -f 1 -d .)
        echo "$temp" >> /dev/shm/cpu-hdd_temp
    else
        tempcpu=$(sensors | grep CPU | awk '{print $2}' |  tr -d "+°C" | sed 's/\.0//g')
        temphd=$(sudo hddtemp /dev/sda| awk '{print $6}' | tr -d "°C")
        #D=$(isabove50 $B)
        echo "$tempcpu/$temphd" >> /dev/shm/cpu-hdd_temp
    fi

}

function main()
{
    while true; do
        networkprobe
        ioprobe
        temperatures
        sleep 15
    done
}

main
