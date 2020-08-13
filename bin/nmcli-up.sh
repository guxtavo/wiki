#!/bin/bash
nmcli general status
echo

declare -a names
declare -a uuids
i=0

while read a b
do
    names[i]="$b"
    uuids[i]="$a"
    echo "names[$i] = ${names[i]} | uuids[$i] = ${uuids[i]}"
    let i++
done < <(nmcli --fields UUID,NAME connection show)

echo
echo -n "Type the connection number you want to activate: "
read id

nmcli connection up ${uuids[$id]}
