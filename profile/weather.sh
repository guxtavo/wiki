if test "`find /tmp/weather -mmin +30`"
then
  curl wttr.in/Brno |  sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" > /tmp/weather
fi

head -4 /tmp/weather  | tail -2 | cut -b 16-40 | sed 's/ *$//' | sed 'N;s/\n/ /' 
