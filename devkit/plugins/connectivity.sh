#!/bin/bash
# status watchdog - network, io, sensors

ARCH=$(uname -m)

calendar()
{
    A=$(calendar-wrapper.sh)
    echo "$A" > /dev/shm/calendar
}

networkprobe()
{
    R1=$(ping_router)
    #R2=$(ping_dns)
    echo "$R1" >> /dev/shm/connectivity
}

ioping()
{
    A=$(sudo ioping -B -c1 /dev/$1)
    B=$(echo $A |  cut -d " " -f 10)
    mili=$(echo "scale=2; $B/1000000" | bc)
    echo $mili
    # Output example: "1.35 ms"
}

ioprobe()
{
    if [ $ARCH = "armv7l" ] || [ "$ARCH" = "aarch64" ]; then
        B=$(ioping mmcblk0p1)
    else
        B=$(ioping sda1)
    fi

    if [ ${B:0:1} = "." ]; then
        echo 0${B}ms >> /dev/shm/ioprobe
    else
        echo ${B}ms >> /dev/shm/ioprobe
    fi

    diskspace=$(df -BG / | tail -1 | awk '{print $4}')
    echo $diskspace >> /dev/shm/diskspace
}

temperatures()
{
    if [ $ARCH = "armv7l" ] || [ "$ARCH" = "aarch64" ]  ; then
        temp=$(vcgencmd measure_temp | cut -f 2 -d "=" | cut -f 1 -d .)
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
    curl -m 2 -s wttr.in/"$LOCATION"?format="%f+%p\n" > \
        /dev/shm/weather_final 2>/dev/null

    if [ $? -gt 0 ] ; then
        # curl cannot fetch
        echo "N/A" >> /dev/shm/weather_final
    fi

    first=$(tail -1 /dev/shm/weather_final | cut -b 1)

    if [ -z $first ]; then
        #null data
        echo "NULL" > /dev/shm/weather_final
    fi

    if [ "$first" != "+" ] && [ "$first" != "-" ]; then
        # response most be wrong
        echo "ERR" > /dev/shm/weather_final
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
        #calendar
        sleep 15
    done
}

main
