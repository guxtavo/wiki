#!/bin/bash

HOGS=$(systat -s 0.1 -b pigs | grep gfigueira | awk '{print $3 " " $4"%"}')

show_hogs()
{
		if [ "$HOGS" != "" ]
			then
				echo $HOGS
		fi
}
