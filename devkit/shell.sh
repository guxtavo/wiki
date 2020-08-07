#!/bin/bash
source ~/git/wiki/devkit/plugins/time.sh
source ~/git/wiki/devkit/plugins/st.sh

# bug: optimize weather and network-status
# main loop
netstatus=$(tail -1 /dev/shm/connectivity| tr -d " ")
main(){
  run_start
  show_hogs
  #gimbal
  #countdown
  weather
  if [ $netstatus = "00" ]; then
    solidground_progress
    targets
  fi
  hdd-stat
  cpu-stat
  if [ $ARCH = "x86_64" ]; then
    battery-countdown-recording
  fi
  network-status
}

show_line()
{
		record_start_time
		main > /dev/shm/shell-status
		record_end_time
		if [ $SYSTEM = "OpenBSD" ]; then
                source ~/git/wiki/bin/openbsd_list_hogs.sh
				echo -n $(show_hogs)
				echo -n "   "
		fi
		echo -n $(( ($FINISH - $START)/1000000 ))ms" "
		echo -n $(cat /dev/shm/shell-status)
}

show_line
