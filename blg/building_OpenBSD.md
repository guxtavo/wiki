% How to get building OpenBSD -current

# start over

I have picked up this machine couple days ago. It was running 6.2 and by
reading the faq I discover how to update:

	# cd /
	# ftp https://cdn.openbsd.org/pub/OpenBSD/6.3/bsd.rd
	# reboot
	boot> /bsd.rd
	Do the upgrade and reboot

Repeat the same for 6.4 and in less than half hour I have the system up
and running. The 'syspatch' to bring the latest binary patches.

Now I move to building. First I need to start over. I delete the files
inside /usr/src after adding my user to the 'wsrc' group. 

	# doas usermod -G wsrc gfigueira

This requires a new login. Like a real one, not just another terminal
in Xserver. I had to open the second text tty and then I could write
in the directory.

Then I add the following to '~/.profile' so I get a mirror nearby

	export CVSROOT=anoncvs@mirror.osn.de:/cvs
	$ cd /usr
	$ cvs -q checkout -rOPENBSD_6_4 -P src

This will fetch -stable. If I want to 'git pull':

	$ cd /usr/src
	$ cvs -q up -Pd -rOPENBSD_6_4

For -release use -rOPENBSD_6_4_BASE. Then I read release(8) and to build
the kernel you run

	$ cd /sys/arch/$(machine)/compile/GENERIC.MP
	$ doas make clean
	$ doas make obj
	$ doas make config
	$ doas make -j4
	$ doas make install

	The current kernel is copied to /obsd and
	the new kernel to /bsd. Reboot.

# whats next?
	* ksh history
