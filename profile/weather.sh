#!/bin/bash

# feed /tmp/weather from wttr.in and use regex to manipulate data
# 
# fix me - if no internet, file could be empty, try a second time maybe or 
# something more robust

# functions

get_weather(){
  curl wttr.in/Brno | \
  sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" \
  > /tmp/weather
}

# main funtion
main(){

  # fetch data if files is 30 minutes old
  if test "`find /tmp/weather -mmin +30`"
  then
    get_weather
  fi

  # maybe add some timer here

  # if the file is empty, try again to fetch the data 
  if test ! -s /tmp/weather
  then
    get_weather
  fi
  
  # show the formatted weather
  head -4 /tmp/weather  | tail -1 | \
  cut -b 16-40 | sed 's/ *$//' | \
  sed 'N;s/\n/ /' 
}

# adding case to easily test the bugs
case $1 in
  fix)
    get_weather
    ;;
  break_fix)
    cat /dev/null > /tmp/weather
    ;;
  *)
    main
    ;;
esac
