#!/usr/bin/env bash

get_weather(){
  curl -s wttr.in/Brno | gsed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | strings | head -3 | tail -1 | awk '{print $2}' 
  touch /tmp/weather
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
