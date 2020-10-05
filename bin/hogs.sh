#!/bin/bash
# Print the process name for the top process using more than 50% of cpu

top=$(top -b -n 1 | head -8 | tail -1 | awk '{print $9 " " $12}')
cpu=${top[0]%.*}
#proc=${top[1]}

if [ "$cpu" -gt 50 ]; then
    echo "1"
else
    echo "0"
fi
exit 0
