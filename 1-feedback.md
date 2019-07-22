% status-report and feedback system
%
% Feed this from "journal"
% Feed this from "git log -p"

# 2019-07-15

Tried adding "master volume" to i3status but although I follow the links and
manual pages to the letter, I cannot get it to working. So I thought I could
add a script to i3status, but it is not so easy. Turns out I need to add
i3status to a script:

    #!/bin/bash

    i3status | while :
    do
        read line
        gmail=`perl gmail.pl`
        echo "GMAIL $gmail | $line" || exit 1
    done

It ended up being a typo in i3status.conf.

Add i3 and i3status to dotfiles. Remove .l3t.conf and add .l3t.yaml (removing
the auth-token).

# 2019-07-14

## ECO - elapsedtime in a loop.

Build a prototype that behaves like i3status, that is, runs the main loop only
when N seconds have elasped since the last time.

    ~/git/wiki/bin/line_every_N_secs.sh

Modify shell.sh to behave in a way that can run inside the loop (commit
3bbd150349cd2).

This approach didn't work with tmux for OpenBSD (tests with Linux werent'
made).

## Hogs

Implement the "hogs" for OpenBSD. The Linux version kept working except when
sourcing bin/openbsd_list_hogs.sh as "systat" binary doesn't exist in Linux.

In hindsight it might be worth to source the file inside the if statement that
checks for OpenBSD. Doing this will not yield the error on Linux systems.

What are the outstanding bugs remaining and a short description:

    * ECO01 - build a system-wide network prober

# 2019-04-01

	* Finally moved to i3 (still with gnome-terminal)
	* working on prototype for ECO02 (np)
	* still don't know how to track pull requests
		From gitlab it's easy:

		 $ w3m -dump
		https://gitlab.suse.de/gfigueir.atom?feed_token=26rq5ZPRvrhci2NsSFQ1 | grep
		"<link" | grep merge_reques

	* from github you need to check the api further