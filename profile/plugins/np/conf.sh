#!/bin/bash

# global variables
RESOLV="/etc/resolv.conf"
FILE_CHECK="/dev/shm/dns-checker"
EXAMPLE_DOMAIN="www.google.com"
DNS_SERVER=$(cat $RESOLV | grep nameserver | awk '{print $2}')
GATEWAYW_SERVER=$(ip route show default | awk '{print $3}')
NIC_WIFI="🛰"
NIC_VPN="🔓"
NIC_VPN_CONNECTED="🔐"
GW="🐙"
DNS_ON="🕷"

# statuses
NI_WIFI_UP="0"
NIC_VPN_UP="0"

PING_GW_OK="0"
PING_DNS_OK="0"
NSLOOKUP_DNS_OK="0"
SYSTEMD_VPN_STATUS="0"
