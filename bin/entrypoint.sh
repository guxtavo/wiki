#!/bin/bash
#entry point for debugging linux - curious mode
#strace interesting processes

#what about short lived processes? How to trace them?
#I want this program to strace interesting (top 10 by time) processes 
# 
#Curious mode let you have 5 seconds strace of processes with the following 
#distribution
#
#Top PID by Time
#distribution
################
#      10%     #
#   ---------  # 
#              #
#      30%     #
#              #
#   ---------  # 
#              #
#              #
#      60%     #
#              #
#              #
#              #
################

# variables
TOP_10_BY_TIME=10
BOTTOM=60
PID=
COMM=
BASE_DIR="/home/gfigueira/suse/qcows"

find_number_of_processes()
{

}

get_random_pid()
{

}

# print helper screen with short description of syscalls
syscall_helper()
{
echo "    fast user-space locking: futex are userspace(mostly)"
echo "    timers(blocker) for shared memory"
}

# decide what type of process to choose for inspection
# * - 66% of times take from the top 33% by TIME
rule_capture_select()
{
	case $TYPE in
        bottom)
	;;
	top) 
	;;

	esac

	select_pid_top
        select_pid_bottom

	capture $PID $COMM
	;
}


# once process is selected, run the actual capture
capture(PID,COMM)
{
	strace -cqf -o $BASE_DIR/$PID-$COMM.strace &
	strace_pid=$!
	sleep 5
	kill -15 $strace_pid
}

# generate the report by time elapsed
report_by_time()
{
	strace -qc -r -b time 
}

# gerenate the report by number of calls
report_by_calls()
{
	strace -qc -r -b calls
}

main()
{
	capture_select

}
