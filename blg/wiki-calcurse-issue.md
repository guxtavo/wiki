How to show the event which is happening right now with -a?

I have searched a while and could not find the answer to my question. Apologies
if there is a known thread somewhere about this.

(0) ~ $ calcurse -v
calcurse 4.5.0 -- text-based organizer

**Bug description.** It is not a bug, it is a question.

When one is inside the TUI, one can see an exclamation mark (!) on the event
which currently is happening.

I want to use the non-interactive mode (calcurse -a) and get as output the
event which is happening right now or and empty result if nothing is happening.

TUI:
│  *!13:00 -> 14:30  
│    Wiki (code) 

calcurse -a:
  - 13:00 -> 14:30
        Wiki (code)
If
