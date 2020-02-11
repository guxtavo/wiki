> Want to discuss a project for your company, personal use or
> promotional needs?
>
> Contact Ben at:
> benjamin.heckendorn@gmail.com

Hello Ben, my name is Gustavo and I follow you on youtube for some
time. I'm a Software Engineer working for SUSE (packaging,
support and developing some skills in python and c).

I've been sketching for over 2 years a concept for a "minimalist
computer" and I named the project "200 OK" (yes, the HTTP code).

Thanks to your last video on driving a z80 using an arduino that I
decided to rename this personal project to "RTFM"!

RTFM mk-1 was built after watching so many of your videos. I got the
inspiration from:

    https://howchoo.com/g/zgmzytq1mmy/raspberry-pi-in-official-pi-keyboard

For "RTFM" mk-2, I want a raspberry pi 3b to fit bellow the pi keyboard.
There are two approaches I could think:

1) make the bottom part higher, this way we can properly fit the pi 3b


                       pi 3b       raspberry pi keyboard
                      /                 /   bottom
                     /  ||-> hdmi,pwr  /
        +----+------+------+----------+.
        |    |      |--+|| |      |   | \
        |    |      |__|+| +------+   |  \
        |    |      |__|_+            |  /
        |    +------+  |              | /
        |              |              |.
        +-----------------------------+
                       | -> headphone

2) move the pi 3b to the top


                       pi 3b       raspberry pi keyboard
             +------+ /                 /   bottom
             | RTFM |/  ||-> hdmi,pwr  /
        +----+------+------+----------+
        |    |      |--+|| |      |   |
        |    |      |----+ +------+   |
        |    +------+  |              |
        |              |              |
        |              |              |
        +-----------------------------+
                       | -> headphone


I want to ask you if you can design a CAD model that implements one of
the two approaches to the official pi keyboard. I have a budget of
450US$ for this personal project and I would like to make the 3d-model
open-source.

The hdmi and usb power cables will need to reach the board in an L
shape, so it would be nice to easily route the cables to the top. The
headphone jack could also have a route, but exit to the bottom - to reach
the user.

But that is just the first part of the project.

I also would like to avoid using the usb micro to usb cable to connect
the keyboard to the pi 3b. I don't know how to do that elegantly, I can
only think of soldering a cable between the two usb ports and using some
usb plastic cap to avoid accidently using the port. But I don't even
know what is necessary.

I'd like to extend this idea and use a mux between those two ports. I
don't know if this is possible, but I want to connect the keyboard to
the pi 3b, but also be able to connect it to another computer. Is this
possible?

# Next

For my mk-1, I will now design, using openscad, a bed for the pi zero,
and will hotglue it to the base of the keyboard.

I'm using mk-1 as a development system and my goal is to build
text-based interfaces to help new programmers 
