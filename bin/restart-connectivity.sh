#!/bin/bash
ps fax | grep \/[c]onnectivity | while read a b; do
    echo "kill -9" $a
    echo "~/git/wiki/devkit/plugins/connectivity.sh &"
done
