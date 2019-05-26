# documentation

% NAME

	debug - assists on gathering kernel and userspace debugging data for
	SUSE L3 Support. 

	supportconfig - Gathers system troubleshooting information

% SYNOPSIS

debug (list|status|activate|deactivate|gdb) <package> <subsystem> <options>

% DESCRIPTION

debug assists the administrator in setting the correct system configurations
using salt in order to collect debugging data without losing the time. Once the
capture is deactivated, a tarball path is printed and this file can be attached
to Bugzilla.

From kernel to userspace

debug tries to cover kernel ftrace, perf, vmcore, core dump, tcpdump and other
kernel instrumentations when supportconfig lacks information for a complete
analysis. It also tries to assist other userspace applications like basesystem,
systemd, yast, samba, xen, or any other component that requires constant
debugging in support.

GDPR and data sensitivity

There is no prunning of sensitive data, as the nature of the activity requires
full desclosure. Please discuss with your Support representative if you have
questions.

% EXAMPLES

	debug list : list all package templates
	debug list -p package : list scenarios inside a template
	debug activate -p perf -s needle : enable perf debugging with the
									 'default' scenario
	debug collect -p perf -s all : collect all scenarios for package perf 
	debug help - shows short help screen

% AUTHOR
		Gustavo Figueira <gfigueira@suse.com>

% SEE ALSO

supportconfig(8), getappcore(8)

% HISTORY

I had an idea but perhaps it is too big for a hackweek. I want to create a
shell utility that can 'assist enabling/disabling debugging in linux'. Kernel
and userspace. The list of things is huge, but I haven't thought about
implementation yet (although I have written a tiny prototype)


# prototype

## listing packages and scenarios

This function will scan the content of debug/ and show each package listed and
the number of scenarios the package has.
		
		## Input: list
		## Output: package name: number of scenarios
		## Constraints:
		## Edge cases:


		## Template
		## Input:
		## Output:
		## Constraints:
		## Edge cases:

	TODO

		make salt states for L3/kernel_tracing/

		prepare the skeleton with getops - borrow code from supportutils

# packages

For every package, there will be a script which will have the following
skeleton:

	# <package name>
	# function to activate
	# function to deactivate
	# function to collect

## NetworkManager

The issue is triggered after comming back from sleep mode

### function to activate

		# # requires_restart=1
		# backup /usr/lib/systemd/system/NetworkManager.service
		# sysadd '--debug' to 'ExecStart' in /usr/lib/systemd/system/NetworkManager.service
		# systemctl daemon-reload
		# systemctl restart NetworkManager

### function to deactivate

		# rollback /usr/lib/systemd/system/NetworkManager.service
		# systemctl daemon-reload
		# systemctl restart NetworkManager

### function to collect data

		# # 1 check if process is starte with debug
		# ps fax | grep NetworkManager | grep debug
		# # 2 check the logs
		# journalctl -u NetworkManager -b

## perf 

### function to activate
### function to deactivate
### function to collect data

## tcpdump

## 

## gdb

		# gdb --pid=$(pidof NetworkManager)
		(gdb) gcore
		Saved corefile core.26426
		(gdb) detach
		# getappcore core
 		# # or
		# gcore $(pidof NetworkManager)
		# getappcore core

		gdb usr/sbin/NetworkManager core.17291
