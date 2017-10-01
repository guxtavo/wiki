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
    printf '\xE2\x97\x8B'
  else
    printf '\xE2\x97\x8F'
  fi
  OLD=$NEW
done
echo " |"
}
target(){
        B=$(cat ~/.config/target) 
        echo -n " => $B <= |"
}

weather(){
        B=$(~/git/wiki/profile/weather-obsd.sh)
        echo -n " $B C |"
}

temperature(){
        B=$(sysctl -a | grep hw.sensors |grep cpu | cut -b 23-24)
        echo -n " $B C |"
}

nic_up(){
        B=$(ifconfig | grep UP | egrep -v "lo0|pflog0" | awk '{print $1}' | tr -d ":" | perl -p -e 's/\n/, /' | sed -e 's/, $//g' || echo NIC)
        echo -n " $B |"
}

main(){
	target
	countdown
        nic_up
        weather
        temperature
}

main

