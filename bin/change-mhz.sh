#!/bin/bash

sudo cpupower frequency-set -u "$1"MHz -d 500MHz

sudo cpupower frequency-info | grep "hardware\|current"
exit 0
