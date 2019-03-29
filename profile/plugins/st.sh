#!/bin/bash

cpu-hdd_temp()
{
  if [ $SYSTEM = "Linux" ]; then
    # create control file if doesn't exist
    if test ! -e /dev/shm/cpu-hdd_temp
      then touch /dev/shm/cpu-hdd_temp
    fi

    # update the temperatures every minute
    if test "`find /dev/shm/cpu-hdd_temp -mmin +1`"
      then
        B=$(sensors | grep CPU | awk '{print $2}' |  tr -d "+°C" | sed 's/\.0//g')
        C=$(sudo hddtemp /dev/sda| awk '{print $6}' | tr -d "°C")
        echo "$B/$C" > /dev/shm/cpu-hdd_temp
    fi
    echo -n " $(cat /dev/shm/cpu-hdd_temp) |"
  else
    B=$(sysctl hw.sensors.cpu0.temp0 | cut -f1 -d" " | cut -f2 -d"=" | cut -f1 -d".")
    C=$(sysctl hw.sensors.pchtemp0.temp0 | cut -f1 -d" " | cut -f2 -d"=" | cut -f1 -d".")
    echo "$B/$C" > /dev/shm/cpu-hdd_temp
    echo -n " $(cat /dev/shm/cpu-hdd_temp) |"
  fi

}

# shows reconding time, of countdowns or battery status
battery-countdown-recording()
{
  if [ -f /dev/shm/recording ]; then
    CREATED=$(find /dev/shm/recording -printf '%C@\n' | cut -f 1 -d .)
    NOW=$(date +%s)
    DIF=$(( $NOW - $CREATED ))
    MIN=$(( $DIF/60 ))
    SEC=$(( $DIF%60 ))
    if [ $SEC -lt 10 ]; then
      echo -n " $MIN:0$SEC 🔴 |"
    else
      echo -n " $MIN:$SEC 🔴 |"
    fi
  # bug
  # if any file named /dev/shm/countdown.* exist, the alarms should be
  # shown
  fi
  COUNT=$(ls /dev/shm/countdown* | wc -l | awk '{print $1}')
  if [ $COUNT -gt 0 ]; then
    B=$(cat /dev/shm/countdown*)
    MIN=$(( $B/60 ))
    SEC=$(( $B%60 ))
    if [ $SEC -lt 10 ]; then
      echo -n " $MIN:0$SEC |"
    else
      echo -n " $MIN:$SEC |"
    fi
  else
    battery
  fi
}

battery()
{
  # create control file if doesn't exist
  if test ! -e /dev/shm/battery
    then touch /dev/shm/battery
  fi

  # update the battery status every minute
  if test "`find /dev/shm/battery -mmin +1`"
    then
      if [ $SYSTEM = "Linux" ]; then
        acpi -b 0 > /dev/shm/battery
      fi
  fi

  # parse the status
  if $(cat /dev/shm/battery | grep -q Discharging)
    then
      B=$(cat /dev/shm/battery | grep -v "unavai" | awk '{print $5}')
      echo -n " ${B::-3} |"
    else
      B=$(cat /dev/shm/battery | grep -v "unavai" | awk '{print $4}' | tr -d "%,")
      echo -n " $B% |"
  fi
}

weather()
{
  echo -n " $(weather_main) |"
}

dns()
{
  RESOLV="/etc/resolv.conf"
  DNS_SERVER=$(cat $RESOLV | grep nameserver | awk '{print $2}')
  PING_OK="0"
  NSLOOKUP_OK="0"
  ON="D "

  # create control file if doesn't exist
  if test ! -e /dev/shm/dns
    then touch /dev/shm/dns
  fi

  # check of dns_changes is older than 1 minute
  if test "`find /dev/shm/dns -mmin +1`"
    then
      touch /dev/shm/dns
      if ping $DNS_SERVER -c 1 -W 1 -n > /dev/null 2>&1
        then export PING_OK=1
      fi

      if nslookup www.google.com -timeout=1 > /dev/null 2>&1
        then export NSLOOKUP_OK=1
      fi

      if [ $PING_OK = "1" -a $NSLOOKUP_OK = "1" ]
        then
          echo -n $ON > /dev/shm/dns
        else
          echo > /dev/shm/dns
      fi
  fi

  echo -n $(cat /dev/shm/dns)
}

network-status()
{
  if [ $SYSTEM = "Linux" ]; then
    ip link show > /dev/shm/ip_link_show
    echo -n " "
    if $(cat /dev/shm/ip_link_show | grep wlp1s0 | grep LOWER_UP > /dev/null); then
      echo -n "W"
    fi
    if $(cat /dev/shm/ip_link_show | grep tun0 | grep LOWER_UP > /dev/null); then
      echo -n "V"
    fi
    # dns status
    dns
    echo -n "  |"
  fi

  if [ $SYSTEM = "OpenBSD" ]; then
    ifconfig > /dev/shm/ip_link_show
    echo -n " "
    if $(cat /dev/shm/ip_link_show | grep em0 | grep RUNNING > /dev/null); then
      echo -n "E"
    fi
    if $(cat /dev/shm/ip_link_show | grep tun0 | grep RUNNING > /dev/null); then
      echo -n "V"
    fi
    echo -n " |"
  fi
}

