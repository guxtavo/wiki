#!/bin/bash
gux_birth=348340020
now=$(date +%s)
diff=$(( ( now - gux_birth ) / 60 / 60 / 24 / 7 ))
echo $diff weeks until you are 70 years old
echo
#read
i=0
for (( i = 0 ; i < diff ; i++ ));
do
echo -n .
done
echo
