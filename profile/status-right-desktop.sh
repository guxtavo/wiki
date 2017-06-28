# History
# 20170417 - Sanitize tmux status bar scripts

target(){
        B=$(cat ~/.config/target) 
        echo -n "=> $B <= |"
}

git_repos_change(){
        B=$(~/git/wiki/profile/git-tmux.sh)
        echo -n " $B |"
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
        B=$(sensors | grep C | egrep "temp1" | cut -b 15-17 | tr "\n" , | sed -e 's/,$/°C/')
        echo -n " $B |"
}

nic_up(){
        B=$(ip link  show | grep LOWER_UP | grep -v lo > /dev/null && ip link show | grep LOWER_UP | grep -v lo | cut -f 2 -d " " | tr -d : | tr "\n" , | sed -e 's/,$//' || echo NIC)
        echo -n " $B |"
}

volume(){
        B=$(amixer get Master | egrep -o "[0-9]+%" | egrep -o "[0-9]*" | uniq)
        echo -n " ♪ $B |"
}

battery(){
        B=$(acpi | tac | cut  -d ',' -f 2)
        echo -n " ♥ $B |"
}

brightness(){
        TEMP=`cat /sys/devices/pci0000:00/0000:00:02.0/backlight/acpi_video0/brightness`
        B=$(( (TEMP * 100) /10 ));  
        echo -n " ☀ $B |"
}

main(){
        target
        git_repos_change
        tasks
        weather
        #temperature
        nic_up
        brightness
        volume
        battery
}

main