# update file with l3ls content
solidground_fix()
{
  ssh l3slave.suse.de l3ls -m  | grep "^\[" | tr -d "[" | while read a b c; do
  echo $a $b
  done > /dev/shm/solidground
}

solidground_fix2()
{
  # trace point
  # set -xv
  OVERLOADED=3
  FILE=/dev/shm/solidground
  SLEEPING=$(cat $FILE | grep sleeping | awk '{print $1}')
  PROCESSED=$(cat $FILE | grep processed | awk '{print $1}')
  ACTIVE=$(cat $FILE | grep active | awk '{print $1}')
  DONE=$(( $PROCESSED + $SLEEPING ))
  if [ $ACTIVE -gt $OVERLOADED ]
    then echo -n "!"
  fi
  echo $ACTIVE/$DONE
}

solidground_progress()
{
  # create control file if doesn't exist
  if test ! -e /dev/shm/solidground
    then touch /dev/shm/solidground
  fi

  if [ $SYSTEM = "Linux" ]; then
    # check vpn connectivity
    if $(ip a | grep tun0 | grep -q UP); then
      # check if progress is older than half hour
      if test "`find /dev/shm/solidground -mmin +15`"
      then
        solidground_fix
      fi
      B=$(solidground_fix2 | tail -1)
      echo -n " $B"
    else
      echo -n " ?"
    fi
  else
	# check vpn connectivity
    if $(ifconfig | grep tun0 | grep -q RUNNING); then
      # check if progress is older than half hour
      if test "`find /dev/shm/solidground -mmin +15`"
      then
        solidground_fix
      fi
      B=$(solidground_fix2 | tail -1)
      echo -n " $B"
    else
      echo -n " ?"
    fi
  fi
}

targets()
{
  # create control file if doesn't exist
  if test ! -e /dev/shm/targets
    then touch /dev/shm/targets
  fi

  # create control file if doesn't exist
  if test ! -e /dev/shm/ptfs
    then touch /dev/shm/ptfs
  fi

  # update the targets every 30 minutes
  if test "`find /dev/shm/targets -mmin +30`"
  then
    touch /dev/shm/targets
    # BUG
    # If VPN is not on, ptfdb will fail
    # positive feedback ptfs
    ~/git/wiki/profile/plugins/ptfs.sh > /dev/shm/ptfs
  fi

  # Commits - FIXME: track PRs/pushes
  A=4
  B=$(cat /dev/shm/ptfs)
  echo -n " $A/$B"
}

run_start()
{
  echo -n " " "| "
}

gimbal()
{
  echo -n "FIT|TC|SVV | "
}

countdown()
{
  # termdown -s '2019-03-31 17:00 CET' --no-text-magic -o /dev/shm/challenge
  echo -n " " $(head -1 /dev/shm/challenge | cut -d ' ' -f1-2) "|"
}

weather_get_the_data()
{
  LOCATION=Brno
  #LOCATION=Prague
  #LOCATION=Nova_iguacu
  curl -m 5 wttr.in/"$LOCATION" | \
    sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" \
    > /dev/shm/weather
}

weather_test_size()
{
  LINES=$(wc -l /dev/shm/weather | awk '{print $1}')
  if [ $LINES -lt 20 ]; then
    B="-----"
  fi
}

weather_format_data()
{
  RAIN_CHANCE=$(cat /dev/shm/weather | sed -n 16p | grep -o .[0-9]% | sort -n | sed '$!d' | tr -d " %")
  if [ $RAIN_CHANCE -gt 0 ]; then
  	echo -n $RAIN_CHANGE"%T"
  fi
  # echo -n $RAIN_CHANCE " "
  # winter and temperatures bellow 0
  #echo -n  $(cat /dev/shm/weather | sed -n 13p | grep -o '\-[0-9]' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"/"$2}')
  # temperatures above 0
  if [ $SYSTEM = "Linux" ]; then
  echo -n  $(sed -n 13p /dev/shm/weather | grep -o '[0-9]\{1,2\}' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"-"$2"."}')
	else
	 RAW=$(sed -n 13p /dev/shm/weather | strings | grep -o 'm[0-9]\{1,2\}')
	 BETTER=$(echo $RAW | tr -d "m" | sort -n | sed -e 1b -e '$!d')
	 ENHANCE=$(echo $BETTER | tr '\n' ' ' | awk '{print $1"/"$2"."}') 
	 echo -n $ENHANCE
	fi
}

weather_main(){

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

  weather_test_size

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
