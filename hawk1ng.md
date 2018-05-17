% hawk1ng project
% Gustavo Figueira

# what is it?

hawk1ng is the development platform to build a low cost cubesat. It is build
upon a Pi3, and currently it is working as a home router. It will also be a
test bed for WoK. It runs DHCPD, HostAPD, SSHD, iptables, bandwidthd and
apache2.

# display

The appliance will have a small LCD screen, which will display the following
information:

   Brno 9-11°C                  [19] Tue 05-08 09:15

   Download:  13  GB        19  04 10 17 27 37 47 57
   Upload  : 0.2  GB        20  07 17 27 37 47 57
                            21  07 16 31 46
   Local Temp: 25C

# todo
  * build script for display
  * buy temperature sensor
  * buy display

# Pi 3 Leds

       ACT   green   card status   flashing during SD card activity
       PWR   red     power         power good indicator that goes
                                   off when power drops below 4.65V

# appliance creation

## writing img to sdcard

  sudo dd bs=4M if=2017-11-29-raspbian-stretch-lite.img \
  of=/dev/mmcblk0 status=progress conv=fsync

  sudo touch /run/media/gfigueira/boot/ssh

## installing applications

  apt update &&  apt -y upgrade
  apt -y install isc-dhcp-server hostapd apache2 bandwidthd

## configuring dhcp

cp ~/git/wiki/hawk1ng/dhcpd.conf /etc/dhcp/
cp ~/git/wiki/hawk1ng/isc-dhcp-server /etc/default/
cp ~/git/wiki/hawk1ng/interfaces /etc/network/
cp ~/git/wiki/hawk1ng/hostapd.conf /etc/hostpad/
cp ~/git/wiki/hawk1ng/iptables.ipv4.nat /etc/
cp ~/git/wiki/hawk1ng/sysctl.conf /etc/
