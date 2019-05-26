

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

                         1.  TC  FIT  GUI  DP  NP
                         2.  MFR SVV  ARF  C  AFH 
						 3.  MSC H1 SPCX PLNNR L3
							 RL BKS  UWK  SIM  2∞

# Structure

  afh          - Airplaine Flying Handbook epub convertion efforts
  articles     - random blog texts
  bin          - scripts and prototypes
  development  - kernel and userspace tools tips
  profile      - status bar for tmux
  SGR          - Space Grade Research
  index.md     -

## BUGs

	BUG03 solidground data is wrong during vpn reconnect. The timer for refresh
	is 30 minutes, so this can lead to wrong information displayed for a long
	time.

## ECOs

    * ECO02 network-status-probe (np)
        * check DNS connectivity
        * check NIC status
        * check VPN status
        * check l3slave connectivity
		* port for for OpenBSD
        * Integrate other plugins with netstat-probe
    * ECO4 elapsedtime
		* make shell.sh behave like i3status (run in a loop)
		* show screen refresh rate in FPS

	* ECO05 dbg - getopts (copy from someone)
	* ECO06 bkp ~/.l3t.conf , i3 config and i3status config to dotfiles
    * ECO07 intergrate calendaring from google (at least show and notify)
	* ECO13 suspending when lid is closed (also run i3lock)
    * ECO11 cleaup bash history configuration
	* ECO14 display-message when battery goes bellow 30 minutes
    * ECO10 move gmail to mutt
    * ECO09 show builds running in IBS
    * ECO08 AFH epub

## BUGs

  * Count PTF only when connected -> Depends on ECO1
  * NetworkManager 100% CPU utilization

### SGR products

  200OK Wiki	     wiki.sgr.cz
  200OK git           git.sgr.cz
  200OK Hardware  3dprint.sgr.cz
  200OK CI          build.sgr.cz
  200OK sgr-david   david.sgr.cz
  200OK sgr-remote  tmate.sgr.cz
