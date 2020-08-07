

         _ __   _____      _____
        | '_ \ / _ \ \ /\ / / __|     New weather functions for devkit
        | | | |  __/\ V  V /\__ \     available 2020-08-7
        |_| |_|\___| \_/\_/ |___/


    aliases:                     tmux:
      - wgetziu                    - ctrl+b e - capture the contents
      - alsamixer                    of pane to ~/tmux-pane-<timestamp>
      - figlet
                                 w3m:
    vim:                           - c -show the URL
      - ctrl+x       = gqip
      - ctrl+n twice = set nonu                 mutt:
      - ctrl+m twice = set textwidth=72           - * - selects the last
      - ctrl+a       = set autoindent                   message
      - replace ^M for carriage return
        :%s/<Ctrl-V><Ctrl-M>/\r/g               quotes file:
                                        - strfile -c % quotes quotes.dat

    readline:                           decimal to binary:
      - alt+b - move backward a word    - echo "obase=2;32" | bc # 100000
      - alt+f - move forward a word
                                        binary to decimal:
                                        - echo 'ibase=2;obase=A;101' | bc # 5

                                        hexa to decimal
                                        - echo 'ibase=16;obase=A;FF' | bc # 255

                                        decimal to hexa
                                        - echo 'obase=16;255' | bc # FF
          __               _ _                _
         / _| ___  ___  __| | |__   __ _  ___| | __
        | |_ / _ \/ _ \/ _` | '_ \ / _` |/ __| |/ /
        |  _|  __/  __/ (_| | |_) | (_| | (__|   <
        |_|  \___|\___|\__,_|_.__/ \__,_|\___|_|\_\

# C

 swap.c:14:13: warning: implicit declaration of     fix
 function ‘atoi’ [-Wimplicit-function-declaration]   ->  #include <stdlib.h>
    14 |     int x = atoi(argv[1]);
       |             ^~~~


# undone tasks

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

    * devkit: fix bug where solidground data is lost during reconnect
    * devkit: refactor solidground_progress()
    * devkit: create a systemd service for connectivity.sh
    * devkit: create a script to create plymouth text animation
    * devkit: auto start terminal with "devkit" at i3 startup
    * devkit: change enc in openssl to a good one
    * devkit: bug: fix ~/.i3status.conf on armv6l to show correct percentage
    * devkit: connectivity.sh
        * check l3slave connectivity
        * make ping_sites behave like its simblings
        * Integrate other plugins with netstat-probe
    * devkit: intergrate calendaring from google (at least show and notify)
    * devkit: suspending when lid is closed (also run i3lock)

    * vim: "coc" plugin
    * tools: ~/git/sent (presentations made easy)
    * lrn: w3m - research how to use tabs
    * w3m - research how to show numbers before links (how to use)
    * w3m - research how to show line numbers
    * cli.space services: pmo(hire), rtfm, botcamper
    * github.com/RTFM/botcamper - write 1000 scripts
    * mk-2 -> git/wiki/RTFM/index.md
