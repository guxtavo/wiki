#!/bin/ksh

############
# Learning #
# OpenBSD  #
############

# I've just installed OpenBSD 6.1 on my workstation, and I want to create a vm 
# to be able to install git and access some repos. My machine has "em0"
# interface connected to my physical router (192.168.1.1). How do I get vmd
# running, and get access to the vm?
#
# I just have access to OpenBSD and I want to get minimal access to ports (I try
# to keep everything in a terminal). The default xterm doesn't have a big enough
# font, so in order to fix that I do:
#
#	xterm -fn heb8x13 &
#
# The man pages are well documented, and most can be achieved from them, but 
# ocasionally I will need access to OpenBSD faq, so I need to install a good 
# web browser:
#
#	pkg_add w3m # choose option 2

# this script will setup your OpenBSD 6.1 for virtualization. 
# it assumes you have em0 interface, want to create vether0, bridge0
# and want to serve the range 10.8.7.* (10.8.7.1 as gw)

# create a vether(8) device - /etc/hostname.vether0
echo "inet 10.8.7.1 255.255.255.0 10.8.7.255" > /etc/hostname.vether0

# create a bridge(4) device - /etc/hostname.bridge0
echo "add vether0" > /etc/hostname.bridge0
echo "add em0" >> /etc/hostname.bridge0
echo "up" >> /etc/hostname.bridge0

# start new interfaces
sh /etc/netstart vether0
sh /etc/netstart bridge0

# create dhcpd.conf
echo "subnet 10.8.7.0 netmask 255.255.255.0 {" > /etc/dhcpd.conf
echo "	option domain-name-servers 8.8.8.8;" >> /etc/dhcpd.conf
echo "	option routers 10.8.7.1;" >> /etc/dhcpd.conf
echo "	range 10.8.7.100 10.8.7.108;" >> /etc/dhcpd.conf
echo "}" >> /etc/dhcpd.conf

# enable dhcpd and other daemons
rcctl enable dhcpd
rcctl set dhcpd flags vether0
rcctl start dhcpd
rcctl set apmd flags "-A"
rcctl set ntpd flags "-s"
rcctl start apmd
rcctl start ntpd

# create disk image
mkdir /home/vms/
cd /home/vms
vmctl create /home/vms/openbsd61-git-0917.img -s 2G

echo "switch "switch0" {" > /etc/vm.conf
echo "	add vether0" >> /etc/vm.conf
echo "	interface bridge0" >> /etc/vm.conf
echo "}" >> /etc/vm.conf

echo "vm "openbsd61-git-0917" {" >> /etc/vm.conf
echo "	memory 512M" >> /etc/vm.conf
echo "	disk \"/home/vms/openbsd61-git-0917.img\" >> /etc/vm.conf
echo " 	interface { switch \"swicth0\" }" >> /etc/vm.conf
echo "}" >> /etc/vm.conf

rcctl enable vmd
rcctl start vmd

# configure pf and ip forwarding
sysctl net.inet.ip.forwarding=1 
echo "net.inet.ip.forwarding=1" >> /etc/sysctl.conf

/etc/pf.conf (add)
echo "ext_if=\"em0\"" >> /etc/pf.conf
echo "int_if=\"{ vether0 tap0 tap1 tap2 tap3 tap4 tap5 tap6 tap7 }\" >> /etc/pf.conf
echo "set block-policy drop" >> /etc/pf.conf
echo "set loginterface egress" >> /etc/pf.conf
echo "match in all scrub (no-df random-id max-mss 1440)" >> /etc/pf.conf
echo "match out on egress inet from !(egress:network) to any nat-to (egress:0)" >> /etc/pf.conf
echo "pass out quick inet" >> /etc/pf.conf
echo "pass in on $int_if inet" >> /etc/pf.conf
echo "pass in on egree inet proto tcp from any to (egrees) port 22" >> /etc/pf.conf

# restart pf
pfctl -d
pfctl -e

# create vm
vmctl start -c -b /bsd.rd -m 512M -i 1 -d /home/vms/vm1.img
ifconfig bridge0 add tap0
vmctl status
vmctl console 0
