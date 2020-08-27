#!/bin/bash
enscript -f Courier12 -t CAPCOM \
-Bp '-' git/wiki/rtm/to_sum_up-capcom.txt  > ~/out.ps
ps2pdf14 ~/out.ps ~/to_sum_up-capcom.pdf
rm ~/out.ps
