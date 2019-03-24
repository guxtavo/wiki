#!/bin/ksh
# This is the remade script. The original one from 2005 includes AIX and other
# Operating Systems.
#
# UIT - UNIX Inventory Tool (Linux, HPUX, Solaris)
# V.20081126
# gustavo.figueira-external@gemalto.com
#
# Index
#
#I 1. Operating Systen
#I	1.01 System vmstat
#I	1.02 Version
#I 	1.03 Revision
#I	1.04 Patch level
#I	1.05 Uptime
#I	1.06 Kernel parameters
#I	1.07 Running processes
#I	1.08 motd
#I	1.09 uname
#I	1.10 inittab
#I	1.11 dmesg
#I	1.12 passwd
#I	1.13 group
#I	1.14 shadow
#I	1.15 profile
#I	1.16 Host ID
#I	1.17 Modules
#I	1.18 Cron
#I 2. Hardware
#I	2.01 Devices
#I	2.02 Interruptions
#I	2.03 Processors
#I	2.04 Memory
#I 	2.05 Printers
#I	2.06 Hardware model
#I 3. Software
#I	3.01 Installed sofwares
#I	3.02 Patches
#I 4. Network
#I	4.01 Interfaces
#I	4.02 Routes
#I	4.03 Hosts
#I	4.04 Services
#I	4.05 resolv.conf
#I	4.06 Active conections
#I	4.07 NFS
#I	4.08 NS Switch
#I	4.09 rhosts
#I	4.10 sendmail
#I 5. Storage
#I	5.01 fstab
#I	5.02 df
#I	5.03 Swap
#I	5.04 EMC Symetrix
#I	5.05 VG / DG
#I	5.06 PV
#I	5.07 LV / Volumes
#I	5.08 LVM Backup
#I 6. Cluster
#I	6.01 Cluster stats
#I	6.02 Cluster groups
#I	6.02 Cluster services
#I 7. Oracle
#I	7.01 Oracle SIDs
#I	7.02 Oracle Tablespaces
#I	7.03 Oracle Tables
#I 8. ls -lR /
#I 9. Platform specific
#
# Requeriments
# - ksh, tee, gzip
#
# TODO
#
# - Veritas - HP-UX
# - Add clusters info (Veritas, RedHat, Sun Cluster, Keepalived and Serviceguard)
# - Add performance tests

PATH=$PATH:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
TERM=vt100
export TERM
LOG=/tmp/`uname -s`_`hostname`_`date +%Y%m%d`.txt
export LOG
LOGFILE="/tmp/uit.log"
export LOGFILE
FILE=`uname -s`_`hostname`_`date +%Y%m%d`.txt.gz
export FILE

echo 'connect / as sysdba
set linesize 2000
set head off
set feedback off
select ddf.Tablespace_Name, Sum_Alloc_bytes/1024/1024 tot_mb,
       Sum_Free_Bytes/1024/1024 Sum_free_mb, 100*Sum_Free_Bytes/Sum_Alloc_Bytes AS Pct_Free
from 
	(select Tablespace_Name, SUM(bytes) AS Sum_Alloc_Bytes from DBA_DATA_FILES group by Tablespace_Name) ddf,
	(select Tablespace_Name, SUM(Bytes) AS Sum_Free_Bytes
		from DBA_FREE_SPACE group by Tablespace_Name) fs
where ddf.Tablespace_Name = fs.Tablespace_Name order by PCT_FREE;
exit' > /tmp/tbspace.sql

rm -f $LOG
rm -f /tmp/$FILE

