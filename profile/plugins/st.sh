#!/bin/bash

ARCH=$(uname -m)

isabove50()
{
    if [ $1 -ge 50 ]; then
        tmux display-message "CPU temp above 50C"
        echo "!$1"
    else
        echo $1
    fi
}

cpu-hdd_temp()
{
  if [ $SYSTEM = "Linux" ]; then
    # create control file if doesn't exist
    if test ! -e /dev/shm/cpu-hdd_temp
      then touch /dev/shm/cpu-hdd_temp
    fi

    temp=$(tail -1 /dev/shm/cpu-hdd_temp)
    diskspace=$(tail -1 /dev/shm/diskspace)
    ioping=$(tail -1 /dev/shm/ioprobe)
    echo -n " ${temp}c $diskspace $ioping |"
    isrecording
  else
    B=$(sysctl hw.sensors.cpu0.temp0 | cut -f1 -d" " | cut -f2 -d"=" | cut -f1 -d".")
    C=$(sysctl hw.sensors.pchtemp0.temp0 | cut -f1 -d" " | cut -f2 -d"=" | cut -f1 -d".")
    echo "$B/$C" > /dev/shm/cpu-hdd_temp
    echo -n " $(cat /dev/shm/cpu-hdd_temp)c |"
  fi
}

isrecording()
{
  if [ -f /tmp/recording ]; then
    CREATED=$(find /tmp/recording -printf '%C@\n' | cut -f 1 -d .)
    NOW=$(date +%s)
    DIF=$(( $NOW - $CREATED ))
    MIN=$(( $DIF/60 ))
    SEC=$(( $DIF%60 ))
    if [ $SEC -lt 10 ]; then
      echo -n " SCREENCASTING $MIN:0$SEC |"
    else
      echo -n " SCREENCASTING $MIN:$SEC |"
    fi
  fi
}

# shows reconding time, of countdowns or battery status
battery-countdown-recording()
{
    isrecording
    COUNT=$(ls /dev/shm/countdown* 2>/dev/null| wc -l | awk '{print $1}')
    if [ -z $COUNT ] ; then
        COUNT=0
    fi
    if [ $COUNT -gt 0 ]; then
      # show how many countdowns are running
  	echo -n " $COUNT "
  	NEXT=$(( ( RANDOM % $COUNT ) + 1 ))
  	ID_NEXT=$(ls /dev/shm/countdown.* | sed -n ${NEXT}p | cut -f2 -d".")
  	echo $ID_NEXT > /dev/shm/cd-last
  	ID=$(cat /dev/shm/cd-last)
     	B=$(cat /dev/shm/countdown.$ID)
        MIN=$(( $B/60 ))
      SEC=$(( $B%60 ))
      if [ $SEC -lt 10 ]; then
        echo -n " $MIN:0$SEC $ID |"
      else
        echo -n " $MIN:$SEC $ID |"
      fi
    else
      battery
    fi
}

battery()
{
  if [ $SYSTEM = "Linux" ]; then
    # create control file if doesn't exist
    if test ! -e /dev/shm/battery
      then touch /dev/shm/battery
    fi

    # update the battery status every minute
    if test "`find /dev/shm/battery -mmin +1`"
	   then acpi -b 0 > /dev/shm/battery
    fi

	if $(cat /dev/shm/battery | grep -q Discharging)
      then
        B=$(cat /dev/shm/battery | grep -v "unavai" | awk '{print $5}')
        echo -n " ${B::-3} |"
      else
        B=$(cat /dev/shm/battery | grep -v "unavai" | awk '{print $4}' | tr -d "%,")
        echo -n " $B% |"
    fi
  else
     B=$(sysctl | grep cpuspeed | cut -d "=" -f 2)
	 echo -n " $B |"
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
    # show the contents of the nmcli plugin

    # (0) ~ $ time git/wiki/profile/plugins/nmcli.sh
    # ▂▄▆█
    # real    0m0.216s
    # user    0m0.132s
    # sys     0m0.059s

  if [ $SYSTEM = "Linux" ]; then
    # BUG - if SSID has two words, signal strengh is shown 
    #B=$(~/git/wiki/profile/plugins/nmcli.sh)
    B=$( tail -1 /dev/shm/connectivity  | tr -d " ")
    echo -n " $B"

    # connectivity watchdog will write fo a file
    # (0) ~ $ tail -1 /dev/shm/connectivity
    # 0 0 0 0 0

    # you must read this file and arbitrate the status

    #STATUS=$(tail -1 /dev/shm/connectivity)
    # BUG - at home I have only 1 DNS
    # 0 0 -> at home, all good, vpn disconnected
    # Connected but no VPN
    # ▂▄▆█■
    #if [ "$STATUS" = "0 0 " ]; then
    #    echo -n "■"
    #fi

    # Connected even to the vpn
    # 0 0 0 0 0 -> all good
    echo -n " |"

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
  ssh -o connecttimeout=2 l3slave.suse.de l3ls -m  \
  | grep "^\[" | tr -d "[" | while read a b c; do
  echo $a $b
  done > /dev/shm/solidground

  BZ="https://bugzilla.suse.com"
  BZST=$(curl -m 5 -sIL $BZ | grep HTTP | tail -1 | cut -d " " -f 2)
  echo $BZST > /dev/shm/bugzilla_http_status
}

