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
        echo -n " $B $C|"
}

nic_up(){
        B=$(ip link  show | grep LOWER_UP | grep -v lo > /dev/null && ip link show | grep LOWER_UP | grep -v lo | cut -f 2 -d " " | tr -d : | tr "\n" , | sed -e 's/,$//' || echo NIC)
        echo -n " $B |"
}

volume(){
        B=$(amixer get Master | egrep -o "[0-9]+%" | egrep -o "[0-9]*" | uniq)
        echo -n " ♪$B |"
}

battery(){
        B=$(acpi | head -1 | awk '{print $4}' | tr -d ",")
	if $(acpi | grep "Battery 0" | grep -q Discharging)
		then
			echo -n " ♥$B |"
		else
			echo -n " ♥$B ∞ |"
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
			B=$(l3ls -m | egrep 'IN_PROGRESS|NEW' | wc -l)
			echo -n " SG:$B |"
		else
			echo -n " L3:NA |"
	fi
}

banner()
{
	echo -n "   [ CODER 0.1 ]   | "
}

irc_get()
{
	total=0
	grep -hc capcom ~/irclogs/suse/* | while read a
	do
	total=$(( $a + $total ))
	echo $total
	done | tail -1
}

irc()
{
	B=$(eval irc_get)
	echo -n " IRC:$B |"
}

main(){
#	banner
	irc
	solid_ground_progress
        git_repos_change
	target
	countdown
        nic_up
        weather
        temperature
        brightness
        volume
        battery
	hdd_led
}

main
