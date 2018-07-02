#!/bin/bash
# change text='l3-coord@suse.de' for your text
# change bewtween(t,120,130) for the time in seconds

ffmpeg -i $1 -vf \
drawtext="fontfile=/home/gfigueira/git/wiki/Roboto-Regular.ttf: \
text='l3-coord@suse.de': fontcolor=white: fontsize=48: box=1: \
boxcolor=black@0.5: boxborderw=5: x=1500: y=900: \
enable='between(t,120,130)'" -c:a copy \
-c:v libvpx-vp9 -crf 30 -b:v 0 output.webm
