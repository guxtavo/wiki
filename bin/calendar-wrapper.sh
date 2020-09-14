#!/bin/bash

now=$(event-now.rb)

if [ -z "$now" ]; then
    # fix this
    echo $(calcurse -n | tail -1)
else
    echo "$now"
fi
