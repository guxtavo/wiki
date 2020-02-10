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

weather_format_data()
{
    # here we are sure the file exists from a sucessful run of
    # weather_get_the_data
    # Calculate and display rain chance if exists
    RAIN=$(cat /dev/shm/weather \
              | sed -n 16p | grep -o .[0-9]% | sort -n \
              | sed '$!d' | tr -d " %")
    if [ ! -z $RAIN ] ; then
        if [ $RAIN -gt 0 ]; then
            echo -n $RAIN"%${RAIN}T "
        fi
    fi

    MONTH=$(date +%m)
    # if we are between december and february
    if [ $MONTH -eq 12 ] || [ $MONTH -le 2 ] ; then
        if [ $SYSTEM = "Linux" ]; then
            TEMP_STEP1=$(cat /dev/shm/weather | sed -n 13p \
                         | grep -o '\-[0-9]' \
                         | sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' \
                         | awk '{print $1"/"$2}')
            echo $TEMP_STEP1 >> /dev/shm/weather_final
        else
            RAW=$(sed -n 13p /dev/shm/weather | strings | grep -o 'm[0-9]\{1,2\}')
            BETTER=$(echo $RAW | tr -d "m" | perl -pe 's/ /\n/g' | sort -n | sed -e 1b -e '$!d')
            ENHANCE=$(echo $BETTER | tr '\n' ' ' | awk '{print $1"-"$2"."}')
            echo $ENHANCE >> /dev/shm/weather_final
        fi
    else
        echo -n positive >> /dev/shm/weather_final
    fi
}

weather_get_the_data()
{
    # Curl the data or fail
    LOCATION=Brno
    #LOCATION=Prague
    #LOCATION=Nova_iguacu
    curl -m 2 -s wttr.in/"$LOCATION" | \
      sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" \
      > /dev/shm/weather 2>/dev/null
    if [ $? -gt 0 ] ; then
        echo "N/A" > /dev/shm/weather_final
    else
        weather_format_data
    fi
}


check_expired_data()
{
    # fetch data if files is 30 minutes old
    if test "`find /dev/shm/weather -mmin +30`"
    then
        weather_get_the_data
    fi
}

populate()
{
    # Populate the file with N/A if it doesn't exist
    if [ ! -f /dev/shm/weather ] ; then
        echo "N/A" > /dev/shm/weather
        echo "N/A" > /dev/shm/weather_final
    fi
}

checkforNA()
{
    # BUG: if this file is empty, we get an error: unary operator expected
    if [ $(head -1 /dev/shm/weather | sed 's/.//4g') = "N/A" ] ; then
        weather_get_the_data
    fi
}

# TODO: the script should cool down in case weather_get_the_data keeps failing

# timer()
# {
#     # 15 sec - initialize
#     # 15 sec - check for N/A
#     # 30 min - download expired data
# }

weather_main()
{
    populate
    checkforNA # will call weather_get_the_data if N/A
    check_expired_data # might call weather_get_the_data
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
