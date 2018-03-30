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
for i in 1 2 3; do
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
        echo -n " $B |"
}

# tasks(){
#        r=$(( $RANDOM % 10 ))
# 
#         if [  "$r" -le "5" ]
#         then
#                 A=$(awk '/#TASKS-NOW/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
#                 B=$(awk '/#TASKS-WEEKS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
#                 C=$(awk '/#TASKS-MONTHS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
#                 D=$(awk '/#TASKS-YEARS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
#                 E=$(awk '/#TASKS-10-YEARS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l)
#                 echo -n " $A/$B/$C/$D/$E |"
#         else
#                 A=" "
#                 B="  "
#                 C=" "
#                 D="  "
#                 E=" "
#                 echo -n " +000 / -000 |"
#         fi
# }

weather(){
        B=$(~/git/wiki/profile/weather.sh)
        echo -n " $B |"
}

temperature(){
    B=$(sensors | grep CPU | awk '{print $2}' | \
        tr -d "+°C" | sed 's/\.0//g')
	C=$(sudo hddtemp /dev/sda| awk '{print $6}')
        echo -n " $B/$C |"
}

dns()
{
if ! grep 10.100.2.8 /etc/resolv.conf > /dev/null
then
echo -n home
fi

if ! grep 8.8.8.8 /etc/resolv.conf > /dev/null
then
echo -n suse
fi
}

network_check()
{
#ping -c 1 -w 1 8.7.6.5 > /dev/null
#ping -c 1 -w 1 10.100.2.8 > /dev/null
ping -c 1 -w 1 l3slave.suse.de > /dev/null
OUT=$?
if [ $OUT -eq 0 ];then
   echo "."
else
   echo "!!"
fi
}

nic_up(){

if $(ip link show | grep LOWER_UP | egrep "virbr|vnet" > /dev/null)
  then
    D="V"
  else
    D="."
fi

        B=$(ip link show | grep LOWER_UP | \
	  egrep -v "virbr|vnet" | \
	  grep -v lo | \
	  grep LOWER_UP | \
	  awk '{print $2}' | \
	  tr -d ":" | \
	  perl -p -e 's/\n/, /' | \
	  sed -e 's/, $//g' || echo NIC)

	C=$(dns)
        echo -n " $B $D ($C) |"
}

network_latency()
{
B=$(ping -c 1 -w 1 l3slave.suse.de \
  | grep seq \
  | awk '{print $8}' \
  | cut -f 2 -d "=" \
  | cut -f 1 -d ".")


#    0-75 ms : a
#  75-125 ms : A
# 100-250 ms : b
# 250-500 ms : B
# 500-999 ms : c
#     else   : ?

if test -n $B
	then
		if [ $B -lt "75" ]
		  then
		  C="a"

		  elif  [ $B -lt "125" ] && [ $B -ge "75" ]
		  then
		    C="A"

		  elif [ $B -lt "250" ]  && [ $B -ge "125" ]
		  then 
		    C="b"

		  elif [ $B -lt "500" ]  && [ $B -ge "250" ]
		  then 
		    C="B"

		  elif [ $B -lt "999" ]  && [ $B -ge "500" ]
		  then 
		    C="c"

		  else
		    C="?"
		fi
	else
	C="!"
fi

tail -2 /tmp/pings > /tmp/pings_t
echo $C >> /tmp/pings_t
mv /tmp/pings_t /tmp/pings

D=$(cat /tmp/pings | perl -p -e 's/\n//')

echo -n " ${D} |" 
}

volume(){
        B=$(amixer get Master | egrep -o "[0-9]+%" | egrep -o "[0-9]*" | uniq)
        echo -n " ♪$B |"
}

battery(){
        B=$(acpi | grep -v "unavailable" | awk '{print $4}' | tr -d "%,")
#	for i in $(seq $B); do echo -n "!"; done

	if $(acpi | grep -v "unavailable" | grep -q Discharging)
		then
			B=$(acpi -b 0 | grep "Battery 0" | awk  '{print $5}' | cut -b 2-5)
			echo -n " $B |"
		else
			echo -n " $B∞ |"
	fi
}

brightness(){
        TEMP=`cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness`
        B=$(( (TEMP * 100) / 937));  
        echo -n " ☀$B |"
}

solid_ground_fix()
{
	l3ls -m | grep "^\[" | tr -d "[" | \
	awk '{print $1}' | \
	perl -pe 's/\n/\//g' | \
	awk -F "/" '{ print $2 "/" $1}' > /tmp/progress
}

solid_ground_progress()
{
	FILTER="IN_PROGRESS|NEW|CONFIRM"
	if $(ip a | grep tun0 | grep -q UP)
		then
			if test "`find /tmp/progress -mmin +45`"
			then
			  solid_ground_fix
			fi
			B=$(cat /tmp/progress)
			echo -n " $B -"
		else
			echo -n " NA |"
	fi
}

banner()
{
	echo -n "   [ CODER 0.1 ]   | "
}

irc()
{
	B=$(grep capcom ~/.irssi/irclogs/suse/* \
	| egrep -v "You're now known as|has joined|has quit\
        |capcom>|sdibot>|\* capcom" | wc -l)
	echo -n " I:$B |"
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
#	banner
#	updates
	countdown
    weather
	solid_ground_progress
#	irc
    git_repos_change
	target
    temperature
#   brightness
#   volume
    nic_up
	network_latency
	hdd_led
    battery
}

main
