#!/bin/bash
# Print 1 if any process is hogging the system, 0 if not
THRESHOLD=50
top=$(top -b -n 1 | head -8 | tail -1 | awk '{print $9}')
cpu=${top[0]%.*}

if [ "$cpu" -ge "$THRESHOLD" ]; then
    echo "1"
else
    echo "0"
fi
exit 0
