#!/bin/bash
nmcli general status
echo

declare -a bssid
declare -a ssid
declare -a signal
i=0

while read a b c
do
    signal[i]="$a"
    bssid[i]="$b"
    ssid[i]="$c"
    echo "signal[$i] = ${signal[i]} | bssid[$i] = ${bssid[i]} | ssid[$i] = ${ssid[i]}"
    let i++
done < <(nmcli --fields SIGNAL,BSSID,SSID device wifi list)

echo
echo -n "Type the connection number you want to add: "
read id

echo
echo -n "Type connection password: "
read password

sudo nmcli d wifi connect "${ssid[$id]}" bssid ${bssid[$id]} password $password
