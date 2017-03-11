if test "`find /tmp/weather -mmin +30`"
then
  curl wttr.in/Brno > /tmp/weather
fi

head -4 /tmp/weather  | tail -2 | cut -b 31-71 | sed 'N;s/\n/ /' | sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g"
