#!/usr/bin/env bash
# History
# 20170417 - Sanitize tmux status bar scripts
# storage, sysmgmnt, kernel

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


curling()
{ 
	curl -s wttr.in/Brno | \
	gsed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | \
	strings | \
	head -3 | \
	tail -1 | \
	cut -b14-20 | \
	awk '{print $1}' > /tmp/weather
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

nic_up(){
        B=$(ifconfig | grep RUNNING | \
	  egrep -v "lo0|pflog0" | \
	  awk '{print $1}' | \
	  tr -d ":" | \
  	  perl -p -e 's/\n/, /' | \
          sed -e 's/, $//g' || echo NIC)
	C=$(dns)
	echo -n " $B ($C$(network_check)) |"
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
	if [[ ! -e /tmp/syspatch ]]
		then
			B=NA
		else
			B=$(cat /tmp/syspatch)
	fi
	echo -n " $B |"
}

volume()
{
	B=$(mixerctl outputs.master | cut -f 2 -d ",")
	echo -n " $(( ( $B * 100 ) / 255 ))% |"
}

sd0_lag()
{
	B=$(systat -B -s 0.2 iostat | head -5 | tail -1 | awk '{print $6}')
	echo -n " sd0: $B |"
}


l3t_progress()
{
	ssh -x root@germ57.suse.cz l3ls -m
}

solid_ground_progress()
{
	if [[ ! -e /tmp/progress ]]
		then
			touch /tmp/progress
	fi

        if ifconfig tun0 | grep RUNN > /dev/null
                then
                        if test "`find /tmp/progress -mmin +5`"
                        then
                                l3t_progress | \
				egrep 'IN_PROGRESS|NEW|CONFIRM' | \
				wc -l > /tmp/progress
                        fi
                        B=$(cat /tmp/progress|awk '{print $1}')
                        echo -n " L3:$B |"
                else
                        echo -n " L3:NA |"
        fi
} 

main(){
	updates
	solid_ground_progress
	irc
	git_repos_change
	target
	countdown
        weather
        temperature
	volume
	#network lag
        nic_up
	sd0_lag
}

main
