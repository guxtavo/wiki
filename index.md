

                                       C
                                  sh   +   md
                                  vim  + tmux
                                  git  +  osc



    FLIGHT CAPCOM FDO GPO DPS Surgeon Booster PDRS PROP GNC EECOM EGIL INCO


                     ##    ##   ###    ##   ##   ##      ##
                     ##    ##   ####   ##   ##    ##    ##
                     ##    ##   ##  #  ##   ##     ##.###
                     ##    ##   ##   # ##   ##     ###.##
                     ##    ##   ##    ###   ##    ##    ##
                      ######    ##    ###   ##   ## wiki ##


               [HELM] 2:CAPCOM    * 248ms | !7/9 21/68 | 33/33c |
               |                        |                       |
               |                        |          c            |
               |                        |     sh   +  md        |
               |                        |     vim  + tmux       |
               |                        |     git  +  osc       |
               |                        |                       |
               |________________________|   FLIGHT CAPCOM FDO   |
               |*                       |                       |
               |________________________|_______________________|

                my tmux status bar, measuring how long it takes
                 to run (in ms) | my active and processed bugs
                  other work status and hardware temperatures,
                


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

                    FIT ARF DP                   PLNN BKS SIM
                    SVV RL MA                        UWK L3 C
                    GUI                                   AFH

# Structure

    afh             - FAA's Airplaine Flying Handbook epub convertion efforts
    articles        - random blog texts
    bin             - scripts and prototypes
    development     - kernel and userspace tools tips
    profile         - status bar for tmux
    SGR             - Space Grade Research
    1-feedback.md   - Feedback system
    index.md        - This file

# BUGs

	BUG01 depends on ECO01

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

### SGR products

  200OK ticket     ticket.sgr.cz
  200OK Wiki	     wiki.sgr.cz
  200OK git           git.sgr.cz
  200OK Hardware  3dprint.sgr.cz
  200OK CI          build.sgr.cz
  200OK sgr-david   david.sgr.cz
  200OK sgr-remote  tmate.sgr.cz

#### 200 OK

                 ______________________________________________
                |                                              |
                | [_] [_][_][_][_][_][_][_][_][_][_][_][_] [_] |
                |                                         ___  |
                | [ ][1][2][3][4][5][6][7][8][9][0][ ][ ][___] |
                | [__][q][w][e][r][t][y][u][i][o][p][ ][ ][  | |
                | [___][a][s][d][f][g][h][j][k][l][ ][ ][ ][_] |
                | [___][z][x][c][v][b][n][m][ ][ ][ ][ ][^][ ] |
                | [__][_][__][____________][_][_][__][<][_][>] |
                |______________________________________________|

                                     79


      -------------------------------------------------------------------
     |   =============================================================   |
     |   =============================================================   |
     |   ,---, ,---,---,---,---,---,---,---,---,---,---,---,---, ,---,   |
     |   |   | |   |   |   |   |   |   |   |   |   |   |   |   | |   |   |
     |   '---' '---'---'---'---'---'---'---'---'---'---'---'---' '---'   |
     |                                                                   |
     |   ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,   |
     |   | ~ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | - | = | back  |   |
     |   |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|   |
     |   | --> | q | w | e | r | t | y | u | i | o | p | [ | ] | ent |   |
     |   |-----',--',--',--',--',--',--',--',--',--',--',--',--',    |   |
     |   | fn   | a | s | d | f | g | h | j | k | l | ; | ' | | |    |   |
     |   |------',--'---'---'---'---'---'---'---'---'---'---',---,---|   |
     |   | swift | z | x | c | v | b | n | m | , | . | / |   | ^ |   |   |
     |   |----,--',---,--'---'---'---'---'---'---'---'---,---,---,---|   |
     |   | ct | s | a |                     | a | s | ct | < |   | > |   |
     |   '----'---'---'---------------------'---'---'----'---'---'---'   |
     |                                                                   |
      -------------------------------------------------------------------

                                     79

##### Objectives

  * Make a student computer, affordable, flexible
  * Production with off-the-shelv parts (pi0)
  * Focus on reduced price, quality and ease of use
  * Make 2 versions
    * 1 pi's
    * 3 pi's
    * icecream installed by default (distributed OBS)


  * Make it redundant with 3 pi0's (and a version for only 1)


##### Next steps

  * Design PCB and Case
  * Parts list
    * 79 leds
  * Finalize layout
