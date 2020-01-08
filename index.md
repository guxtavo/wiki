
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


# tmux

                FLIGHT CAPCOM FDO GPO DPS Surgeon Booster PDRS


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
                  other work status and hardware temperatures

# Directives

                    FIT ARF SVV                   SIM  L3   C
                    GUI  MA  RL                   PLN BKS AFH
                         DP                           UWK


### Plan and anti-plan

                        .-- MA         AFH --.       .-- UWK
                       /                      \     /
      GUI --- FIT --- RL --- SVV               PLNNR
               /       \                      /  |  \
        ARF --'         '-- DP         BKS --'   |   '-- SIM
                                                L3
                                                 |
                                                 |
                                                 C

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

    find shortcuts in vim for:  gqip
                                set nonu
                                set textwidth=72
                                set autoindent

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


### UWK
     * shell.sh -> execute in a loop, move the cursor to the beginning
after
       printing (so it behaves like i3status)



### SGR products

  200OK ticket     ticket.sgr.cz     ?
  200OK Wiki	     wiki.sgr.cz     mediawiki
  200OK git           git.sgr.cz     gitlab
  200OK CI          build.sgr.cz     OBS
  200OK sgr-david   david.sgr.cz     ?
  200OK sgr-remote  tmate.sgr.cz     tmate
  200OK billing         ?.sgr.cz     ?

### piOS

Initializing piOS v2.1.01p

