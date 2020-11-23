#!/bin/bash
count=0
ls *.* | while read a b
do
    echo ${a##*.}
done | sort | uniq -c | sort -rn
echo total $(ls *.* | wc -l)
