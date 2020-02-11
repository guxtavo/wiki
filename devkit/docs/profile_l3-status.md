% Creating an interface for an agile workflow in L3 TODO fix this
% Gustavo Figueira

# actions

    cp -r ~/git/wiki/profile ~/git/wiki/prfl
    cd ~/git/wiki/prfl
    mkdir {prfls,signals,backend}
    rm *~
    mv pl.s brightness.sh  signals

# Refactoring the file names and directories inside ~/git/wiki/profile

Copy to a new folder to play around. Watch the paths.

brightness.sh   install.sh     Roboto-Regular.ttf          tests.sh
brightness.sh~  io_status.sh   space.wav
timer_music_screencast.sh
dns.sh          net_status.sh  status-right-openbsd.sh     tmux_tasks.sh
fix_size        pl.sh          status-right-server.sh      tmux_tasks.sh~
git-status.sh   plugin         status-right.sh~            weather-obsd.sh
git-tmux.sh     quotes         status-right-tumbleweed.sh  weather.sh
git-tmux.sh~    quotes.dat     temp_status.sh

future directories
github/guxtavo/prfl
    prfls - openbsd, server, tumbleweed
    signals - small scripts to query and used to composite the bar
    backend - resource intensive "signal gatherer"
    resources - fonts, sounds, etc
        quotes
        quotes.dat
        space.wav
        Roboto-Regular.ttf
    plugin - I think this is regard the translation, e.g. 'pt', but IDR
    prfl - entry point to add to tmux

Inside signals:

    brightness.sh               show brightness level
    weather.sh                  show weather forecast
    temp_status.sh              show CPU/HDD temperature
    dns.sh
    pl.sh                       show what's playing from mpv
    timer_music_screencast.sh
    git-status.sh

Inside backend

    net_status.sh   - backend?
    io_status   - backend?

Left are:

    tests.sh
    tmux_tasks.sh
    fix_size
    install.sh

# Create new windows for when a bug needs attention

Read dates from status report at a certain time of the day and creates a new
tmux window with two panes.

# Solid Ground Interface

Log how many times the eyes 👀 appear

If active >4 show emoji of an eye
Show processed incidents as cold (blue arrow down)
Show sleeping incidents as frozen (ice cube) ❄

Show graph of the day in a simple format

    112444

The number of active incidents grows to the right, that is to say, when the
hourly reading wants to add the reading, it will add it to the leftmost element
and remove the rightmost, eg:

    Current graph: 333444
    Reading: 2
    Next graph: 233344

Have a emoji with "right green arrow" or some indication it goes right.

Target: more pull requests. Current reading shows:

    🎯66/4/4

    The first part is the files changed in the last N days
    The second is the files changed in git/suse
    And third is the number of repositories with pending changes in ~/git

These are guesses, you should fine the answer in 

Only show CPU/HDD temp if higher than 40 degrees, show in the battery position.

# Radio

Take a challenge with a friend - tmate

# Other types of broadcast

    * Number of P0, P1 and new incidents in the queue
