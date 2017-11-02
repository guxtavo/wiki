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

target(){
        B=$(cat ~/.config/target) 
        echo -n " => $B <= |"
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
LOOP=0.1

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
echo -n " |"
}

git_repos_change(){
        B=$(~/git/wiki/profile/git-tmux.sh)
        echo -n " GIT:$B |"
}

tasks(){
        r=$(( $RANDOM % 10 ))

        if [  "$r" -le "5" ]
        then
                A=$(awk '/#TASKS-NOW/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
                B=$(awk '/#TASKS-WEEKS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
                C=$(awk '/#TASKS-MONTHS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
                D=$(awk '/#TASKS-YEARS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
                E=$(awk '/#TASKS-10-YEARS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
                echo -n " $A/$B/$C/$D/$E |"
        else
                A=" "
                B="  "
                C=" "
                D="  "
                E=" "
                echo -n " +000 / -000 |"
        fi
}

weather(){
        B=$(~/git/wiki/profile/weather.sh)
        echo -n " $B |"
}

temperature(){
        B=$(sensors | grep CPU | awk '{print $2}' | tr -d "+" | sed 's/\.0//g')
	C=$(sudo hddtemp /dev/sda| awk '{print $6}')
        echo -n " $B/$C |"
}

dns()
{
if ! grep 10.100.2.8 /etc/resolv.conf > /dev/null
then
echo -n home
fi

if ! grep 192.168.1.1 /etc/resolv.conf > /dev/null
then
echo -n suse
fi
}

network_check()
{
#ping -c 1 -w 1 8.7.6.5 > /dev/null
ping -c 1 -w 1 10.100.2.8 > /dev/null
OUT=$?
if [ $OUT -eq 0 ];then
   echo "."
else
   echo "!!"
fi
}

network_check2()
{
#ping -c 1 -w 1 8.7.6.5 > /dev/null

B=$(ping -c 1 -w 1 8.8.8.8 | grep from | \
#B=$(ping -c 1 -w 1 10.100.2.8 | grep from | \
awk '{print $7}' | \
cut -f 2 -d "=" | \
cut -f 1 -d ".")

if test ! -z $B; then echo -n "$B"; else echo " !!";fi
}

nic_up(){
        B=$(ip link  show | grep LOWER_UP | \
	  grep -v lo | \
	  grep LOWER_UP | \
	  awk '{print $2}' | \
	  tr -d ":" | \
	  perl -p -e 's/\n/, /' | \
	  sed -e 's/, $//g' || echo NIC)
	C=$(dns)
        echo -n " $B ($C) |"
}

network_latency()
{
B=$(network_check2)
echo -n " ${B}ms |" 
}

volume(){
        B=$(amixer get Master | egrep -o "[0-9]+%" | egrep -o "[0-9]*" | uniq)
        echo -n " ♪$B |"
}

battery(){
        B=$(acpi | head -1 | awk '{print $4}' | cut -b 1)
	for i in $(seq $B); do echo -n "!"; done

	if $(acpi | grep "Battery 0" | grep -q Discharging)
		then
			echo -n " |"
		else
			echo -n "∞ |"
	fi
}

brightness(){
        TEMP=`cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness`
        B=$(( (TEMP * 100) / 937));  
        echo -n " ☀$B |"
}

solid_ground_progress()
{
	if $(ip a | grep tun0 | grep -q UP)
		then
			if test "`find /tmp/progress -mmin +30`"
			then
				l3ls -m | egrep 'IN_PROGRESS|NEW|CONFIRM' | wc -l > \
				/tmp/progress
			fi
			B=$(cat /tmp/progress)
			echo -n " L3:$B |"
		else
			echo -n " L3:NA |"
	fi
}

banner()
{
	echo -n "   [ CODER 0.1 ]   | "
}

irc()
{
	B=$(grep capcom ~/irclogs/suse/* \
	| egrep -v "You're now known as|has joined|has quit\
        |capcom>|sdibot>|\* capcom" | wc -l)
	echo -n " IRC:$B |"
}

updates()
{
	if [ $(zypper lu|wc -l) -gt 3 ]
		then
			echo -n " !! |"
		else
			echo -n " OK |"
	fi
}

main(){
        battery
#	banner
#	updates
	solid_ground_progress
	irc
        git_repos_change
	target
	countdown
        weather
        temperature
#        brightness
        volume
        nic_up
	network_latency
	hdd_led
}

main
