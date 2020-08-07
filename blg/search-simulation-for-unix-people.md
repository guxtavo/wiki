% How to use your system without searching the web
% Gustavo Figueira

Modern operating systems will go to some lengths in providing a good set of
documentation in the base system.

     The man utility displays the manual pages entitled name.  Pages may be
     selected according to a specific category (section) or machine
     architecture (subsection).

	 OpenBSD man(1) - the base system provides high quality information

It is often the case that a search will return you the web version of a man
page, which is already in your system, so why do we still lose time searching
outside? I guess this has todo with the fact that most computer users use the
mouse as an indispensible tool for productivity.

But since our job is carried in the command line (tmux, vi, git) most of the
time, does it make sense to leave the terminal?

In some previous years, Google started the "Google Linux" project, a specific
search that captures "Operating System" signals to show you the most relevant
information. The use of signals here is the same Google employs. What I mean
to say is that a specific search algorythm can talk a different language, or
try to extrapolate some jargon to give you what you are looking for.

The reason Stack Overflow is so popular is because newbies can come with
questions that defy logic, and the community tries relentlessly to bridge the
knowledge gap and explain how the facts for the question are flawded so the
person asking can understand why the code/question at hand doesn't make sense.

I admit I don't use 'man -k' often, and I should. It is very tempting to not
try your question in the internet archive, because they framed the question the
same way you did, so the language make sense in your context. Then somebody
will answer what 1) documentation to read, where the 2) source code is and who
to 3) contact if you need an extra pair of eyes.

So why can't we have a conversation with our system and be led to this high
quality amount of data that is already locally at our machine, just waiting to
be discovered?

I guess you can see this could be answered with some AI. That would probably
cover 80% of the cases, if the AI can teach you like if it was an experienced
OS engineer. But that is beyond my knowledge.

		What if we could cover 20% of the problems? But doing it well.

I've been thinking for some time about how to make a teaching app for Linux,
which teaches you Linux.

Signals:

# Input:		_shell_  and a _task_ to an user 
# Output:		user writes down their own questions
# Constraints:	Under 30 seconds - time reset's once task is finished OK
# Edge cases:	who will answer the question's left?
#				what incentive to answer questions people will have?

Data:

	taskid	question


The problem with Stack Overflow, Quora and other sites is that they are web
based, and have polluted visuals (unless you use an adblocker - in my case I
use w3m, and it is not a pleasant experience if I have to be honest.

So I guess I want to fix this problem, how to get answers to your searches
quickly using the command line. What we will cover?

	bash, c, markdown, git, tmux, vi, kernel, build system, etc
	regular expressions

So you get to a system with a task, and you are able to do it without touching
the web, all offline, directly from the command line. 

# How to list all man pages from a given section


                   1         General commands (tools and utilities).
                   2         System calls and error numbers.
                   3         Library functions.
                   3p        perl(1) programmer's reference guide.
                   4         Device drivers.
                   5         File formats.
                   6         Games.
                   7         Miscellaneous information.
                   8         System maintenance and operation commands.
                   9         Kernel internals.

		OpenBSD man(1) - All the available sections

To find out how many man pages each section has, go to /usr/share/man and run:

		(0) man $ ls | grep man'[0-9]' | while read a
		> do
		> echo $a $(ls $a/|wc -l)
		> done
		man1 523
		man2 143
		man3 1089
		man3p 576
		man4 610
		man5 122
		man6 41
		man7 30
		man8 301
		man9 160

Give the user feedback everytime they run man(1) - make a counter

Make the system with levels, so the user can gradually get deeper. Allow user
to shift gears from start to try harder challenges on higher levels.

man(1) points will count towards leveling up.

Use users history to count this -> not very reliable
Read it in real time, save buffers and checkpoints

A
Use an alias to count that - save to a database


Think of the old Commodore 64. It came with a thick manual that thaught you
basic, a scripting language easy to learn. We will teach you bash and c
instead, since that is very prevalent in the Linux/Unix worl. Sometimes I will
use the term Linux and sometimes Unix. For me they are the same, because both
stem from the POSIX standard.

Mimmicing google is no easy task. They build this spider, which fetches the web
pages for the whole internet. On top of that they build the algorythms to find
the signals. Not to mention their page rank, which makes websites which are
citted the most to have higher relevance.


