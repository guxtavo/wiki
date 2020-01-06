#!/bin/bash
source ~/git/wiki/profile/plugins/time.sh
source ~/git/wiki/profile/plugins/st.sh

# bug: optimize weather and network-status
# main loop
main(){
  run_start                    # 19ms
  gimbal                       # 01ms
  #countdown                   # 08ms
  weather                      # 46ms
  solidground_progress         # 25ms # bz
  targets                      # 15ms # sg # successful builds
  cpu-hdd_temp                 # 12ms # and storage
  battery-countdown-recording  # 23ms
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
