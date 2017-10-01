#!/usr/bin/env bash

# feed /tmp/weather from wttr.in and use regex to manipulate data
# 
# fix me - if no internet, file could be empty, try a second time maybe or 
# something more robust

# functions

get_weather(){
  curl wttr.in/Brno | \
  head -4 | tail -1 | awk '{print $4}' \
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
  cat /tmp/weather | strings | cut -b 11-12
  
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
