
                     ##    ##   ###    ##   ##   ##      ##
                     ##    ##   ####   ##   ##    ##    ##
                     ##    ##   ##  #  ##   ##     ##.###
                     ##    ##   ##   # ##   ##     ###.##
                     ##    ##   ##    ###   ##    ##    ##
                      ######    ##    ###   ##   ## wiki ##

                                 sh +  c  + md
                               git + tmux  + vim
                             osc +  ptfutils + salt
                           kernel-space and users-space
                               advanced debugging


                  ######  ######  ##  ##  #####    #####  #######
                 ##    ## ##  ##  ##  ##  ##  ##  ##    # ##
                 ##       ##  ##  ##  ##  ##  ##  ##      ##
                 ######   ##  ##  ##  ##  #####   ##      ######
                      ##  ##  ##  ##  ##  ##   #  ##      ##
                #     ##  ##  ##  ##  ##  ##   #  ##    # ##
                 #####    ######  #####   ##   #   #####  #######

                   ######      ######      ######      ########
                  ########    ########     #######     #######
                  #          #        #    #     ##    ##
                  #          #        #    #     ##    #####
                  #          #        #    #     ##    ##
                  ########    ########     #######     #######
                   ######      ######      ######      ########

                    ######   ######  ######   ##  ##  #######
                    ##   ##  ##      ##   ##  ##  ##  ##
                    ##   ##  ####    ######   ##  ##  ## ####
                    ##   ##  ##      ##   ##  ##  ##  ##    #
                    ######   ######  ######   ######  #######



                             PLNNR FIT ARF SVV L3
                             CZ  C  SIM  AFH  BKS
                             GUI  RL  TC  NP  UWK

                             MSC MFR  KRNL SGR 2∞
                             RPG  JP  WS H1  SPCX


# Unix Wiki - Directory structure

  afh_epub     - Airplaine Flying Handbook epub convertion efforts
  articles     - random texts
  bin          - scripts and prototypes
  book         - the engineer who have flown a raspberry pi cubesat index
  development  - kernel and userspace tools tips
  profile      - sgr shell
  SGR          -
  index.md     - this file you are reading

## FATES
  * pass: Before authenticating, save passwords in password-store
  * wiki: fix network check - show a DNS emoji if dns is up and responding

  * wiki feature: 🎯 should have PRs and PTFs
  * wiki feature: add gimbal🌎, attitude NNN and altitude
  * wiki feature: create simultaneos alarms and use tmux to notify
  * hawk1ng:  httpd(gitlab, CMS), NTPD, DNS, DHCP and PXE
  * fElapsedTime
  * SGR Products




### github warnings

(0) wiki 🚀 git push origin master
Username for 'https://github.com': guxtavo@gmail.com
Password for 'https://guxtavo@gmail.com@github.com':
Enumerating objects: 1606, done.
Counting objects: 100% (1606/1606), done.
Delta compression using up to 4 threads
Compressing objects: 100% (1598/1598), done.
Writing objects: 100% (1600/1600), 237.30 MiB | 188.00 KiB/s, done.
Total 1600 (delta 42), reused 0 (delta 0)
remote: Resolving deltas: 100% (42/42), completed with 4 local objects.
remote: warning: GH001: Large files detected. You may want to try Git Large
File Storage - https://git-lfs.github.com.
remote: warning: See http://git.io/iEPt8g for more information.
remote: warning: File SGR/EarthBound_-_1995_-_Nintendo.pdf is 58.43 MB; this is
larger than GitHub's recommended maximum file size of 50.00 MB
remote: warning: File afh_epub/afh/airplane_flying_handbook.pdf is 89.93 MB;
this is larger than GitHub's recommended maximum file size of 50.00 MB
To https://github.com/guxtavo/wiki.git
   bca600a..7330c27  master -> master

### fElapsedTime

  * how to add fps or fTimeElapsed to status bar like a game engine?
  * olcConsoleGameEngine.h && mode7.cpp - functions yacc
    -> setup a buffer
    -> create update function

I open the laptop's lid and immediatelly check the battery time remaining. I
get confused understanding what the indicator is showing me as first I see a
bit more than 2 hours and I know that when fully charged this laptop can give
up to 7 hours or more of battery time.

The time varies from 50 minutes to 7 and a half hours - now that I think of
it, tmux status bar shouldn't be constantly refreshing as I set
status-interval at 30

I must make status bar run out of tmux every time interval ( 60 seconds ) and
write to a file. I will then have tmux to just tail the file. I can time every
run and have this as metadata, so I can graph backwards what has been the
performance (need more on this)

### SGR products

  200OK Case
  200OK PCB
  200OK sgr-boot
  200OK sgr-shell
  200OK sgr-david   david.sgr.cz
  200OK sgr-remote  tmate.suse.de
