#!/bin/bash

export SYSTEM=$(uname -s)

# record time to calculate elapsed time
export START=$(date +%s%N)

if [ $SYSTEM = "Linux" ]; then
  # create lock to avoid concurrent running
  set -e
  scriptname=$(basename $0)
  lock="/dev/shm/${scriptname}"
  exec 200>$lock
  # if lock is taken, second instance will exit with 1
  flock -n 200 || exit 1
fi

# sourcing plugins to cleanup the main script
source ~/git/wiki/profile/plugins/st.sh

# bug: optimize weather and network-status
# main loop
main(){
  run_start                    # 19ms
  gimbal                       # 01ms
  countdown                    # 08ms
  export MIDDLE=$(date +%s%N)
  weather                      # 46ms
  solidground_progress         # 25ms
  targets                      # 15ms
  export ANOTHER=$(date +%s%N)
  cpu-hdd_temp                 # 12ms
  battery-countdown-recording  # 23ms
  network-status               # 50ms
}

# save output to a file
main > /dev/shm/shell-status

# record time to calculate elapsed time
export FINISH=$(date +%s%N)

# extra debugging
#echo -n $(( ($MIDDLE - $START)/1000000 ))
#echo -n "/"
#echo -n $(( ($ANOTHER - $MIDDLE)/1000000 ))
#echo -n "/"
#echo -n $(( ($FINISH - $ANOTHER)/1000000 ))
#echo -n "/"

# output the line preceeded by the runtime in ms
echo -n $(( ($FINISH - $START)/1000000 ))
echo -n ms $(cat /dev/shm/shell-status)
