#!/bin/bash
source ~/git/wiki/profile/plugins/time.sh
source ~/git/wiki/profile/plugins/st.sh

# bug: optimize weather and network-status
# main loop
main(){
  run_start                    # 19ms
  #gimbal                       # 01ms
  #countdown                   # 08ms
  if [ $ARCH = "x86_64" ]; then
    weather                    # 46ms
  fi
  if [ $ARCH = "x86_64" ]; then
    solidground_progress         # 25ms # bz
    targets                      # 15ms # sg # successful builds
  fi
  cpu-hdd_temp                 # 12ms # and storage
  if [ $ARCH = "x86_64" ]; then
    battery-countdown-recording  # 23ms
  fi
  network-status               # 50ms
}

show_line()
{
		record_start_time
		# FATE
		# if file is older than 5 reconds, run it again
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