Disk check: okay
Memory check: okay
Network check: okay




                            88    ,ad888ba,      ad88888ba
                            ""   d8"'   `"8b    d8"     "8b
                                d8'       `8b   Y8,
               8b,dPPYba,   88  88         00   `Y8aaaaa,
               88P'    "8a  88  88         88     `"""""8b,
               88       d8  88  Y8,       ,8P           `8b
               88b,   ,a8"  88  Y8a.    .a8P    Y8a     a8P
               88`YbbdP"'   88   `"Y8888Y"'      "Y88888P"
               88
               88

                     "operating sytem of the future (TM)"

#### 200 OK

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

# mk2




                Phone holder ----+     2xAA battery slot ------------------+
                                 |                                         |
                                 |                                         |
                        Pen slot |                                         |
       8 char LED          |     |  HDMI    USB-C (power)     USB-A (data) |
            |              |     |   |      |                      |       |
            |              |     |   |      |                      |       |
            |              |     |   |      |                      |       |
      ------+--------------+-----+---------------------------------+-----  |
     |   |[200 OK]|        |     ##############                 [    ]   | |
     |   =============================================================   +-+
     |   =============================================================   |
     |   ,---, ,---,---,---,---,---,---,---,---,---,---,---,---, ,---,   |
     |   '---' '---'---'---'---'---'---'---'---'---'---'---'---' '---'   |
     |   ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,   |
     |   | ~ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | - | = |  back |   |
     |   |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|   |
     |   | --> | q | w | e | r | t | y | u | i | o | p | [ | ] | ent |   |
     |   |-----',--',--',--',--',--',--',--',--',--',--',--',--',    |   |
     |   |   fn | a | s | d | f | g | h | j | k | l | ; | ' | | |    |   |
     |   |------',--',--',--',--',--',--',--',--',--',--',--',---,---|   |
     |   | shift | z | x | c | v | b | n | m | , | . | / |shi| ^ | fn|   |
     |   |----,--',---,--'---'---'---'---'--,'--,'--,'---,---,---,---|   |
     |   |ctrl|sup|alt|                     |alt|sup|ctrl| < | v | > |   |
     |   '----'---'---'---------------------'---'---'----'---'---'---'   |
     |                         |                                         |
      -------------------------+-----------------------------------------
                               |                   |
                               |                   |
                               |                   |
                        79 backlit keys      3.5 mm (audio)

                         __________________________
                        |OFFo oON                  |
                        | .----------------------. |
                        | |  .----------------.  | |
                        | |  |                |  | |
                        | |))|                |  | |
                        | |  |                |  | |
                        | |  |                |  | |
                        | |  |                |  | |
                        | |  |                |  | |
                        | |  |                |  | |
                        | |  '----------------'  | |
                        | |__GAME BOY____________/ |
                        |          ________        |
                        |    .    (Nintendo)       |
                        |  _| |_   """"""""   .-.  |
                        |-[_   _]-       .-. (   ) |
                        |   |_|         (   ) '-'  |
                        |    '           '-'   A   |
                        |                 B        |
                        |          ___   ___       |
                        |         (___) (___)  ,., |
                        |        select start ;:;: |
                        |                    ,;:;' /
                        |                   ,:;:'.'
                        '-----------------------`


                            _n_________________
                           |_|_______________|_|
                           |  ,-------------.  |
                           | |  .---------.  | |
                           | |  |         |  | |
                           | |  |         |  | |
                           | |  |         |  | |
                           | |  |         |  | |
                           | |  `---------'  | |
                           | `---------------' |
                           |   _ GAME BOY      |
                           | _| |_         ,-. |
                           ||_ O _|   ,-. "._,"|
                           |  |_|    "._,"   A |
                           |            B      |
                           |       _  _        |
                           |      // //     ///|
                           |      `  `     /// ,
                           |________...______,"

##### LED

With 1 byte of data, the intention is to display a code akin to the http
protocol status codes. This data would be pulled from a lightweight
watchdog running in userspace (with higher priority), pulling data from
the system periodically to display a guestimate on the general usability
of the system. The system will be measured and report will appear in a
grade:

    [200 OK] - OK                                 status is fine
    [201 CR] - New issue created     status is ok, warning found
    [400 Ba] - Bad request                        status unknown
    [404 NF] - Not found                  call back didn't occur
    [500 IE] - Internal server error                cannot probe
    [503 SU] - Service Unavailable  overloaded or in maintenance
    [507 IS] - Insufficient Storage

Other codes can be implemented through scripting:

    * Temperature 

The watchdog will determine how the system is behaving and give one of
the five answers depending on how it rates the condition.

The big question here is how to represent the usability of a system in a
5 tier set, from "you should be good to go" to "you are doing something
wrong or we are"

    [200 OK] status is fine
    [201 CR] there is lag
    [202 AC] lag intensifies
    [203 NA] processed with data from

Is it useful to know the status of the system? Is http codes the best
way to 

The green led can be used by any program through a library. The library
will allow suspending the watchdog (or other running program accessing
the display) to display your data.

The display should support up to 140 chars for scrolling.

The speed in each the pulling and refreshing the display can be
modified.

The user can also choose the display the values like:

    * show per-cpu kernel stack value
    * show per process stack pointer
    * you can script any output to it

##### http codes

2xx Success - the watchdog is 

This class of status codes indicates the action requested by the client
was received, understood, accepted and processed successfully.

200 OK

The request has succeeded. The information returned with the response is
dependent on the method used in the request, for example:

  • GET an entity corresponding to the requested resource is sent in the
    response;

  • HEAD the entity-header fields corresponding to the requested
    resource are sent in the response without any message-body;

  • POST an entity describing or containing the result of the action;

  • TRACE an entity containing the request message as received by the
    end server.


Standard response for successful HTTP requests. The actual response will
depend on the request method used. In a GET request, the response will
contain an entity corresponding to the requested resource. In a POST
request the response will contain an entity describing or containing the
result of the action.

201 Created

The request has been fulfilled and resulted in a new resource being
created.

202 Accepted

The request has been accepted for processing, but the processing has not
been completed.  The request might or might not eventually be acted
upon, as it might be disallowed when processing actually takes place.

203 Non-Authoritative Information

    The server successfully processed the request, but is returning
    information that may be from another source.

204 No Content



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
  * https://howchoo.com/g/zgmzytq1mmy/raspberry-pi-in-official-pi-keyboard
  * https://blog.pimoroni.com/putting-a-raspberry-pi-3-a-in-the-raspberry-pi-keyboard/
  * https://howchoo.com/g/mwnlytk3zmm/how-to-add-a-power-button-to-your-raspberry-pi


  Grateful for:

     * Studying 10 minutes of C last Sunday
     * Finishing   many SVV tasks yesterday
     * Having great yoga and exercise today
     * Having great fun with pokemo
     * Reading good books in the morning


     ################################################################
     #                                                              #
     #  FIT - 50 squats and yoga                  gpi case - SIM    #
     #  ARF - diet                             organize ~/ - L3     #
     #  SVV - order                              sololearn - C      #
     #  GUI - plan vacations                      attitude - PLNNR  #
     #   MA -                     Vso Vs Vfe Va Vx Vy Trim - AFH    #
     #   RL - cuddles and walks            how music works - BKS    #
     #   DP - dieta                       act let to sound - UWK    #
     #                                                              #
     ################################################################
