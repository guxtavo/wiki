#!/bin/bash

calcurse -d today --format-apt="%S;%E;%m\n" \
                  --format-recur-apt="%S;%E;%m\n" > /dev/shm/calcurse-a

sed -i -e "1d" /dev/shm/calcurse-a
