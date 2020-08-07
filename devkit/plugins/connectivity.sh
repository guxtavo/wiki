#!/bin/bash
# status watchdog - network, io, sensors

ARCH=$(uname -m)

networkprobe()
{
    R1=$(ping_router)
    #R2=$(ping_dns)
    echo "$R1" >> /dev/shm/connectivity
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
        temphdd=$(sudo hddtemp /dev/sda| awk '{print $6}' | tr -d "°C")
        #D=$(isabove50 $B)
        echo "$tempcpu" >> /dev/shm/cpu_temp
        echo "$temphdd" >> /dev/shm/hdd_temp
    fi
}

weather_get_the_data()
{
    LOCATION=Brno
    curl -m 2 -s wttr.in/"$LOCATION"?format="%f+%p+%w\n" > \
        /dev/shm/weather_final 2>/dev/null

    if [ $? -gt 0 ] ; then
        echo "N/A" > /dev/shm/weather_final
    fi
}

check_expired_data()
{
    if test "`find /dev/shm/weather_final -mmin +30`"
    then
        weather_get_the_data
    fi
}

populate()
{
    # Populate the file with N/A if it doesn't exist
    if [ ! -f /dev/shm/weather_final ] ; then
        weather_get_the_data
    fi
}

weather_main()
{
    populate
    check_expired_data
}

cpu_freq()
{
    A=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
    echo $A > /dev/shm/cpu_probe
}

hogs()
{
    A=$(hogs.sh)
    if [ ! -z $A ]; then
        echo $A > /dev/shm/hogs
    else
        echo empty > /dev/shm/hogs
    fi
}

function main()
{
    while true; do
        networkprobe
        ioprobe
        temperatures
        cpu_freq
        weather_main
        hogs
        sleep 15
    done
}

main
