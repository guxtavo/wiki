# 2020

## W26
    * Thursday
    * Friday
    * Saturday
      * wiki: how to block distractions with devkit
      * wiki: review 1-feedback.md - sort things
      * plan next week

## W32
    * Friday (FTO)
      * rewrite weather system
      * rename some files

## W35
    * Friday (FTO)
      * deploy germ55.suse.cz
      * open install moodle document
      * zypper in apache mariadb php git
      * git clone moodle
      * start mariadb
      * setup mariadb
      * run mysql_secure_installation
      * setup unix_socket auth
      * create moodle database moodle/educator2020
      * move git checkout to /srv/www/
      * enter /src/www/moodle
      * copy config-dist.php to config.php
      * edit config.php
      * start and enable apache
      * install php7-mysql package
      * zypper in php7-mbstring php7-curl php7-openssl php7-zip php7-zlib\
        php7-gd php7-intl php7-fileinfo
      * install_database
      * setup cron
      * configure firewall and enable TCP/80 > yast2
      * zypper in apache2-mod_php7
      * configure mod_php7 in /etc/sysconfig/apache2
      * restart apache
      * configure apache to allow access to moodle
      * login to moddle (admin/educator2020)
      * systemctl set-default multi-user.target

## W37
    * Monday
      * Export ics from google calendar
      * rm -rf ~/.calcurse
      * calcurse -i  tmp/xxxxxxxxxx@gmail.com.ics
      * Add $(calcurse -n | tail -1) to status bar
      * Write ~/wiki-calendar.sh prototype
        -> Before the event starts, the output is: [00:07] Wiki (code)
        -> After the event start, the output is: next -> broken
        -> how to find which event is happening now
            * First you need the current time
      * https://github.com/lfos/calcurse/issues/314
    * Tuesday
      * Fix ~/wiki-time.rb -> rename to wiki-event-now.rb
      * Refresh ICS from google
      * Fix ~/wiki-calendar.sh -> rename to wiki-parse-todays-calendar.sh
      * Write a wrapper -> ~/wiki-calendar-wrapper.sh
      * Move scripts to git/wiki
      * Add wrapper to connectivity.sh
      * Add function to plugins/st.sh
      * Add a hook to shell.sh

## W38
    * Monday - Programmer
      * Work on ping_router -> hardcode l3mule in the ping_router script
      * how to call parse-todays-calcurse.sh in a systemd timer
      * https://medium.com/@thiagokokada/systemd-timers-are-awesome-b2e79737a869
      * Persistent=True
      * create a service file at .config/systemd/user
      * call it with: "systemctl --user start calcurse.service"
      * create a timer file at .config/systemd/user (same name as the service)
      * systemctl --user start calcurse.timer
      * systemctl --user enable calcurse.timer

        09:56 <mkoutny_away> hi, and I see there can be hooks in
        /usr/lib/systemd/system-sleep/ but that's not how this is implemented,
        maybe it's just that internal timer timed out, as a control you'd need
        to try suspend-resume with Peristent=no

      * shell.sh: enhance netstatus check
      * create ~/wiki-proto-status.sh
    * Monday - Project Manager
      * git commit -p
      * git push (16 commits)
      * git log --pretty=format:"%h%x09%an%x09%ad%x09%s"

## W40
    * Tuesday - C
      [ ] cdecl explain 'static int nums[5];'
      [x] annotate sololearn-return-a-pointer.c with cdecl
      [x] open sololearn lesson
      [x] add ITER as argument to get_evens()
      [x] add one argument to get_evens() -> int inter
      [ ] improve your artifact and understanding
    * Wednesday - w3schools
      [ ] bootstrap 4 example plage

## W41
    * Monday - bash
      [x] webserver script - add iptables rule and key to exit
      [x] change l3mule fqdn for the IP: 10.160.3.98
      [x] do not show hogs, show as 0 or 1
      [x] move hogs output next to netstatus
      [x] commit changes
    * Tuesday - C
      [x] open sololearn-return-a-pointer.c
      [x] ask questions to Jarow
      [x] what's next, what you cannot explain from reading the code
      [ ] figure out what it means line 34: static int nums[5];
      [ ] why the code segfaults when ITER > 1008 ?
      [ ] why nums is an array 5 of int?
      [ ] open sololearn and try do do the exercises
      [ ] how can I create nums with the same size as ITER?
      [x] static int nums[iter]; -> "storage size of 'nums' isn't constant"
      [x] record jarows answer in the file
    * Wednesday - bootstrap
      [x] open w3schools bootstrap chapter
      [x] open wiki-bootstrap-example.html on editor and browser
      [ ] create a page for your ptfrepos
      [ ] how to change theme? eos-ds
      [ ] https://suse.eosdesignsystem.com/layout
      [ ] npm i --save eos-ds
      [ ] git clone  https://gitlab.com/SUSE-UIUX/eos-ds-npm
      [ ] ~/barendartchuk/l-t.pdf

