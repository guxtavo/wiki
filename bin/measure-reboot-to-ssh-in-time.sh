#!/bin/bash



ping="ping -qn -c1 -W 1"

$ping $1 > /dev/null
EXIT="$?"

# loop here until host is available
while [ "$EXIT" -eq 1 ]
do
    echo "host $1 is not responding to pings"
    sleep 1
    $ping $1 > /dev/null
    EXIT="$?"
done

echo
echo "host $1 is now available, ssh into it in 10 seconds"
sleep 14
ssh root@"$host" reboot

