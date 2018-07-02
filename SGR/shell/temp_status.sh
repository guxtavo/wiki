#!/bin/bash

temperature_cpu_hd_real(){
  B=$(sensors | grep CPU | awk '{print $2}' | \
    tr -d "+°C" | sed 's/\.0//g')
  C=$(sudo hddtemp /dev/sda| awk '{print $6}' | tr -d "°C")
  echo -n "$B/$C"
}

temperature_cpu_hd_real > /tmp/temp_status
for i in 1 2 3 4 5; do
  sleep 9
  temperature_cpu_hd_real > /tmp/temp_status
done
