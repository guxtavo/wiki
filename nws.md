

         _ __   _____      _____
        | '_ \ / _ \ \ /\ / / __|
        | | | |  __/\ V  V /\__ \
        |_| |_|\___| \_/\_/ |___/


            * Under construction
               _     _
        __   _(_)___(_) ___  _ __
        \ \ / / / __| |/ _ \| '_ \
         \ V /| \__ \ | (_) | | | |
          \_/ |_|___/_|\___/|_| |_|


            * Under construction

          __               _ _                _
         / _| ___  ___  __| | |__   __ _  ___| | __
        | |_ / _ \/ _ \/ _` | '_ \ / _` |/ __| |/ /
        |  _|  __/  __/ (_| | |_) | (_| | (__|   <
        |_|  \___|\___|\__,_|_.__/ \__,_|\___|_|\_\


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
    git:                                - echo 'ibase=2;obase=A;101' | bc # 5
      git commit -p
                                        hexa to decimal
                                        - echo 'ibase=16;obase=A;FF' | bc # 255

                                        decimal to hexa
                                        - echo 'obase=16;255' | bc # FF
