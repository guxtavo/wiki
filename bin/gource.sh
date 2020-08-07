#!/bin/bash

gource -s 0.1 -a 1 \
    --title "solid-ground develop branch" \
    --highlight-users --hide bloom ~/git/solid-ground/ \
    -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - \
    -vcodec libvpx -b 10000K gource.webm
