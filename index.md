

                     ##    ##   ###    ##   ##   ##      ##
                     ##    ##   ####   ##   ##    ##    ##
                     ##    ##   ##  #  ##   ##     ##.###
                     ##    ##   ##   # ##   ##     ###.##
                     ##    ##   ##    ###   ##    ##    ##
                      ######    ##    ###   ##   ## wiki ##

                               sh  +  c   +  md
                               git + tmux + vim
                               osc + gdb

                             kernel and user-space
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


# Goals

                         1.  FIT TC  SVV  RL  UWK
                         2.  PLNNR GUI ARF  L3 NP
                             CZ  C  SIM  AFH  BKS
                         3.  MSC MFR  KRNL SGR 2∞
                             RPG  JP  WS H1  SPCX

# Directory structure

  afh          - Airplaine Flying Handbook epub convertion efforts
  articles     - random blog texts
  bin          - scripts and prototypes
  development  - kernel and userspace tools tips
  profile      - sgr shell
  SGR          - Space Grade Research
  index.md     - this file you are reading

## ECOs

    * ECO1 network-status-probe - runs in a loop, updates every 15 secs
        * check DNS connectivity
        * check NIC status
        * check VPN status
	* ECO21 np for OpenBSD
    * ECO2 commit-pull-request-tracker
        * tracks positive feedback PTFs
        * tracks pull requests made
        * tracks patches commited to git repos
        * How to get # or PR and commits in github and gitlab?
        * Integrate other plugins with netstat-probe
    * ECO3 elapsedtime - improve
        * count time between items in the main loop
        * improve performance to < 50ms when power is connected
        * improve performance to < 150ms when power is disconnected
    * ECO6 pass: Before authenticating, save passwords in password-store
    * ECO7 AFH epub
    * ECO8 enterdebug
    * ECO9 calendar integration
    * ECO10 ditch gnome and gnome-terminal for something faster (i3 and st?)
    * ECO11 run rain.sh in realtime, no delays
    * ECO12 show builds runnin in IBS
    * ECO13 intergrate calendaring from google (at least show and notify)
    * ECO14 weather - hide umbrella when chance is 0
    * ECO15 move gmail to mutt
    * ECO18 cleaup bash history
    * ECO20 what is .nexrc in openbsd?
	* ECO22 write a C program to print date -r with nanoseconds
	* ECO24 display-message when battery goes bellow 30 minutes
	* ECO26 enterdebug prototype before hackweek starts
	* ECO28 suspending when lid is closed (also run i3lock)
	* ECO29 make shell.sh behave like i3status

    * OK: ECO5 simultaneous alarms with descriptions
    * OK: ECO19 do not depende on fuzzy finder
	* OK: ECO25 volume and brightness in i3
	* OK: ECO27 locking screen in i3
    * OK: ECO17 port vimrc from openbsd to linux
    * OK: ECO16 port .tmux-openbsd to linux, change color scheme
	* OK: ECO23 what to show instead of battery percentage/remaining time? -> alarms

## BUGs

  * Count PTF only when connected -> Depends on ECO1
  * NetworkManager 100% CPU utilization

### SGR products

  200OK Case           hw.sgr.cz
  200OK PCB            hw.sgr.cz
  200OK sgr-distro  build.sgr.cz
  200OK sgr-shell   shell.sgr.cz
  200OK sgr-david   david.sgr.cz
  200OK sgr-remote  tmate.sgr.cz
