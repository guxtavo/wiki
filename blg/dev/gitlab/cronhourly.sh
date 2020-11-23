#!/bin/bash
current_users="/home/gfigueira/current_users"
user_changes="/home/gfigueira/user_changes"
md5sum=$(/home/gfigueira/usernames.sh | md5sum)

if [ ! -e "$current_users" ]; then
    echo "$md5sum" > "$current_users"
else
    previous_users=$(cat /home/gfigueira/current_users)
    if [ "$md5sum" != "$previous_users" ]; then
        echo "$(date) changes occurred" >> "$user_changes"
        echo "$md5sum" > "$current_users"
    fi
fi
