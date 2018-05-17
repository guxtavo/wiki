% [ 200 OK ] - Unix Workstation
% The modern-retro Linux terminal computer

                    #####  ###   ###   ###    ####  ##  ##   ###
                       ## ## ## ## ##  #     ##  ## ## ##      #
                    ##### ##.## ##.##  #     ##  ## ###        #
                    ##    ## ## ## ##  #     ##  ## ## ##      #
                    #####  ###   ###   ###    ####  ##  ##   ###

    Standard response for successful HTTP requests. The actual response will
    depend on  the request method used. In a GET  request, the response will
    contain  an entity  corresponding to the  requested resource. In  a POST
    request, the  response will contain  an entity describing  or containing
    the result of the action - Wikipedia

                            +----UU-----h------P----+
                            |    E............(P    |
                            |    `1234567890-=(B    |
                            |    Tqwertyuiop[]EE    |
                            |    SRasdfghjkl;'\E    |
                            |    SFzxcvbnm,./P^P    |
                            |    CTSAL(   )  <v>    |
                            +-----------------------+

    The 200 [ OK ]  is a Unix Workstation which uses off the shelf materials
    to construct a Linux Computer under 50 euros -*HDMI display not included

# The basics

                     What's included: the basics (almost...)


                           Mini HDMI-.
                        2 x USB-A     \         Power - 5V 1A
                                 \     \       /
                            +----UU-----h------P----+
                    16GB <- |    E............(P    |
                      SD    |    `1234567890-=(B    |
                            |    Tqwertyuiop[](E    |
                            |    SRasdfghjkl;'\E    | -> 76 keys
                            |    SFzxcvbnm,./P^P    |
                            |    CTSAL(   )  <v>    |
                            +-----------------------+

    Running at 170mA on peak CPU load, the BCM2835 is not a powerhouse.
    Fortunatelly you don't need much to shine with tmux or screen. Write
    code and markdown with vim will surf a polution-free web with w3m.

## Pi Zero

The Pi Zero W is a very weak general usage computer, but that's due to it's 9
euro price. The board measures 65 x 30 x 5 mm and packs:

  * BCM2835 - ARM11 32-bit
    - 1 GHz CPU
    - 250 MHz "Video Core 2" GPU
    - 512MB RAM
  * Micro SD card slot
  * 2.4GHz 802.11n WIFI and Bluetooth 4.1 and LE
  * Mini-HDMI
  * LED - power and HDD activity
  * 40 GPIO pins

## Keyboard

The keyboard and power circuit are a custom PCB, and the key layout is:

     14      ESC) F1  F2  F3  F4  F5  F6  F7  F8  F9  F10 F11 F12 POWER
     14      ~`  !1  @2  £3  $4  %5  ^6  &7  *8  (9  )0  _-  +=  BACKSP
     14      TAB   q   w   e   r   t   y   u   i   o   p   {[  }] ENTER
     13      SYSRQ  a   s   d   f   g   h   j   k   l   ;:  "'  |\  TER
     14      SHIFT   z   x   c   v   b   n   m   <,  >.  ?/   PU  ^  PD
      7      CTRL)  SUP  (ALT) (                  )           <-  v  ->

     76 keys

    The key layout is 3(14)+13+14+7, because you gotta have a big Enter
    key. We also pack the arrows and pager keys by removing duplicate
    modifiers. You already have the modifiers in your left hand, which
    leaves your right hand to scroll around. I know sometimes you will
    miss the right shift, but we want to pack a lean Unix keyboard.

### tmux shortcuts

### vim shortcuts

### w3m shortcuts

### mutt shortcuts

### SysRq shortcuts

                  Alt + SysRq + b - reboot immediately
                  Alt + SysRq + o - halt immediately
                  Alt + SysRq + n - nice reset
                  Alt + SysRq + f - calls oom_kill
                  Alt + SysRq + u - read-only filesystems
                  Alt + SysRq + s - sync
                  Alt + SysRq + e - end all processes
                  Alt + SysRq + i - killall (really)

## Raspberry Pi Zero W GPIO layout

The 40 Pin GPIO provides expansion to the system.

                      +3V3 out  [ 1] [ 2]  +5V
                        GPIO 2  [ 3] [ 4]  +5V
                        GPIO 3  [ 5] [ 6]  GND
                        GPIO 4  [ 7] [ 8]  GPIO 14 / uart0 tx
                           GND  [ 9] [10]  GPIO 15 / uart0 rx
                       GPIO 17  [11] [12]  GPIO 18 / pwm0
                       GPIO 27  [13] [14]  GND
                       GPIO 22  [15] [16]  GPIO 23
                      +3V3 out  [17] [18]  GPIO 24
                       GPIO 10  [19] [20]  GND
                       GPIO 09  [21] [22]  GPIO 25
                       GPIO 11  [23] [24]  GPIO 8 / spi-cs0
                           GND  [25] [26]  GPIO 7 / spi-cs1
                           _SD  [27] [28]  ID_SC (ID eeprom)
                       GPIO 05  [29] [30]  GND
                       GPIO 06  [31] [32]  GPIO 12
                       GPIO 13  [33] [34]  GND
                       GPIO 19  [35] [36]  GPIO 16
                       GPIO 26  [37] [38]  GPIO 20
                           GND  [39] [40]  GPIO 21 / gpclk1

### Extra connections

Along with the 40 pin GPIOs, the top of the device (where you see the CPU and
the USB, HDMI and SD card ports, houses some connections:

     +----------------------------------------------------------------+
     |               +-----------------------------------------+      |
     |               | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |->40  |
     |            1->| 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |      |
     |               +-----------------------------------------+      |
     |                                             GPIO               |
     |                                                 +-------+      |
     | The extra RUN pins are meant for a reset button |  0  0 | RUN  |
     |                                                 |-------|      |
     |                The TV pin is a composite signal | +0 -0 | TV   |
     |                                                 +-------+      |
     |                                                                |
     |                              () ()                             |
     |                                0                               |
     |                               USB                              |
     +----------------------------------------------------------------+

### Extra connections (cont)

In the bottom of the device there are:

    +-----------------------------------------------------------------+
    |                +-----------------------------------------+      |
    |                | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |->40  |
    |             1->| 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |      |
    |                +-----------------------------------------+      |
    |                                                                 |
    |                            PP8()           PP5  ()              |
    |                                                  () PP17        |
    |                                            PP16 ()              |
    |                                                  () PP14        |
    |                                            PP18 ()              |
    |                                                  () PP19        |
    |                                            PP15 ()              |
    |                                                  () () PP39 PP36|
    |                                            PP20 ()              |
    |  PP1   PP40        PP9                                          |
    |  ()     ()          ()                                          |
    |  PP6   PP35  PP22 PP23                       PP38 PP37          |
    |  ()    ()     ()  ()                           ()  ()           |
    +-----------------------------------------------------------------+

   PP1: USB      PP14: SD CLK      PP17: SD DAT1     PP22: USB D+
   PP6: GND      PP15: SD CMD      PP18: SD DAT2     PP23: USB D-
   PP8: 3.3V     PP16: SD DAT0     PP19: SD CD

# Power and connections

For the protoype, this is the expected power draw:

              PI - 350mA (max)
            HDMI -  25mA
        Keyboard - 100mA
        ------------------------
           Total - 475mA (max)
                 - 225mA (min)

## USB Wiring standard

    Red   - 5V DC
    Black - GND
    White - Data (positive)
    Green - Data (negative)

## Connections

    PP1  <-> USB keyboard Power
    PP6  <-> USB keyboard GND
    PP22 <-> USB keyboard USB D+
    PP23 <-> USB keyboard USB D-

# Software

The system will boot in graphical mode with LXDE. A terminal running tmux will
be spaw with the system startup, as tmux is the real "Desktop Environment" to
be used by the user.

[ 200 OK ] uses a custom raspbian image which contains:

  * mainline linux kernel
  * vim
  * tmux/lxde
  * git
  * w3m
  * YouTube (mps-youtube and youtube-dl)

## Flashing, and activating ssh and wpa_supplicant.conf

    $ sudo dd bs=4M if=2018-04-18-raspbian-stretch.img \
      of=/dev/mmcblk0 conv=fsync

After finished, mount the fat partition and:

    touch ssh

    cat wpa_supplicant.conf <EOF
    example here

## Function keys

    F1 - enter copy mode
    F2 - paste
    F3 - split vertically
    F4 - split horizontally
    F5 - volume down
    F6 - volume up
    F7 - vim format code according to language
    F8 - screencast
    F9 - search
   F10 - new window
   F11 - full screen
   F12 - last window

## Help system

    scriptreplay of a session showing at least 3 use cases for:
        * tmux
        * vi (markdown)
        * git
        * awk
        * grep
        * sed

When shortcut is triggered, open a small pane, show the quick help and inform
the pane will be closed in 15 seconds.

## software - f7 - status mode

By triggering F7, the user will be informed about the system status, which
includes latency to the DNS server, component temperature and local temperature
(if the user provides string with the location).

status-right modes of operation


The built-in led on the pi zero should be disabled, and we should have three
leds in the computer that can be triggered by tmux to display:

Default mode:
  * disk activity - amber when lightly busy, red when blocked

Green for tens, amber for ones, e.g.: green green orange means 21

Status mode:
  * ping latency to dns in ms : aaaaaaaa     8ms
  * cpu temperature in C      : gggg a       41C
  * local temperature in C    : gg aaa       23C

# Releases

  1) Retro-fit the Pi inside the prototype keyboard
  2) Add a power button using GPIOs 5 and 6 (and scripts)
  3) Add composite video jack
  4) Add Pi Zero led indicator to the prototype keyboard
  5) Add a power circuit + lipo battery

## Future (FATE)

  1) Expose GPIOs via a cartridge slot
     -> For adding a 16x2 LCD cartridge
     -> For hooking an arduino cartridge

  2) e-ink screen

  3) fingerprint scanner

  4) USB-C port

  5) refurbish old laptop screens in order to create the [ 200 OK ] laptop

  6) laptop factory

## Automatic shutdown

The system's battery is not intended as creating a portable system, but aimed
at smooth operation in case of power outage. The main goal is to give 3 hours
of uninterrupted usage when disconnected from the power source.

As soon as the power circuitry detects low battery, the shutdown sequence will
initiate. The system will be powered off 5 minutes after the low voltage stage
is detected.

# TODO

  * Acquire tools
  * Open prototype keyboard
  * Open holes for HDMI, USB power, USD data, Composite video, power button

# Resources

  * https://www.youtube.com/watch?v=IKe_hrvYH1M
  * https://github.com/ruiqimao/keyboard-pcb-guide
  * http://www.keyboard-layout-editor.com/#
  * vortex race 3

## layout

[{y:0.75,c:"#173f4f",t:"#73ba25",p:"CHICKLET",a:7,f:2,h:0.75},"esc",{f:8,h:0.75},"📋",{h:0.75},"📋",{h:0.75},"✖️",{h:0.75},"➗",{h:0.75},"🔉",{h:0.75},"🔊",{h:0.75},"✍",{h:0.75},"🎥",{h:0.75},"🔍",{h:0.75},"💡",{h:0.75},"🔀",{h:0.75},"🔙",{a:4,f:2,w:2,h:0.75},"\n\nPower"],
[{y:-0.25,f:5},"~\n`","!\n1","@\n2","#\n3","$\n4","%\n5","^\n6","&\n7","*\n8","(\n9",")\n0","_\n-","+\n=",{f:2,w:2},"\n\nBackspace"],
[{w:1.5},"Tab",{f:5},"Q","W","E","R","T","Y","U","I","O","P","{\n[","}\n]",{x:0.25,f:2,w:1.25,h:2,h2:1,x2:-0.25},"\n\nEnter"],
[{w:1.75},"SysRq",{f:5},"A","S","D",{n:true},"F","G","H",{n:true},"J","K","L",":\n;","\"\n'","|\n\\"],
[{f:2,w:2},"Shift",{f:5},"Z","X","C","V","B","N","M","<\n,",">\n.","?\n/",{f:2},"Page\n\n\n\n\n\nUp",{a:7,f:5},"↑",{a:4,f:2},"\n\nPage\n\n\n\n\nDown"],
[{w:1.5},"Ctrl","Super",{w:1.5},"Alt",{a:7,w:7},"",{x:1,f:5},"←","↓","→"]

[{y:0.75,c:"#173f4f",t:"#73ba25",p:"CHICKLET",f:2,w:1.5,h:0.75},"Esc",{h:0.75},"F1",{h:0.75},"F2",{h:0.75},"F3",{h:0.75},"F4",{h:0.75},"F5",{h:0.75},"F6",{h:0.75},"F7",{h:0.75},"F8",{h:0.75},"F9",{h:0.75},"F10",{h:0.75},"F11",{h:0.75},"F12",{w:1.5,h:0.75},"\n\nPower"],
[{y:-0.25,f:5},"~\n`","!\n1","@\n2","#\n3","$\n4","%\n5","^\n6","&\n7","*\n8","(\n9",")\n0","_\n-","+\n=",{f:2,w:2},"\n\nBackspace"],
[{w:1.5},"Tab",{f:5},"Q","W","E","R","T","Y","U","I","O","P","{\n[","}\n]",{x:0.25,f:2,w:1.25,h:2,h2:1,x2:-0.25},"\n\nEnter"],
[{w:1.75},"SysRq",{f:5},"A","S","D",{n:true},"F","G","H",{n:true},"J","K","L",":\n;","\"\n'","|\n\\"],
[{f:2,w:2},"Shift",{f:5},"Z","X","C","V","B","N","M","<\n,",">\n.","?\n/",{a:5,f:2},"Page\n\n\n\n\n\nUp",{a:7,f:5},"↑",{a:5,f:2},"Page\n\n\n\n\n\nDown"],
[{a:4,w:1.5},"Ctrl","Super",{w:1.5},"Alt",{a:7,w:7},"",{a:4},"Fn",{a:7,f:5},"←","↓","→"]


# cost estimation (really)

 Main computer                 ZeroW  9 eur  Raspberry Pi Zero W
 Custom PCB                           9 eur  Power circuit, usb hub
 Storage device                 16GB  9 eur  Class 4||10 SD
 Power source                     2A  9 eur  DC 5V 2A out
 Keyboard and frame              UWK  9 eur  Unix Workstation Keyboard
 ------------------             ----  -----
 Total                           NET 45 eur

# Price

Based on 45 eur:


                      |
         179.99       |*----------
                      |
                      |
         149.99       |            *-----------
                      |
                      |
         119,88       |                        *----------->
                      +------------------------------------
                       JFMAMJJASONDJFMAMJJASONDJFMAMJJASOND♾
# Hardware

# Questions?
