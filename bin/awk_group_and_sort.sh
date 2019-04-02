#!/bin/bash

# This will group by $2 and sort by $4

cat emlhd074_stat_migrations_16_52.txt | awk '
	NR == 1 { print; next }
	{ a[$2] += $4 }
	END {
		for (i in a) {
	    	printf "%-15s\t%s\n", i, a[i];
    	}
  	}
' | sort -nk2
