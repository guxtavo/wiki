#!/bin/bash
# Connectivity watchdog
# Runs in the background and reports to /dev/shm/connectivity
#
# (1) ~ $ ping_router
# 0 0                  # gw and vpn gw
# (0) ~ $ ping_dns
# 0 0 0                # 3 dns's
# (0) ~ $

function main(){
    while true; do
    # Run in a loop forever - as a daemon
        R1=$(ping_router)
        R2=$(ping_dns)
        echo "$R1" "$R2" >> /dev/shm/connectivity
        sleep 15 # try to not flood the network
    done
}

main
