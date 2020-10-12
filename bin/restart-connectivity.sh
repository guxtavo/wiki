#!/bin/bash
ps fax | grep \/[c]onnectivity | while read a b; do
    kill -9 $a
done
~/git/wiki/devkit/plugins/connectivity.sh &
