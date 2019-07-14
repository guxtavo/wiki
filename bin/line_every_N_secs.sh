#!/bin/bash

SLEEP=5
LINE="227ms | DP|FIT|L3ech | %43T 16-21. | ? / 26/57 | % | E | Sun W28 2019-07-14 21:07 <"

function show_line()
{
	echo $LINE || echo ""
}

while true
do
	show_line
	sleep $SLEEP
done
