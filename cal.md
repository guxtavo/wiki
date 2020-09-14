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
    * Monday
        * Work on ping_router -> hardcode l3mule in the ping_router script
        * how to call parse-todays-calcurse.sh in a systemd timer
        * Persistent=True
        * create a service file at .config/systemd/user
        * call it with: "systemctl --user start calcurse.service"
        * create a timer file at .config/systemd/user (same name as the service)
        * systemctl --user start calcurse.timer
        * systemctl --user enable calcurse.timer



# undone tasks


    * connectivity.sh: new openvpn doesn't let me ping my router (ping l3mule)

(0) ~ $ ip a show dev tun0
19: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UNKNOWN group default qlen 100
    link/none
    inet 10.163.16.46 peer 10.163.16.45/32 scope global tun0
       valid_lft forever preferred_lft forever
    inet6 2620:113:80c0:8350::100a/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::9848:d9a0:6176:69aa/64 scope link stable-privacy
       valid_lft forever preferred_lft forever


    * moodle: create a sample course
    * moodle: setup dark theme
    * moodle: setup google oauth2
    * moodle: configure self-signed certificate

    * bin: nmcli-add.sh doesn't work if ssid has " " (spaces)
    * connectivity.sh: check l3slave connectivity
    * connectivity.sh refactor bugzilla check
    * devkit: refactor display_targets()
    * devkit: refactor solidground_progress()
    * devkit: fix bug where solidground data is lost during reconnect

    * lrn: vim "coc" plugin
    * tools: ~/git/sent (presentations made easy)
    * lrn: w3m - research how to use tabs
    * lrn: w3m - research how to show numbers before links (how to use)
    * lrn: w3m - research how to show line numbers
    * lrn: cli.space services: pmo(hire), rtfm, botcamper
    * mk-2 -> git/wiki/RTFM/index.md

    * website: register cli.support
    * website: create CNAME for lrn.cli.support
    * website: create CNAME for git.cli.support
    * website: create CNAME for www.cli.support
    * website: spin a vm in gcn - which distro?
    * website: write salt pillars for git.cli.support
    * website: write salt pillars for www.cli.support
    * website: write salt pillars for lrn.cli.support

    * lrn: write the "quiz editor"
    * lrn: write status report
    * lrn: write the "multiplayer layer"
    * lrn: write the "cli frontend app"
    * lrn: status report: suggest next 3 areas of improvement based on history

    * wiki: index.md: add objectives and key results
    * wiki: how to start breathing.sh after a timer?
    * wiki: how to block distractions with devkit

# template
## W
    * Thursday - write code (execution)
    * Friday - status report (pmo)
    * Saturday - plan next week (vision)
