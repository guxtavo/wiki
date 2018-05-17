#!/bin/bash
# display next trams

url="https://jizdnirady.idnes.cz/brno/zjr/?l=Tram+12&f=TECHNOLOGICK%c3%9d+PARK&t=Zvona%c5%99ka&ttn=IDSJMK&lng=E&submit=true"

w3m -dump_source $url | \
  awk '/timeszjr/,/^$/' | \
  sed -e 's/<img[^>]*>//g' > /tmp/1.html
w3m -dump /tmp/1.html | \
  head -25 | \
  grep -A1 -B1 ^`eval date +%H`
rm /tmp/1.html
