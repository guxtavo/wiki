#!/bin/bash
while IFS=':' read -r username _ _ _ _ home _
do
    echo "$username":"$home"
done < /etc/passwd
