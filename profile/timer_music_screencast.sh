#!/bin/bash

# time, music or screencast
# show nothing when nothing is running
# show MM:SS⌛ for when timer is on
# show MM:SS🎶 when song is playng
# show MM:SS🔴 when screencast is recording
# When recording screencast is on, stop the recording if called again
# song time should be fed by mps-yt

countdown()
{
  # to start a countdown:
  #  $ countdown 300 &
  # or simply:
  #  $ pomo
  if test -e /tmp/countdown
  then
    B=$(cat /tmp/countdown)
    echo -n " $(( $B/60)):$(( $B%60))⌛ |"
  fi
}


music_on()
{
  if test -e /tmp/mps-yt
  then
    B=$(cat /tmp/mps-yt)
    # parse data
    # show MM:SS🎶 when song is playng
    # echo -n " $(( $B/60)):$(( $B%60))⌛ |"
  fi
}

screencast_on()
{
  if test -e /tmp/sc
  then
    B=$(cat /tmp/sc)
    # parse data
    # show MM:SS🔴 when screencast is recording
    # echo -n " $(( $B/60)):$(( $B%60))⌛ |"
  fi
}
