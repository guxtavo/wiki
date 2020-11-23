This website uses cookies to improve service and provide tailored ads. By using
this site, you agree to this use. See our Cookie Policy
dismiss
 

  • Sign in
  • Join now

Using Traps in Bash Scripts

Published on October 29, 2020October 29, 2020 • 8 Likes • 2 Comments

  • Report this post

Gabriel MarquesFollow

Linux Systems Administrator / IT Consultant

  • Like8
  • Comment2
  • [ ]Share
      □ LinkedIn
      □ Facebook
      □ Twitter
    0

Imagine that you have a script to perform some critical operation, one that
would render the system completely unusable if interrupted, as well as loosing
and corrupting data. I am sure you just remembered about some tragic sad
stories from the past, didn't you? Well, I do remember some terrible situations
in which I went to help some friends recovering systems shot in the head by the
execution of "innocent scripts".

Many of those situations (not to say all of them) could be avoided by using
traps inside those "innocent scripts". What is a trap?

In short, a trap is a Bash builtin command, defined in trap.c, that capture
signals and then execute the provided arg. It has the syntax:

trap arg signal [signal ...]

So, for example, when you hit ^C, ^D, ^Z, ..., you are sending a signal to a
running job. In the same way, when you issue a kill command, you are sending a
signal to a program (using its PID). Traps catch these signals and execute the
action provided as arg.

Let's see that in action. First, imagine the reckless (snippet) version of an
"innocent script".

#!/bin/bash

do_critical_stuff() {
   MEANING_OF_LIFE=42
}


[...]

# Prepare to do critical operation ...
do_critital_stuff

# keep going with the rest of the script...
[...]

Now, imagine what would happen if your script crashed/got killed exactly during
the do_critical_stuff() function execution! Yes! You have lost the meaning of
life! How tragic that would be! ;) Serious, now ... imagine that instead of
this fun snipped, that function would perform some server critical operation!
You should have some way of preventing this script from being put down and
taking the whole system with it. Now enter the trap command! Check the same
script, but with trap implemented.

#!/bin/bash

do_critical_stuff() {
   MEANING_OF_LIFE=42
}

trapped() {
   echo -e "You can't stop now!"
}

[...]

# create the trap
trap trapped INT TERM KILL

Prepare to do critical operation
do_critital_stuff

# get rid of the trap (or it will be executed when this script exits)
trap - TERM INT KILL

# keep going with the rest of the script...

[...]

Did you see that? You made little modification to the script, but now that
"innocent script" is aware of the dangers that might arise from its
responsibilities. You took care of anyone trying to kill your script, as well
as sending interrupts to it.

Keep that in mind when writing your next critical section within any of your
scripts.

Happy scripting!

--FIN--




Published By

Gabriel Marques

Linux Systems Administrator / IT Consultant

Follow

#bash #shellscripting #shell #linux #linuxw #linuxsystemadministration #
linuxserver #systemadministration #systemadministrator #systemengineer #debian
#ubuntu #servers #safetyfirst

2 comments
article-comment__guest-image
Sign in to leave your comment
Show more comments.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

More from Gabriel Marques

35 articles

Safer Bash Scripting Tips

October 29, 2020

Pointers and 2D-arrays in C

October 17, 2020

Linux Kernel Inotify Subsystem

October 12, 2020

  • LinkedIn© 2020
  • About
  • Accessibility
  • User Agreement
  • Privacy Policy
  • Cookie Policy
  • Copyright Policy
  • Brand Policy
  • Guest Controls
  • Community Guidelines
  • 
      □ العربية (Arabic)
      □ Čeština (Czech)
      □ Dansk (Danish)
      □ Deutsch (German)
      □ English (English)
      □ Español (Spanish)
      □ Français (French)
      □ Bahasa Indonesia (Bahasa Indonesia)
      □ Italiano (Italian)
      □ 日本語 (Japanese)
      □ 한국어 (Korean)
      □ Bahasa Malaysia (Malay)
      □ Nederlands (Dutch)
      □ Norsk (Norwegian)
      □ Polski (Polish)
      □ Português (Portuguese)
      □ Română (Romanian)
      □ Русский (Russian)
      □ Svenska (Swedish)
      □ ภาษาไทย (Thai)
      □ Tagalog (Tagalog)
      □ Türkçe (Turkish)
      □ 简体中文 (Chinese (Simplified))
      □ 正體中文 (Chinese (Traditional))
    Language

