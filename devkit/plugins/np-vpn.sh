#!/bin/bash

shopt -s expand_aliases

# Give a status of the vpn connection by reading systemd logs

# VPN STATES
# NE - NO ENDPOINT connected: run systemctl start
# OK:  "Initialization Sequence Complete"
# NOK: partially_connected   - correct status, internet unreachable
# NOK: trying_to_connect     -

# TODO:
#   * list all possible lines from the systemctl status
#   * create 3 lists (files) containing the patterns from above
#   * divide the files as OK, NOK_DIALING, NOK

# Find which endpoint is active
for i in NUE PRG
do
    sudo systemctl status openvpn@SUSE-$i | grep Active: | grep inactive \
    > /dev/null 2>&1
    if [ $? -eq 1 ]; then
        export ENDPOINT=$i
    fi
done

if [ -z $ENDPOINT ]; then
    echo "No endpoint started"
    exit 1
fi

alias lastlines="sudo systemctl status openvpn@SUSE-$ENDPOINT | tail -2"

last_line=$(lastlines | tail -1 | cut -f 4 -d":")
last_line_minus_one=$(lastlines | head -1 | cut -f 4 -d":")

sl=$(echo $last_line)

vpn_process_restart()
{
    echo $sl | grep "Restart pause" > /dev/null 2>&1
    exit=$?
    if [ $exit = "0" ]; then
        echo "AWAY - VPN is restarting, please wait"
    fi
}

vpn_process_completed()
{
    echo $sl | grep "Initialization Sequence Completed" > /dev/null 2>&1
    exit=$?
    if [ $exit = "0" ]; then
        echo "OK - VPN seems to be connected"
    fi
}

vpn_process_piderrors()
{
    echo $sl | grep "PID_ERR replay window" > /dev/null 2>&1
    exit=$?
    if [ $exit = "0" ]; then
        echo "ERROR - VPN has errors"
    fi
}

vpn_process_restart
vpn_process_completed
vpn_process_piderrors

# if nothing happened here, e.g., try vpn_process_completed in the last-1 line

sl=$(echo $last_line_minus_one)

vpn_process_completed