## W42
    * Monday - wiki
      [x] hogs.sh: fix random issue with proc name
      [x] hogs.sh: run in a loop
      [x] hogs.sh: can I reproduce?
      [x] git commit -p # hogs.sh
      [x] bin/event-now.rb: check if file exists before loop
      [x] git commit -p # event-now.rb
      [x] comment targets() in shell.sh (not used)
      [x] inspect solidground_progress()
      [x] simulate the problem -> rm /dev/shm/{solidground,bugzilla_http_status)
      [x] create fix-suse-data.sh
      [x] solidground_progress() - check if files are empty
    * Tuesday - C
      [x] open sololearn-return-a-pointer.c
      [x] process notes from Jarow
      [x] improve your artifact and understanding
      [x] move free() to the correct place
      [x] move sololearn-return-a-pointer.c to wiki/blg/dev/c/
    * Wednesday - bootstrap
      [x] review ~/barendartchuk/l-t.pdf
      [x] open wiki-bootstrap-example.html on editor and browser
      [ ] open w3schools bootstrap chapter
      [ ] create a page for your ptfrepos
      [ ] how to change theme? eos-ds
      [ ] https://suse.eosdesignsystem.com/layout
      [ ] npm i --save eos-ds
      [ ] git clone  https://gitlab.com/SUSE-UIUX/eos-ds-npm

## W43
    * Monday - wiki
      [x] aim!!! -> share knowledge and educate people about open source
    * Tuesday - C
      [x] open git/wiki/blg/dev/c/sololearn-return-a-pointer.c
      [x] cd git/wiki/blg/dev/c; cg sololearn-return-a-pointer.c
      [x] clarify the for loop syntax (init, condition, step)
      [ ] search: c for loops without step increment
      [ ] how to make the for loop without the k variable
      [ ] in a for loop, the step (as in init, condition, step) does dot have
          to be an increment (k++)
      [ ] check why gcc complains about:

            sololearn-return-a-pointer.c:33:42: warning: conversion to ‘long
            unsigned int’ from ‘int’ may change the sign of the result
            [-Wsign-conversion]
            33 |     int* nums = (int*)malloc(sizeof(int) * iter);
               |                                          ^


          for loop syntax:
                                          Does not have
                                            to be an
                                            increment
                                           /
                  for (init, condition, step)

# Modes to think about

    * Programmer - writes code fixing bugs
    * Project Manager - writes status report, push commits
    * Product Manager - plans the vision and next steps

# Undone tasks

## Bugs

    * [ ] calcurse can no longer import from Google Calendar
    * [ ] devkit: fix bug where solidground data is lost during reconnect
    * [ ] bugzilla info and incidents gets broken after reboot
    * [ ] nmcli-add.sh doesn't work if ssid has " " (spaces)
    * [ ] weather errors comming back from sleep (maybe I should check if I
          just came back from sleep?

## Features

    * vim "coc" plugin
    * w3m - research how to use tabs
    * w3m - research how to show numbers before links (how to use)
    * w3m - research how to show line numbers
    * tools: ~/git/sent (presentations made easy)

    * mk-2 -> git/wiki/RTFM/index.md

    * wiki: index.md: add objectives and key results
    * wiki: how to start breathing.sh after a timer?
    * wiki: how to block distractions with devkit

    * moodle: create a sample course
    * moodle: setup dark theme
    * moodle: setup google oauth2
    * moodle: configure self-signed certificate

    * lrn: cli.space services: pmo(hire), rtfm, botcamper
    * lrn: write the "quiz editor"
    * lrn: write status report
    * lrn: write the "multiplayer layer"
    * lrn: write the "cli frontend app"
    * lrn: status report: suggest next 3 areas of improvement based on history

    * website: register cli.support
    * website: create CNAME for lrn.cli.support
    * website: create CNAME for git.cli.support
    * website: create CNAME for www.cli.support
    * website: spin a vm in gcn - which distro?
    * website: write salt pillars for git.cli.support
    * website: write salt pillars for www.cli.support
    * website: write salt pillars for lrn.cli.support
