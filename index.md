

                     ##    ##   ###    ##   ##   ##      ##
                     ##    ##   ####   ##   ##    ##    ##
                     ##    ##   ##  #  ##   ##     ##.###
                     ##    ##   ##   # ##   ##     ###.##
                     ##    ##   ##    ###   ##    ##    ##
                      ######    ##    ###   ##   ## wiki ##

                               sh  +  c   +  md
                               git + tmux + vim
                               osc +

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
    * ECO5 simultaneous alarms with descriptions
    * ECO6 pass: Before authenticating, save passwords in password-store
    * ECO7 AFH epub
    * ECO8 enterdebug
    * ECO9 calendar integration
    * ECO10 ditch gnome and gnome-terminal for something faster (i3 and st?)
    * ECO11 run rain.sh in realtime, no delays
    * ECO12 show builds runnin in IBS📦
    * ECO13 intergrate calendaring from google (at least show and notify)
    * ECO14 weather - hide umbrella when chance is 0
    * ECO15 move gmail to mutt

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
