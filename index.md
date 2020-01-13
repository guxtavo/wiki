
                     ##    ##   ###    ##   ##   ##      ##
                     ##    ##   ####   ##   ##    ##    ##
                     ##    ##   ##  #  ##   ##     ##.###
                     ##    ##   ##   # ##   ##     ###.##
                     ##    ##   ##    ###   ##    ##    ##
                      ######    ##    ###   ##   ## wiki ##



                                       C
                                    sh + md
                                   vim + tmux
                                   git + osc
                                     strace
                                      gdb



               ######   ######   ##  ##   #####     ####   ######
              ##    ##  ##  ##   ##  ##   ##  ##   ##   #  ##
              ##        ##  ##   ##  ##   ##  ##   ##      ##
              ######    ##  ##   ##  ##   #####    ##      ######
                   ##   ##  ##   ##  ##   ##   #   ##      ##
             #     ##   ##  ##   ######   ##   #   ##   #  ##
              #####     ######   #####    ##   #    ####   ######

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


# Directives

                    FIT ARF SVV                   SIM  L3   C
                    GUI  MA  RL                   PLN BKS AFH
                         DP                           UWK


                        .-- MA         AFH --.       .-- UWK
                       /                      \     /
      GUI --- FIT --- RL --- SVV               PLNNR
               /       \                      /  |  \
        ARF --'         '-- DP         BKS --'   |   '-- SIM
                                                L3
                                                 |
                                                 |
                                                 C

     ################################################################
     #                                                              #
     #  FIT - 50 squats and yoga                  gpi case - SIM    #
     #  ARF - diet                                         - L3     #
     #  SVV - order                              sololearn - C      #
     #  GUI - plan vacations                      attitude - PLNNR  #
     #   MA -                     Vso Vs Vfe Va Vx Vy Trim - AFH    #
     #   RL - cuddles and walks            how music works - BKS    #
     #   DP -                                          mk1 - UWK    #
     #                                                              #
     ################################################################

# Structure

    articles        - random blog texts
    bin             - scripts and prototypes
    development     - kernel and userspace tools tips
    profile         - status bar for tmux
    SGR             - Space Grade Research
    1-feedback.md   - Feedback system
    index.md        - This file

# BUGs

    vim - replace ^M for carriage return
    :%s/<Ctrl-V><Ctrl-M>/\r/g

    new passwords - main id on google and amazon
                    main id on suse
                    main id on github (2 factor)

    tumbleweed
    tmux 2.9a-2.5 NOK
    tmux 2.9a-1.2 OK -> zypper la tmux


	BUG01 depends on ECO01

    find shortcuts in vim for:  gqip = ctrl+x
                                set nonu = ctrl+n ctrl+n
                                set textwidth=72 = ctrl+m ctrl+m
                                set autoindent = ctrl+a


    solidground data is wrong during vpn reconnect. The timer for refresh
	is 30 minutes, so this can lead to wrong information displayed for a long
	time.

    The script which waits 30 minutes, has to interact with the network-probe
    in order to know what's going on and maybe try again soonish than the 30
    minutes (more granular).

    Make sure to count PTFs only when connected.

    200 OK - this workstation is not for everybody, it is a niche product

# ECOs

    * ECO01 network-status-probe (np)
        * check DNS connectivity
        * check NIC status
        * check VPN status
        * check l3slave connectivity
		* port for for OpenBSD
        * Integrate other plugins with netstat-probe
    * ECO02 - C programming language - exercise 1-6
    * ECO03 show screen FTPS (refresh rate from X11?)

    * ECO05 intergrate calendaring from google (at least show and notify)
	* ECO06 suspending when lid is closed (also run i3lock)
    * ECO07 cleaup bash history configuration
	* ECO08 display-message when battery goes bellow 30 minutes
    * ECO09 move gmail to mutt
    * ECO10 show builds running in IBS
    * ECO11 AFH epub
    * ECO12 multipath or LVM for rootfs
    * how to fit a raspberry pi 4 inside the raspberry pi keyboard
      * make a 3d copy of the bottom of the rpi keyboard
      * alter the design to be taller in order to fit the pi 4
    * install power button on mk1
    * change hostname to mk1 - hostnamectl
    * make ping_sites behave like its simblings
    * fix weather plugin in arm6vl - add to connectivity.sh
    * change the backgroumd
    * find correct audio device for armv6l in ~/.i3status.conf
    * automate prtscn shortcut in ~/.config/i3/config
    * sync differences in bashrc .tmux.conf and other files
    * adapt .tmux.conf in x86_64 to use different terminal pallet
    * adapt .vimrc in x86_64 to use different terminal pallet
    * add vim shortcuts from armv6l to x86_64 (set nonu and others)
    * merge what's next with ECOS
    * rsync alias
    * pi - disable ipv6
    * pi - fix volume control (F5 and F6)

# SGR development

    Github can offer:                    Hosting
        Issue tracking                      Website
        Wiki                                tmate
        git hosting                         Billing

# 200 OK prototype

                       ______________________________________________
    tmux              | [200 OK]         #########             [   ] |
    and               | -------------------------------------------- |
    vim               | [_] [_][_][_][_][_][_][_][_][_][_][_][_] [_] |
                      |                                         ___  |
    integration       | [ ][1][2][3][4][5][6][7][8][9][0][ ][ ][___] |
    economy           | [__][q][w][e][r][t][y][u][i][o][p][ ][ ][  | |
    orders            | [___][a][s][d][f][g][h][j][k][l][ ][ ][ ][_] |
                      | [___][z][x][c][v][b][n][m][ ][ ][ ][ ][^][ ] |
                      | [__][_][__][____________][_][_][__][<][_][>] |
                      |______________________________________________|

# mk1

mk1 is a rpi official keyboard with a rpi zero w inside it:

  * https://howchoo.com/g/zgmzytq1mmy/raspberry-pi-in-official-pi-keyboard
  * https://blog.pimoroni.com/putting-a-raspberry-pi-3-a-in-the-raspberry-pi-keyboard/
  * https://howchoo.com/g/mwnlytk3zmm/how-to-add-a-power-button-to-your-raspberry-pi

# mk2

For mk2 I will try to fit a rpi4 inside the official rpi keyboard.

I will reproduce in 3D the bottom of the rpi official keyboard case and
then change it to allow fitting a rpi0w and a pi4.

# mk3

Build a version which can fit 3 rpi0w inside the keyboard.

# LED

The capslock led can be used to relay information to the user. Currently
it is used for the screencast script (brink 3 times to warn the user the
screencast has started/stopped.

My idea is to use the leds script when the wait time is higher than 30%.

# Objectives

    * Allow programming students to build an affordable computer system
      with off-the-shelve parts
    * 3D design a under-case for the rpi official keyboard
    * Flexibility

# mk1 parts list

    * raspberry pi zero w          400czk
    * raspberry pi uk keyboard     500czk
    * micro sd card 32 gb          400czk
    * micro hdmi to hdmi adapter   200czk
    * usb otg adapter              120czk
                                  1620czk ~= 64 EURO

    * monitor                     2700czk

# Milestones

    2020-01-04   mk1 assembly
