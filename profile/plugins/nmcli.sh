#!/bin/bash

status=$(nmcli device wifi list | grep ^\* | awk '{print $8}')

if [ -z "$status" ]; then
    B="?"
    else
    B=$status
fi

echo -n "$B"
