#!/bin/bash

NUMBER=$(ssh -o ConnectTimeout=3 l3slave.suse.de ptfdb ls package --agent gfigueira | grep Feedback | grep -v Time | grep Positive | awk '{print $3}' | wc -l)

echo -n $NUMBER "|"
