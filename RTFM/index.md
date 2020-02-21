# Milestones

    2020-01-04  mk1 assembly - rpi0w
    2020-02-21  mk2 start assembly - rpi3A+

# RTFM IT

    code/issue tracker              github
    rtfm.io website                 google
    tmate and pmc                   google
    marketing                       google/youtube
    payment                         paypal

# Objectives

    * A computer built for learners
    * Small footprint, off-the-shelve parts and DYI
    * bootcamp - a simple training app

# mk-1 - 5 watts

mk-1 is a rpi official keyboard with a rpi zero w inside it:

  * https://howchoo.com/g/zgmzytq1mmy/raspberry-pi-in-official-pi-keyboard
  * https://blog.pimoroni.com/putting-a-raspberry-pi-3-a-in-the-raspberry-pi-keyboard/
  * https://howchoo.com/g/mwnlytk3zmm/how-to-add-a-power-button-to-your-raspberry-pi

# mk-2 - 12.5 watts

I bought another keyboard and this time I will fit it with a 3A+. After using a
dremel to make room and cut holes for the SD card, audio jack, HDMI and USB
power, I realized the headers and the USB-A on the 3A+ will have to go so the
profile can be lowered.

    * Go to GME
    * buy solder iron
    * buy flux
    * buy 
    * buy hot plastic gun

The next tasks are:

    * What to solder in a usb cable - jumping a usb cable
    * Make schematic of the connection
    * Remove the headers with solder iron
    * Remove USB-A with solder iron
    * Remove the microusb with solder iron
    * jump the 2 usbs

USB connection schematic:


          .--------
          |Back
          |
         ++       * PP35
         ||       * PP22
         ||       * PP23
         ++       * PP27
          |
          |
          .-------

             +--+
          +--+--+------
          |
          |  ****
          |
          | front

# mk-3

Build the schematics for a KVM board
Build a version which can fit 3 rpi0w inside the keyboard.

# LED

The capslock led can be used to relay information to the user. Currently
it is used for the screencast script (brink 3 times to warn the user the
screencast has started/stopped.

My idea is to use the leds script when the wait time is higher than 30%.

# mk1 parts list

    * raspberry pi zero w          400czk
    * raspberry pi uk keyboard     500czk
    * micro sd card 32 gb          400czk
    * micro hdmi to hdmi adapter   200czk
    * usb otg adapter              120czk
                                  1620czk ~=  64 EURO

    * monitor                     2700czk ~= 110 EURO
      total                       4320czk    174 EURO
