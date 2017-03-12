get_weather(){
  curl wttr.in/Brno |  sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" > /tmp/weather
}

if test "`find /tmp/weather -mmin +30`"
then
  get_weather
fi

if test -s /tmp/weather
then
  get_weather
fi

# fix me - if no internet, file could be empty, try a second time maybe or 
# something more robust

head -4 /tmp/weather  | tail -2 | cut -b 16-40 | sed 's/ *$//' | sed 'N;s/\n/ /' 
