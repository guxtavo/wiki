#!/bin/bash
ps fax | grep \/[c]onnectivity | while read a b; do
    kill -9 $a
    ~/git/wiki/devkit/plugins/connectivity.sh &
done