# should rename to display_targets()
display_targets()
{
  # trace point
  # set -xv
  OVERLOADED=3
  FILE=/dev/shm/solidground
  SLEEPING=$(cat $FILE | grep sleeping | awk '{print $1}')
  if [ -z $SLEEPING ]; then
    SLEEPING=0
  else
    if [ $SLEEPING -gt 0 ]; then
        echo ok >/dev/null
    else
        SLEEPING=0
    fi 
  fi
  PROCESSED=$(cat $FILE | grep processed | awk '{print $1}')
  ACTIVE=$(cat $FILE | grep active | awk '{print $1}')
  DONE=$(( $PROCESSED + $SLEEPING ))
  BZST=$(cat /dev/shm/bugzilla_http_status)
  SPECIAL="tooling"

  echo -n "["$BZST"] $SPECIAL '*' "

  if [ -z $ACTIVE ]; then
    ACTIVE=0
  else
  if [ $ACTIVE -gt $OVERLOADED ]
    then echo -n "!"
  fi
  fi


  echo -n $ACTIVE/$DONE
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
      B=$(display_targets | tail -1)
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
      B=$(display_targets | tail -1)
      echo -n " $B"
    else
      echo -n " AWAY |"
	  export AWAY="Y"
    fi
  fi
}

targets()
{
  #GITLAB="https://gitlab.suse.de/gfigueir.atom?feed_token=26rq5ZPRvrhci2NsSFQ1"
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
    # BUG: If VPN is not on, ptfdb will fail
    # BUG: rss feed on gitlab no reliable -> use git log on repos locally
    ~/git/wiki/profile/plugins/ptfs.sh > /dev/shm/ptfs
	#w3m -dump $GITLAB | grep "<title>gfigueir" > /dev/shm/PR
  fi

  if [ -z $AWAY ]; then
    AWAY=N
  fi 
  if [ $AWAY = "Y" ]; then
    echo -n "AWAY |" > /dev/null
  else
    # Commits - FIXME: track PRs/pushes
    #A=$(wc -l /dev/shm/PR | awk '{print $1}')
    B=$(cat /dev/shm/ptfs)
    echo -n " $B"
  fi

}

run_start()
{
  echo -n " " "| "
}

gimbal()
{
  echo -n "FIT|ARF|SVV | "
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
  	echo -n $RAIN_CHANGE"%${RAIN_CHANCE}T "
  fi
  # echo -n $RAIN_CHANCE " "
  # winter and temperatures bellow 0
  #echo -n  $(cat /dev/shm/weather | sed -n 13p | grep -o '\-[0-9]' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"/"$2}')
  # temperatures above 0
  if [ $SYSTEM = "Linux" ]; then
    # if we are december 1st until february 28
  echo -n  $(cat /dev/shm/weather | sed -n 13p | grep -o '\-[0-9]' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"/"$2}')
    # elseif we are between march 1st and november 30
    #echo -n  $(sed -n 13p /dev/shm/weather | grep -o '[0-9]\{1,2\}' |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"-"$2"."}')
	else
	 RAW=$(sed -n 13p /dev/shm/weather | strings | grep -o 'm[0-9]\{1,2\}')
	 BETTER=$(echo $RAW | tr -d "m" | perl -pe 's/ /\n/g' | sort -n | sed -e 1b -e '$!d')
	 ENHANCE=$(echo $BETTER | tr '\n' ' ' | awk '{print $1"-"$2"."}') 
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
