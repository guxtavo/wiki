#!/bin/bash

# network-connectivity plugin
# should run as a background process
#     * ECO1 network-status-probe - runs in a loop, updates every 15 secs
#         * check DNS connectivity
#         * check NIC status
#         * check VPN status

RESOLV="/etc/resolv.conf"
DNS_SERVER=$(cat $RESOLV | grep nameserver | awk '{print $2}')
ON="🕷"
WIFI="📶"
VPN="🔒"
PING_OK="0"
NSLOOKUP_OK="0"

while true
  do
  echo -n " "
  if $(ip link show | grep wlp1s0 | grep LOWER_UP > /dev/null); then
  echo -n $WIFI
  fi

  if $(ip link show | grep tun0 | grep LOWER_UP > /dev/null); then
  echo -n $VPN
  fi
done >/

# check of dns_changes is older than 1 minute
if test "`find /tmp/dns_changes -mmin +1`"
  then
    touch /tmp/dns_changes
    if ping $DNS_SERVER -c 1 -W 1 -n > /dev/null 2>&1
      then export PING_OK=1
fi

if nslookup www.google.com -timeout=1 > /dev/null 2>&1
then export NSLOOKUP_OK=1
fi

if [ $PING_OK = "1" -a $NSLOOKUP_OK = "1" ]
then
echo -n $ON" " > /tmp/dns_status
else
echo > /tmp/dns_status
fi
fi

echo -n $(cat /tmp/dns_status)

  echo -n " |"