case `uname -s` in

	HP-UX)
		os_vmstat () { vmstat 1 20 ; }
		os_version () { uname -r ; }
		os_revision () { /usr/sbin/swlist -l bundle ; }
		os_level ()  { echo "N/A" ; }
		os_uptime () { uptime ; }
		os_kernel ()   { /usr/sbin/sysdef ; }
		os_processes () { ps -efl ; }
		os_motd () { cat /etc/issue ; }
		os_uname () { uname -a ; }
		os_inittab () { cat /etc/inittab  ; }
		os_dmesg () { /usr/sbin/dmesg ; }
		os_passwd () { cat /etc/passwd ; }
		os_group () { cat /etc/group ; }
		os_shadow ()   { echo "N/A" ; }
		os_profile () { cat /etc/profile ; }
		os_hostid () { uname -i ; }
		os_modules ()  { echo "N/A" ; }
		os_cron () { ls /var/spool/cron/crontabs | while read a; do echo""; echo ""; echo "######CRONTAB######"; echo $a; echo""; echo ""; echo ""; cat /var/spool/cron/crontabs/$a; done ; }

		hw_devices () { /usr/sbin/ioscan -fn ; }
		hw_irqs ()  { echo "N/A" ; }
		hw_proc () { /usr/sbin/ioscan -fnC processor ; }
		hw_mem () { grep -i Physical /var/adm/syslog/syslog.log ; }
		hw_print () { cat /etc/lp/interface/* ; }
		hw_model () { model ; }
	
		sw_installed () { /usr/sbin/swlist ; }
		sw_patches () { /usr/sbin/swlist -l patch ; }
		
		network_interfaces () { lanscan; echo ""; netstat -ni | grep -v Name | while read a b c d e f g h i; do ifconfig $a; done ; }
		network_routes () { netstat -nr ; }
		network_hosts () { cat /etc/hosts ; }
		network_services () { cat /etc/services ; }
		network_resolv () { cat /etc/resolv.conf ; }
		network_conections () { netstat -na ; } 
		network_nfs () { cat /etc/exports ; }
		network_nsswitch () { cat /etc/nsswitch.conf ; }
		network_rhosts () { cat /.rhosts ; }
		network_sendmail () { cat /etc/mail/sendmail.cf; }

		storage_fstab () { cat /etc/fstab ; }
		storage_df () { bdf ; }
		storage_swap () { /usr/sbin/swapinfo ; }
		storage_symetrix () { syminq; echo ""; inq ; } 
		storage_vg () { /usr/sbin/vgdisplay -v ; }
		storage_pv () { /usr/sbin/vgdisplay -v | grep "PV Name" | grep -v Alternate | while read a b c; do /usr/sbin/pvdisplay $c; done ; }
		storage_lv () { /usr/sbin/vgdisplay -v | grep "LV Name" | grep -v Alternate | while read a b c; do /usr/sbin/lvdisplay $c; done ; }
		storage_backup () { echo "N/A" ; }
		
		oracle_sids () { ps -ef | grep pmon | grep -v grep | awk {'print $8'} | cut -f 3 -d "_" | tee -a /tmp/list; }
		oracle_tbs () { while read i; do export ORACLE_SID=$i; echo "" ; echo "#############################" ; echo "" ; echo $i ; echo "" ; echo "#############################" ; echo "" ; su - oracle -c "/opt/oracle/9.2.0/bin/sqlplus /nolog @/tmp/tbspace.sql" ; done < /tmp/list ; }
		oracle_tables () { echo "" ; }
		
		storage_ls () { nice -n 17 ls -lR / ; }
		
		especific () { print_manifest ; }
		;;

	Linux)
		os_vmstat () { vmstat 1 20 ; }
		os_version () { if [ -e /etc/redhat-release ]; then cat /etc/redhat-release; fi ; if [ -e /etc/lsb-release ]; then cat /etc/lsb-release; fi ; }
		os_revision () { uname -r ; }
		os_level () { echo "N/A" ; }
		os_uptime () { uptime ; }
		os_kernel () { sysctl -a ; }
		os_processes () { ps -efl ; }
		os_motd () { cat /etc/motd ; }
		os_uname () { uname -a ; }
		os_inittab () { cat /etc/inittab  ; }
		os_dmesg () { dmesg ; }
		os_passwd () { cat /etc/passwd ; }
		os_group () { cat /etc/group ; }
		os_shadow () { cat /etc/shadow ; }
		os_profile () { cat /etc/profile ; }
		os_hostid () { hostid ; }
		os_modules () { lsmod ; }
		os_cron () { ls /var/spool/cron | while read a; do echo""; echo ""; echo "######CRONTAB######"; echo $a; echo""; echo ""; echo ""; cat /var/spool/cron/$a; done ; }

		hw_devices () { lspci -vv ; }
		hw_irqs () { cat /proc/interrupts ; } 
		hw_proc () { cat /proc/cpuinfo ; }
		hw_mem () { free ; }
		hw_print () { cat /var/spool/lpd/lp/* ; }
		hw_model () { uname -m ; }
	
		sw_installed () { rpm -qa ; }
		sw_patches () { echo "N/A" ; }
		
		network_interfaces () { ifconfig -a ; ip addr list ; }
		network_routes () { netstat -nr ; }
		network_hosts () { cat /etc/hosts ; }
		network_services () { cat /etc/services ; }
		network_resolv () { cat /etc/resolv.conf ; }
		network_conections () { netstat -nap ; } 
		network_nfs () { cat /etc/exports ; }
		network_nsswitch () { cat /etc/nsswitch.conf ; }
		network_rhosts () { if [ -e /root/.rhosts ] ; then cat /root/.rhosts ; fi ; }
		network_sendmail () { cat /etc/mail/sendmail.cf ; }

		storage_fstab () { cat /etc/fstab ; }
		storage_df () { df -h ; }
		storage_swap () { swapon -s ; }
		storage_symetrix () { syminq; echo ""; inq ; } 
		storage_vg () { vgdisplay ; }
		storage_pv () { pvdisplay ; }
		storage_lv () { lvdisplay ; }
		storage_backup () { echo "N/A" ; }

		cluster_stat () { clustat ; }
		cluster_groups () { echo "N/A" ; }
		cluster_services () { echo "N/A" ; }
		
		oracle_sids () { ps -ef | grep pmon | grep -v grep | awk {'print $8'} | cut -f 3 -d "_" | tee -a /tmp/list; }
		oracle_tbs () { while read i; do export ORACLE_SID=$i; echo "" ; echo "#############################" ; echo "" ; echo $i ; echo "" ; echo "#############################" ; echo "" ; su - oracle -c "/opt/oracle/9.2.0/bin/sqlplus /nolog @/tmp/tbspace.sql" ; done < /tmp/list ; }
		oracle_tables () { echo "" ; }
		
		storage_ls () { nice -n 17 ls -lR / 2>/dev/null ; }
		
		especific () { echo "iptables-save output"; echo""; /sbin/iptables-save ; echo "lastlog output" ; lastlog ; }
		;;

	SunOS)
		os_vmstat () { vmstat 1 20 ; }
		os_version () { uname -r ; }
		os_revision () { cat /etc/release ; }
		os_level () { uname -v ; }
		os_uptime () { uptime ; }
		os_kernel () { sysdef -i ; }
		os_processes () { ps -efl ; }
		os_motd () { cat /etc/motd ; }
		os_uname () { uname -a ; }
		os_inittab () { cat /etc/inittab  ; }
		os_dmesg () { dmesg ; }
		os_passwd () { cat /etc/passwd ; }
		os_group () { cat /etc/group ; }
		os_shadow () { cat /etc/shadow ; }
		os_profile () { cat /etc/profile ; }
		os_hostid () { hostid ; }
		os_modules () { modinfo ; }
		os_cron () { ls /var/spool/cron/crontabs | while read a; do echo""; echo ""; echo "######CRONTAB######"; echo $a; echo""; echo ""; echo ""; cat /var/spool/cron/crontabs/$a; done; }

		hw_devices () { /usr/platform/`uname -i`/sbin/prtdiag -v ; }
		hw_irqs () { echo "N/A" ; }
		hw_proc () { /usr/sbin/psrinfo -v ; }
		hw_mem () { prtconf | grep Memory ; }
		hw_print () { cat /etc/lp/interfaces/* ; }
		hw_model () { uname -imp ; }
	
		sw_installed () { pkginfo -l ; }
		sw_patches () { patchadd -p ; }
		
		network_interfaces () { ifconfig -a ; }
		network_routes () { netstat -nr ; }
		network_hosts () { cat /etc/hosts ; }
		network_services () { cat /etc/services ; }
		network_resolv () { cat /etc/resolv.conf ; }
		network_conections () { netstat -na ; } 
		network_nfs () { cat /etc/dfs/dfstab; echo""; cat /etc/dfs/sharetab ; }
		network_nsswitch () { cat /etc/nsswitch.conf ; }
		network_rhosts () { cat /.rhosts ; }
		network_sendmail () { cat /etc/mail/sendmail.cf ; }

		storage_fstab () { cat /etc/vfstab ; }
		storage_df () { df -k ; }
		storage_swap () { swap -l; echo "";swap -s ; }
		storage_symetrix () { inq; syminq ; } 
		if [ -x /usr/sbin/vxprint ]; then 
			storage_vg () { vxprint -ht ; }
			storage_pv () { vxdisk list ; }
			storage_lv () { vxprint -vl ; }
			storage_backup () { vxprint | grep "Disk group" | while read a b c; do  vxprint -g $c -shmpv; done ; }
		fi
		if [ -x /usr/sbin/metastat ]; then 
			storage_vg () { metastat -p ; }
			storage_pv () { metastat -r ; }
			storage_lv () { echo "N/A" ; }
			storage_backup () { metadb -i ; }
		fi
		
		oracle_sids () { ps -ef | grep pmon | grep -v grep | awk {'print $9'} | cut -f 3 -d "_" | tee -a /tmp/list; }
		oracle_tbs () { while read i; do export ORACLE_SID=$i; echo "" ; echo "#############################" ; echo "" ; echo $i ; echo "" ; echo "#############################" ; echo "" ; su - oracle -c "/opt/oracle/9.2.0/bin/sqlplus -S /nolog @/tmp/tbspace.sql" ; done < /tmp/list ; }
		oracle_tables () { echo "" ; }
		
		storage_ls () { nice -n 17 ls -lR / ; }
		
		especific () { echo "" ; }
		;;

	*)
		echo "Unsupported system"
		exit 1
		;;
esac

echo "######################################################################" > $LOG
echo "" >> $LOG
echo `hostname` inventory at `date` >>  $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Index" >> $LOG
echo "" >> $LOG
grep "#I" $0 | grep -v grep >> $LOG 
echo "" >> $LOG
echo "######################################################################" >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "           Operating system           " >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "vmstat" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_vmstat >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Version" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_version >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Revision" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_revision >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Patch level" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_level >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Uptime" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_uptime >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Kernel parameters" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_kernel >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Running processes" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_processes >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "motd" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_motd >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "uname" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_uname >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "inittab" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_inittab >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "dmesg" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_dmesg >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "passwd" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_passwd >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "group" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_group >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "shadow" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_shadow >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "profile" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_profile >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Host ID" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_hostid >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Modules" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_modules >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Cron" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
os_cron >> $LOG

echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "           HARDWARE           " >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Devices" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
hw_devices >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Interruptions" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
hw_irqs >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Processors" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
hw_proc >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Memory" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
hw_mem >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Printers" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
hw_print >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Hardware model" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
hw_model >> $LOG

echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "           SOFTWARE           " >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Installed software" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
sw_installed >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Patches" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
sw_patches >> $LOG

echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "           NETWORK           " >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Interfaces" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_interfaces >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Routes" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_routes >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Hosts" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_hosts >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Services" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_services >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "resolv.conf" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_resolv >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Active conections" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_conections >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "NFS" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_nfs >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "NS Swicth" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_nsswitch >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo ".rhosts" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_rhosts >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "sendmail.cf" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
network_sendmail >> $LOG

echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "           STORAGE           " >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "fstab" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_fstab >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "df" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_df >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Swap" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_swap >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "EMC Symetrix" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_symetrix >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "VGs" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_vg >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "PVs" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_pv >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "LVs" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_lv >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "LVM Backup" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_backup >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "ls -lR /" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
storage_ls >> $LOG

echo "" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "Platform specific" >> $LOG
echo "" >> $LOG
echo "######################################################################" >> $LOG
echo "" >> $LOG
echo "" >> $LOG
especific >> $LOG

echo "######################################################################" >> $LOG
echo "The end ;)" >> $LOG
echo "######################################################################" >> $LOG

gzip $LOG
