#!/bin/bash
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
hdd_led_real(){
  LOOP=0.1

  # initialise variables
  NEW=$(getVmstat)
  OLD=$(getVmstat)

  for i in 1 2 3 4 5; do
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

hdd_led_real > /tmp/hdd_led

for i in 1 2 3 4 5; do
  sleep 9
  hdd_led_real > /tmp/hdd_led
done

