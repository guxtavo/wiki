#!/usr/bin/env bash
# History
# 20170417 - Sanitize tmux status bar scripts

countdown()
{
# to start a countdown:
# $ countdown 300 &
# what to show when there is no countdown?

	if test -e /tmp/countdown
		then
			B=$(cat /tmp/countdown)
			echo -n " $B |"
		else
			B=CD
			echo -n " $B |"
	fi
}

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
hdd_led(){
LOOP=0.25

# initialise variables
NEW=$(getVmstat)
OLD=$(getVmstat)

echo -n " "
for i in 1 2 3 4; do
  sleep $LOOP
  NEW=$(getVmstat)
  if [ "$NEW" = "$OLD" ]; then
    echo -n "#"
  else
    echo -n "."
  fi
  OLD=$NEW
done
echo " |"
}
target(){
        B=$(cat ~/.config/target) 
        echo -n " => $B <= |"
}


curling()
{ 
	curl -s wttr.in/Brno | \
	gsed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | \
	strings | \
	head -3 | \
	tail -1 | \
	tr -d "_/." | \
	awk '{print $2}' > /tmp/weather
}

weather(){
	# prepare
	if test -e /tmp/weather
		then
			if test "`find /tmp/weather -mmin +30`"
				then
					curling
			fi
		else
			curling
	fi

	# test for error - file is empty
	#if 

	# display
	B=$(cat /tmp/weather)
        echo -n " ${B}C |"
}

temperature(){
        B=$(sysctl -a | grep hw.sensors |grep cpu | cut -b 23-24)
	C=$(doas /root/hdd_temp.sh | awk '{print $4}')
        echo -n " ${B}C/${C}C |"
}

nic_up(){
        B=$(ifconfig | grep RUNNING | egrep -v "lo0|pflog0" | awk '{print $1}' | tr -d ":" | perl -p -e 's/\n/, /' | sed -e 's/, $//g' || echo NIC)
        echo -n " $B |"
}

git_repos_change(){
        B=$(~/git/wiki/profile/git-tmux.sh)
        echo -n " GIT:$B |"
}

irc()
{
        B=$(grep capcom ~/.irssi/irclogs/suse/* \
        | egrep -v "You're now known as|has joined|has quit\
        |capcom>|sdibot>|\* capcom" | wc -l | awk '{print $1}')
        echo -n " IRC:$B |"
}

updates()
{
	B=$(cat /tmp/syspatch)
	echo -n " $B |"
}

volume()
{
	B=$(mixerctl outputs.master | cut -f 2 -d ",")
	echo -n " $(( ( $B * 100 ) / 255 ))% |"
}

hdd_led()
{
	B=$(systat -B -s 0.2 iostat | head -5 | tail -1 | awk '{print $6}')
	echo -n " sd0:$B |"
}

main(){
	updates
	irc
	#solid_ground_progress - vm gfigueira-l3t-1017
	git_repos_change
	target
	countdown
        nic_up
        weather
        temperature
	#brightness - what to use here?
	volume
	#battery - what to use here?
	hdd_led
}

main
