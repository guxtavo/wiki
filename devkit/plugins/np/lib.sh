#!/bin/bash

# create control file if doesn't exist
function check_control_file()
{
  if test ! -e $FILE_CHECK
    then touch $FILE_CHECK
  fi
}

function check_timer_expired()
{
  # check if $FILE_CHECK is older than 1 minute
  # BUG: no granularity
  if test "`find $FILE_CHECK -mmin +1`"
    then
      touch $FILE_CHECK
      trigger_nic_probes
  fi
}

function trigger_nic_probes()
{
  # Output: 0|1 0|1
  if $(ip link show wlp1s0 | grep LOWER_UP > /dev/null)
  then
    export NIC_WIFI_UP="1"
  fi

  if $(ip link show tun0 | grep LOWER_UP > /dev/null)
  then
    export NIC_VPN_UP="1"
  fi
}

trigger_gwping_probe()
{
  if ping $GATEWAY -c 1 -W 1 -n > /dev/null 2>&1
    then export PING_GW_OK=1
  fi
}

trigger_dnsping_probe()
{
  # Output: 0|!
  if ping $DNS_SERVER -c 1 -W 1 -n > /dev/null 2>&1
    then export PING_DNS_OK=1
  fi
}

trigger_nslookup_probe()
{
  # Output: 0|1
  if nslookup $EXAMPLE_DOMAIN -timeout=1 > /dev/null 2>&1
    then export NSLOOKUP_DNS_OK=1
  fi
}

function trigger_vpn_probe()
{
  # Output: 0|1
  VPNGW="PRG"
  STOPPED="Stopped OpenVPN tunneling"
  STARTED="Initialization Sequence Completed"
  NET_UNR="Network is unreachable"
  RESTART="Restart pause, 5 second"
  CONNECTING="Attempting to establish TCP connection with"
  NOTE1="NOTE: --mute triggered"

  LINE=$(sudo systemctl status openvpn@SUSE-$VPNGW | tail -1)

}

function trigger_full_check()
{
  # PING & DNS
}
