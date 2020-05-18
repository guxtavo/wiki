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

    # create control file if doesn't exist
    if test ! -e /dev/shm/diskspace
      then touch /dev/shm/diskspace
    fi

    # create control file if doesn't exist
    if test ! -e /dev/shm/ioprobe
      then touch /dev/shm/ioprobe
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
      echo -n " RECORDING $MIN:0$SEC |"
    else
      echo -n " RECORDING $MIN:$SEC |"
    fi
  fi
}

# shows reconding time, of countdowns or battery status
battery-countdown-recording()
{
    #isrecording
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
    # create control file if doesn't exist
    if test ! -e /dev/shm/weather_final
      then touch /dev/shm/weather_final
    fi

    echo -n " $(tail -1 /dev/shm/weather_final) |"
}

network-status()
{
  if [ $SYSTEM = "Linux" ]; then


    # create control file if doesn't exist
    if test ! -e /dev/shm/connectivity
      then touch /dev/shm/connectivity
    fi

    B=$( tail -1 /dev/shm/connectivity  | tr -d " ")
    echo -n " $B"
    #echo -n " |"
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
  SPECIAL="CODE"

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
