#!/bin/bash

export SYSTEM=$(uname -s)

if [ $SYSTEM = "Linux" ]; then
		# record time to calculate elapsed time
		export START=$(date +%s%N)
		# create lock to avoid concurrent running
		set -e
		scriptname=$(basename $0)
		lock="/dev/shm/${scriptname}"
		exec 200>$lock
		# if lock is taken, second instance will exit with 1
		flock -n 200 || exit 1
	else
		export START=$(/home/gfigueira/git/wiki/bin/date)
fi

# sourcing plugins to cleanup the main script
source ~/git/wiki/profile/plugins/st.sh

# bug: optimize weather and network-status
# main loop
main(){
  run_start                    # 19ms
  gimbal                       # 01ms
  #countdown                    # 08ms
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
if [ $SYSTEM = "Linux" ]; then
		export FINISH=$(date +%s%N)
	else
		export FINISH=$(/home/gfigueira/git/wiki/bin/date)
fi

# output the line preceeded by the runtime in ms
echo -n $(( ($FINISH - $START)/1000000 ))
echo -n ms $(cat /dev/shm/shell-status)
