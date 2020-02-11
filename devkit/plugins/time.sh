#!/bin/bash

export SYSTEM=$(uname -s)

# record start time
function record_start_time()
{
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
}


# record end time
function record_end_time()
{
		if [ $SYSTEM = "Linux" ]; then
				export FINISH=$(date +%s%N)
			else
				export FINISH=$(/home/gfigueira/git/wiki/bin/date)
		fi
}
