% Imagine 3 raspberry pis zero inside your keyboard

# Power inteligent

    A power supply that can turn on 3 different devices separately.
    Good to have: show consumption in a led display.

# Clustering interconnect

    The 3 computers serial interfaces are arranged in a ring, where 1
    connects to 2, 2 to 3 and 3 to 1. The alternative would be everybody
    connects to an arbitrator, but then we would need 2 arbitrators. The
    serial is just a failsafe in case the network is down.

    We also allow a 2 node configuration:

           ____      ____                      ____
          /____\    /____\                    /____\
         //    \\  //    \\                  //    \\
         1      ((2))     3                  1      2
         \\______________//                  \\____//
          \______________/                    \____/

        3 node configuration            2 node configuration

    Which means the serial interconnect can be changed, thus requires a
    design that allows the user to easily do that

# Cluster software

    This is ideal for kubernetes ( 1 master and 2 workers ) scenario.
    Here the master has a more special meaning, because it will be
    connected to video, keyboard and external usb.

    We also made some scripts that allow you to dispatch jobs in your
    cluster via the shell, for the more expert users.

# Open hardware

    The system has to be easy to open and to thinker with.

    +----------------------------------------------------------------+
    | power interconnect                                             |
    +----------------------------------------------------------------+
     | |           | |           | |
    +----------+  +----------+  +----------+
    |    1     |  |    2     |  |    3     |
    +----------+  +----------+  +----------+

    +----------------------------------------------------------------+
    | serial interconnect                                            |
    +----------------------------------------------------------------+

    +----------------------------------------------------------------+
    | network                                                        |
    +----------------------------------------------------------------+
