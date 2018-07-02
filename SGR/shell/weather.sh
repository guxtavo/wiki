#!/usr/bin/env bash

# feed /tmp/weather from wttr.in and use regex to manipulate data
#
# fix me - if no internet, file could be empty, try a second time maybe or 
# something more robust

# functions

get_weather()
{
  LOCATION=Brno
  #LOCATION=Prague
  #LOCATION=Nova_iguacu
  curl -m 5 wttr.in/"$LOCATION" | \
    sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" \
    > /tmp/weather
}

test_size()
{
  LINES=$(wc -l /tmp/weather | awk '{print $1}')
  if [ $LINES -lt 20 ]; then
    B=-----
  fi
}

format_data2()
{
  echo -n $(cat /tmp/weather | sed -n 16p | grep -o .[0-9]% | sort -n | sed '$!d')
  echo -n  $(cat /tmp/weather | sed -n 13p | grep -o [0-9][0-9] |sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print $1"/"$2}')
}

# main funtion
main(){

  # fetch data if files is 30 minutes old
  if test "`find /tmp/weather -mmin +30`"
  then
    get_weather
  fi

  # if the file is empty, try again to fetch the data
  if test ! -s /tmp/weather
  then
    get_weather
  fi

  test_size

  # check size of the file before setting the variables
  if [ $(cat /tmp/weather | wc -l) -lt 20 ]; then
    B="-----"
    # retry in less time
    if test "`find /tmp/weather -mmin +5`"
    then
      get_weather
    fi
  else
    format_data2
  fi
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
