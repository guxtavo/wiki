Last try I failed writing a weather plugin that could reliably work with
positive and negative temperatures. I tried to patch that but the thing
as a whole looked ugly and still could not produce the correct result.

One of the main probems was the fact I used shell scripts to parse text
from a webpage full of ascii art:

    (0) ~ $ curl wttr.in/brno
    Weather report: brno

        \   /     Sunny
         .-.      19 °C
      ― (   ) ―   ↘ 11 km/h
         `-’      10 km
        /   \     0.0 mm

What kind of wheather plugin I want to write next?

    * One that works reliably across differen seasons
    * One that doesn't use patchy tricks to extract data
    * Separate showing data from gathering data

First step is to have a look at the README.md file from the source I'm
using: wttr.in:

    git clone https://github.com/chubin/wttr.in
    cd wttr.in
    view README.md

There is the possibility of using a custom format that is suitable for
script \o/

    curl wttr.in/Brno?format="%f+%p+%w\n"

Voila, a much better weather script.
