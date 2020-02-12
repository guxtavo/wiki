% status-report and feedback system
%
% Feed this from "journal"
% Feed this from "git log -p"

# New vim shortcuts

    vim - replace ^M for carriage return
    :%s/<Ctrl-V><Ctrl-M>/\r/g

    ctrl+x            = gqip
    ctrl+n twice      = set nonu
    ctrl+m twice      = set textwidth=72
    ctrl+a            = set autoindent

# Outstading bugs

    * posite and negative temp in weather_parse_data()
    * remove wallpaper from dm
    * add plymouth animation to initrd
    * deploy new passwords
    * tumbleweek tmux 2.9a-2.5 bad, 2.9a-1.2 good (irssi scrolling mess)
    * solidground data is lost during reconnect
    * find a sound for start.sh
    * auto start terminal with "tmux-light" at i3 startup
    * auto start devkit/plugins/connectivity.sh at i3 startup
    * fix fortune path in .common.sh

# ECOs

    * create script to create plymouth animation by reading the filesystem
      files
    * change enc in openssl to a good one
    * pi - install gpg and use password-store
    * fix ~/.i3status.conf on armv6l to show correct percentage
    * connectivity.sh
        * check l3slave connectivity
        * port for for OpenBSD
        * make ping_sites behave like its simblings
        * Integrate other plugins with netstat-probe
    * improve execution time in mk1
    * C programming language - exercise 1-6
    * show screen FPS (refresh rate from X11?)
    * intergrate calendaring from google (at least show and notify)
    * suspending when lid is closed (also run i3lock)
    * move gmail to mutt

# 2020-02-11

    * Move wiki/SGR to wiki/RTFM
    * Move wiki/profile to wiki/devkit
    * Implement f9.sh and start.sh
    * Write on wiki/RTFM/benheck.md
    * Workaround weather_parse_data() bug

# 2020-01-07

    * screencast fixed for arm, but it uses all cpu
    * vim-runtime package is needed to syntax highlight
    * rpi doesn't have Master volume, find a way to control volume
    * git_ps1 not found

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
