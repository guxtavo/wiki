awk '/#TASKS/,/^$/' ~/git/wiki/journal.txt | egrep -v "TASKS|^$" | wc -l
