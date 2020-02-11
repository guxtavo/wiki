#!/bin/bash

network_latency()
{
  B=$(ping -c 1 -w 3 l3slave.suse.de \
    | grep seq \
    | awk '{print $8}' \
    | cut -f 2 -d "=" \
    | cut -f 1 -d ".")

  if test -n $B  ; then
    if [ $B -le "75" ]; then
      C="a"
    elif  [ $B -le "125" ] && [ $B -ge "75" ]; then
      C="A"

    elif [ $B -le "250" ]  && [ $B -ge "125" ]; then
      C="b"

    elif [ $B -le "500" ]  && [ $B -ge "250" ]; then
      C="B"

    elif [ $B -le "999" ]  && [ $B -ge "500" ]; then
      C="c"
    else
      C="?"
    fi
  else
    C="!"
  fi

  # saving # last # 3 # pings
  tail -4 /tmp/pings > /tmp/pings_t
  echo $C >> /tmp/pings_t
  mv /tmp/pings_t /tmp/pings

  D=$(cat /tmp/pings | perl -p -e 's/\n//') 
  echo -n "${D}"
}

helper_latency(){
  nslookup l3slave.suse.de | grep "can't" > /dev/null
  if [ $? -eq 0 ]; then
    # DNS query failed, set ???
    echo -n "?????"
  else
    network_latency
  fi
}

print_laytency_real()
{
  L=$(helper_latency)
  echo -n "$L |"
}

print_laytency_real > /tmp/latency

for i in 1 2 3; do
  sleep 14
  print_laytency_real > /tmp/latency
done
