#!/bin/bash
#
# np - system-wide network checker, with VPN and DNS probes
# TODO: write tests - block dns with iptables to simulate disconnection
#
# input:
# output: $NIC $VPN $DNS
# constraints: 1) save as much bandwidth as possible
#              2) be granular after and before wakeup
#              3) try harder when disconnected
# edge cases:

source ~/git/wiki/profile/plugins/np/conf.sh
source ~/git/wiki/profile/plugins/np/lib.sh

function main()
{
  check_control_file
  check_timer_expired                # calls trigger_nic_probes to find up IFCE

  if [ $NIC_WIFI_UP = "1" ]; then
    trigger_gwping_probe             # find if gateway is reachable
  fi

  if [ $NIC_VPN_UP = "1" ]; then
    trigger_vpn_probe                # find if openvn is conneted

    if [ $SYSTEMD_VPN_STATUS = "1" ]; then
      trigger_dnping_probe           # find if dns is reachabel

      if [ $PING_DNS_OK = "1" ]; then
        trigger_nslookup_probe       # find if dns resolves
      fi
    fi
  fi

  echo $NIC_WIFI_UP $NIC_VPN_UP $PING_GW_OK $SYSTEMD_VPN_STATUS \
       $PING_DNS_OK $NSLOOKUP_DNS_OK \
}

main
