#!/bin/bash
# status watchdog - network, io, sensors

ARCH=$(uname -m)
SYSTEM=$(uname -s)

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

weather_get_the_data()
{
    LOCATION=Brno
    #LOCATION=Prague
    #LOCATION=Nova_iguacu
    curl -m 2 wttr.in/"$LOCATION" | \
      sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" \
      > /dev/shm/weather
}

weather_format_data()
{
    # Calculate and display rain chance if exists
    CONTENT=$(cat /dev/shm/weather \
              | sed -n 16p | grep -o .[0-9]% | sort -n \
              | sed '$!d' | tr -d " %")
    if [ ! -z $CONTENT ] ; then
        if [ $CONTENT -gt 0 ]; then
            echo -n $CONTENT"%${CONTENT}T "
        fi
    fi

    # winter and temperatures bellow 0
    #echo -n  $(cat /dev/shm/weather | sed -n 13p | grep -o '\-[0-9]' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"/"$2}')
    # temperatures above 0
    if [ $SYSTEM = "Linux" ]; then
        # if we are december 1st until february 28
        TEMP_STEP1=$(cat /dev/shm/weather | sed -n 13p | grep -o '\-[0-9]' \
                     |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' \
                     | awk '{print $1"/"$2}')
        # elseif we are between march 1st and november 30
        #echo -n  $(sed -n 13p /dev/shm/weather | grep -o '[0-9]\{1,2\}' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"-"$2"."}')
        echo $TEMP_STEP1 >> /dev/shm/weather_final
    else
        RAW=$(sed -n 13p /dev/shm/weather | strings | grep -o 'm[0-9]\{1,2\}')
        BETTER=$(echo $RAW | tr -d "m" | perl -pe 's/ /\n/g' | sort -n | sed -e 1b -e '$!d')
        ENHANCE=$(echo $BETTER | tr '\n' ' ' | awk '{print $1"-"$2"."}')
        echo $ENHANCE >> /dev/shm/weather_final
    fi
}

weather_main()
{
    # fetch data if files is 30 minutes old
    if test "`find /dev/shm/weather -mmin +30`"
    then
      weather_get_the_data
    fi

    # if the file is empty, try again to fetch the data
    if test ! -s /dev/shm/weather
    then
      weather_get_the_data
    fi

    # weather_test_size

    # check size of the file before setting the variables
    if [ $(cat /dev/shm/weather | wc -l) -lt 20 ]; then
      B="-----"
      # retry in less time
      if test "`find /dev/shm/weather -mmin +5`"
      then
        weather_get_the_data
      fi
    else
      weather_format_data
    fi
}


function main()
{
    while true; do
        networkprobe
        ioprobe
        temperatures
        weather_main
        sleep 15
    done
}

main
