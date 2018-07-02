#!/bin/bash

#source ~/git/wiki/profile/temp_status.sh
#source ~/git/wiki/profile/sys_status.sh # blocked tasks

# Fix me: there should be a function to check internet connection, because this
# is needed by other functions
# separate server from client. The client should run as fast as possible. The
# server should run in background, preferably cron,

# It should run one second max and last version should be used but a warning
# should be shown

print_laytency()
{
  echo -n "$(cat /tmp/latency)"
}

hdd_led()
{
  echo -n $(cat /tmp/hdd_led)
}

temperature_cpu_hd()
{
  echo -n $(cat /tmp/temp_status) "|"
}

mps_whats_playing()
{
  WP=$(ps -fugfigueira | grep [m]pv | cut -d '"' -f2)
  SIZE=${#WP}
  if [ ! -z "$WP" ]; then
    echo -n "| $(~/git/wiki/profile/fix_size) 🎵 |"
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
      echo -n " $MIN:0$SEC 🔴 |"
    else
      echo -n " $MIN:$SEC 🔴 |"
    fi
  elif test -e /tmp/countdown ; then
    B=$(cat /tmp/countdown)
    MIN=$(( $B/60 ))
    SEC=$(( $B%60 ))
    if [ $SEC -lt 10 ]; then
      echo -n " $MIN:0$SEC ⌛ |"
    else
      echo -n " $MIN:$SEC ⌛ |"
    fi
  else
    battery
  fi
}

alternate_performance()
{
  SEC=$(date | awk '{print $4}' | cut -d ':' -f 3)
  if [ $SEC -ge 0 -a $SEC -le 9 ]; then
    print_laytency
  fi
  if [ $SEC -ge 10 -a $SEC -le 19 ]; then
    hdd_led
  fi
  if [ $SEC -ge 20 -a $SEC -le 29 ]; then
    temperature_cpu_hd
  fi
  if [ $SEC -ge 30 -a $SEC -le 39 ]; then
    print_laytency
  fi
  if [ $SEC -ge 40 -a $SEC -le 49 ]; then
    hdd_led
  fi
  if [ $SEC -ge 50 -a $SEC -le 59 ]; then
    temperature_cpu_hd
  fi
}

temperature(){
  D=$(~/git/wiki/profile/weather.sh)
  echo -n " $D |"
}

nic_up()
{
  echo -n " "
  if $(ip link show | grep wlp1s0 | grep LOWER_UP > /dev/null); then
    echo -n 📶
  fi
  if $(ip link show | grep tun0 | grep LOWER_UP > /dev/null); then
    echo -n 🔒
  fi
  echo -n " |"
}

battery(){
  B=$(acpi | grep -v "unavailable" | awk '{print $4}' | tr -d "%,")

  if $(acpi | grep -v "unavailable" | grep -q Discharging)
  then
    B=$(acpi -b 0 | grep -v "unavai" | awk  '{print $5}') # bug?
    echo -n " ${B::-3} |"
  else
    echo -n " $B∞ |"
  fi
}



# L3 and git

proce()
{
  cat /tmp/progress | while read a b
do
  if [ "$b" = 'sleeping' ]; then
    PROC=$(( $PROC + $a ))
  elif [ "$b" = 'processed' ]; then
    PROC=$(( $PROC + $a ))
  elif [ "$b" = 'active' ]; then
    ACTI=$(( $ACTI + $a ))
  fi
  echo $ACTI/$PROC
done
}

solid_ground_fix()
{
  l3ls -m  | grep "^\[" | tr -d "[" | while read a b c; do
  echo $a $b
done > /tmp/progress
}

solid_ground_progress()
{
  # check vpn connectivity
  if $(ip a | grep tun0 | grep -q UP); then
    if test "`find /tmp/progress -mmin +15`"
    then
      solid_ground_fix
    fi
    B=$(proce | tail -1)
    echo -n " $B"
  else
    echo -n " ?"
  fi
}

git_changes()
{
  # ! This includes directories
  # ! It will always has changes due to automatic git update on cron
  if test "`find /tmp/git_changes -mmin +30`"
  then
    find ~/git -ctime -1  | wc -l > /tmp/git_changes
    find ~/git/suse -ctime -1  | wc -l > /tmp/suse_git_changes
  fi
  B=$(cat /tmp/git_changes)
  echo -n " $B/"

  C=$(cat /tmp/suse_git_changes)
  echo -n "$C/"

  D=$(~/git/wiki/profile/git-tmux.sh)
  echo -n "$D | "
}

main(){
  mps_whats_playing
  temperature
  solid_ground_progress
  git_changes
  alternate_performance
  recording
  nic_up
}

main
