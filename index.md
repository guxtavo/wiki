

                     ##    ##   ###    ##   ##   ##      ##
                     ##    ##   ####   ##   ##    ##    ##
                     ##    ##   ##  #  ##   ##     ##.###
                     ##    ##   ##   # ##   ##     ###.##
                     ##    ##   ##    ###   ##    ##    ##
                      ######    ##    ###   ##   ## wiki ##

                               sh  +  c   +  md
                               vim + tmux + git
                                 osc + ftrace

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


# Directives

                    DP FIT ARF                       UWK L3 C
                    SVV  RL NP                   SIM BKS PLNN
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

### SGR products

  200OK ticket     ticket.sgr.cz
  200OK Wiki	     wiki.sgr.cz
  200OK git           git.sgr.cz
  200OK Hardware  3dprint.sgr.cz
  200OK CI          build.sgr.cz
  200OK sgr-david   david.sgr.cz
  200OK sgr-remote  tmate.sgr.cz
