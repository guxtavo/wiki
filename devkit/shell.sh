#!/bin/bash
source ~/git/wiki/devkit/plugins/time.sh
source ~/git/wiki/devkit/plugins/st.sh

show_separator(){
    echo -n ' |'
}

# main loop
netstatus=$(tail -1 /dev/shm/connectivity| tr -d " ")
if [ -z $netstatus ]; then
    export netstatus=1
fi

main(){
    #show_separator
    show_hogs
    #gimbal
    #countdown
    weather
    #show_separator
    if [ $netstatus = "00" ]; then
        solidground_progress
        targets
        #show_separator
    fi
    hdd-stat
    cpu-stat
    network-status
    if [ $ARCH = "x86_64" ]; then
      battery-countdown-recording
    fi
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
