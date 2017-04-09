#!/bin/bash


for (( i = 0 ; i < 10 ; i++ ))
do
  tput clear
  tput cup 1 2
  for (( j = $i ; j > 0 ; j--  ))
    do
      echo -n "#"
    done
  sleep 1
done
echo
echo
