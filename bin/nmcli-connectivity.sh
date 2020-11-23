#!/bin/bash
status=$(nmcli networking connectivity)

if [ "$status" = "full" ]; then
    echo 0
else
    echo 1
fi
