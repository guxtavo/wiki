#!/bin/bash

countdown()
{
  # to start a countdown:
  # $ countdown 300 &
  # what to show when there is no countdown?

  if test -e /tmp/countdown
  then
    B=$(cat /tmp/countdown)
    MIN=$(( $B/60 ))
    SEC=$(( $B%60 ))
    if [ $SEC -lt 10 ]; then
      echo -n " $MIN:0$SEC ⌛"
    else
      echo -n " $MIN:$SEC ⌛"
    fi
  fi
}

mps_whats_playing()
{
  WP=$(ps -fugfigueira | grep [m]pv | cut -d '"' -f2)
  SIZE=${#WP}
  #if [ "$SIZE" -lt 60
  if [ ! -z "$WP" ]; then
    echo -n "| $(~/git/wiki/profile/pl.sh) 🎵"
  fi
}

recording()
{
  if [ -f /tmp/recording ]; then
    CREATED=$(find /tmp/recording -printf '%C@\n' | cut -f 1 -d .)
    NOW=$(date +%s)
    DIF=$(( $NOW - $CREATED ))
    MIN=$(( $DIF/60 ))
    SEC=$(( $DIF%60 ))
    if [ $SEC -lt 10 ]; then
      echo -n " $MIN:0$SEC 🔴"
    else
      echo -n " $MIN:$SEC 🔴"
    fi
  fi
}


target(){
  B=$(cat ~/.config/target)
  echo -n " => $B <= |"
}

getVmstat() {
  cat /proc/vmstat|egrep "pgpgin|pgpgout"
}

# virtual hdd indicator
# reads /proc/stat and track changes in pgpgin and pgpgout
# if there is no change, print an empty circle
# if there is change, prinf a full circle
# It should print 4 circles, every time status-right.sh executes
# most of the time it should be empty circles as there is a 2 seconds
# interval on the tmux status bar script, but it would show a lot of
# full circles if there is big activity
hdd_led(){
  LOOP=0.1

  # initialise variables
  NEW=$(getVmstat)
  OLD=$(getVmstat)

  echo -n " "
  for i in 1 2 3; do
    sleep $LOOP
    NEW=$(getVmstat)
    if [ "$NEW" = "$OLD" ]; then
      printf '\xE2\x97\x8B'
    else
      printf '\xE2\x97\x8F'
    fi
    OLD=$NEW
  done
  echo -n " |"
}

git_repos_change(){
  B=$(~/git/wiki/profile/git-tmux.sh)
  echo -n "$B |"
}

#weather(){
#}

temperature(){
  B=$(sensors | grep CPU | awk '{print $2}' | \
    tr -d "+°C" | sed 's/\.0//g')
  C=$(sudo hddtemp /dev/sda| awk '{print $6}' | tr -d "°C")
  D=$(~/git/wiki/profile/weather.sh)
  echo -n " $B/$C🌡 $D |"
}

dns()
{
  if ! grep 10.100.2.8 /etc/resolv.conf > /dev/null
  then
    echo -n home
  fi

  if ! grep 8.8.8.8 /etc/resolv.conf > /dev/null
  then
    echo -n suse
  fi
}

network_check()
{
  #ping -c 1 -w 1 8.7.6.5 > /dev/null
  #ping -c 1 -w 1 10.100.2.8 > /dev/null
  ping -c 1 -w 1 l3slave.suse.de 2>&1 /tmp/ping_l3slave
  OUT=$?
  if [ $OUT -eq 0 ];then
    echo "."
  else
    echo "!!"
  fi
}

nic_up(){

  if $(ip link show | grep LOWER_UP | egrep "virbr|vnet" > /dev/null)
  then
    H="H"
  else
    H="."
  fi

  echo -n " "

  if $(ip link show | grep wlp1s0 | grep LOWER_UP > /dev/null); then
    echo -n 📶
  fi

  if $(ip link show | grep tun0 | grep LOWER_UP > /dev/null); then
    echo -n 🔒
  fi

  L=$(helper_latency)
  echo -n "($L) |"
  #📶 show this icon if wifi is on
  #🔒 show this if tun0 is up
}


#    0-75 ms : a
#  75-125 ms : A
# 125-250 ms : b
# 250-500 ms : B
# 500-999 ms : c
#     else   : ?

network_latency()
{
  B=$(ping -c 1 -w 3 l3slave.suse.de \
    | grep seq \
    | awk '{print $8}' \
    | cut -f 2 -d "=" \
    | cut -f 1 -d ".")

  if test -n $B  ; then
    if [ $B -le "75" ]; then
      C="a"
    elif  [ $B -le "125" ] && [ $B -ge "75" ]; then
      C="A"

    elif [ $B -le "250" ]  && [ $B -ge "125" ]; then
      C="b"

    elif [ $B -le "500" ]  && [ $B -ge "250" ]; then
      C="B"

    elif [ $B -le "999" ]  && [ $B -ge "500" ]; then
      C="c"
    else
      C="?"
    fi
  else
    C="!"
  fi

  # saving last 3 pings
  tail -2 /tmp/pings > /tmp/pings_t
  echo $C >> /tmp/pings_t
  mv /tmp/pings_t /tmp/pings

  D=$(cat /tmp/pings | perl -p -e 's/\n//')

  echo -n "${D}"
}

helper_latency(){
  nslookup l3slave.suse.de | grep "can't" > /dev/null
  if [ $? -eq 0 ]; then
    # DNS query failed, set ???
    echo -n "???"
  else
    network_latency
  fi
}
volume(){
  B=$(amixer get Master | egrep -o "[0-9]+%" | egrep -o "[0-9]*" | uniq)
  echo -n " ♪$B |"
}

battery(){
  B=$(acpi | grep -v "unavailable" | awk '{print $4}' | tr -d "%,")

  if $(acpi | grep -v "unavailable" | grep -q Discharging)
  then
    B=$(acpi -b 0 | grep "Battery 0" |\
      awk  '{print $5}') # bug
    echo -n " ${B::-3} |"
  else
    echo -n " $B∞ |"
  fi
}

brightness(){
  TEMP=`cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness`
  B=$(( (TEMP * 100) / 937));
  echo -n " ☀$B |"
}

solid_ground_fix()
{
  l3ls -m | grep "^\[" | tr -d "[" | \
    awk '{print $1}' | \
    perl -pe 's/\n/\//g' | \
    awk -F "/" '{ print $2 "/" $1}' > /tmp/progress
}

git_changes()
{
  # ! This includes directories
  # ! It will always has changes due to automatic git update on cron
  B=$(find ~/git -ctime -1  | wc -l)
  echo -n " $B"
}

solid_ground_progress()
{
  FILTER="IN_PROGRESS|NEW|CONFIRM"
  if $(ip a | grep tun0 | grep -q UP)
  then
    if test "`find /tmp/progress -mmin +45`"
    then
      solid_ground_fix
    fi
    B=$(cat /tmp/progress)
    echo -n " $B/"
  else
    echo -n " "
  fi
}

banner()
{
  echo -n "   [ CODER 0.1 ]   | "
}

irc()
{
  B=$(grep capcom ~/.irssi/irclogs/suse/* \
    | egrep -v "You're now known as|has joined|has quit\
    |capcom>|sdibot>|\* capcom" | wc -l)

  echo -n " I:$B |"
}

updates()
{
  if [ $(zypper lu|wc -l) -gt 3 ]
  then
    echo -n " !! |"
  else
    echo -n " OK |"
  fi
}

main(){
  mps_whats_playing
  recording
  countdown
  git_changes
  solid_ground_progress
  git_repos_change
  #target
#  weather
  temperature
  nic_up
  hdd_led
  battery
}

main
