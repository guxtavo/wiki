#!/bin/bash
# bounce.sh - a simple bouncing for the terminal using tput(1)
#
INTERVAL="0.02"
ROW=$(tput lines)
COL=$(tput cols)
floor=$(( ROW - 2 ))
ceiling=0
left_wall=2
right_wall=$(( COL - 2 ))
start_col=$left_wall
column=$start_col
bounces=5

function initialize(){
    tput init
    tput clear
    tput civis # Set to cursor to be invisible
}

function exit-and-clean(){
    tput cup "$ROW" 0
    tput cnorm # Set the cursor to its normal state
    exit 0
}

function check-direction(){
    if [ $column -ge $right_wall ]; then
        export direction=left
    elif [ $column -lt $left_wall ]; then
       export direction=right
    fi
}

function write-dot(){
    tput cup "$1" "$2" # <row> <col>  Move the cursor to position row, col
    sleep $INTERVAL
    echo o
}

function go-down(){
    # going down and right
    if [ $direction = "right" ]; then
        # increase lines up till ceiling
        for (( lines=ceiling; lines<floor; lines++ ))
        do
            write-dot $lines $column
            # increase columns up till right_wall
            column=$(( column + 1 ))
        done
    fi

    if [ $direction = "left" ]; then
        for (( lines=ceiling; lines<floor; lines++ ))
        do
            write-dot $lines $column
            column=$(( column - 1 ))
        done
    fi

    check-direction
}

function go-up(){
    if [ $direction = "right" ]; then
        for (( lines=floor; lines>ceiling; lines-- ))
        do
            write-dot $lines $column
            column=$(( column + 1 ))
        done
    fi

    if [ $direction = "left" ]; then
        for (( lines=floor; lines>ceiling; lines-- ))
        do
            write-dot $lines $column
            column=$(( column - 1 ))
        done
    fi

    check-direction
}

function main(){
    initialize
    direction=right
    go-up

    for (( i=0; i<bounces; i++ ))
    do
        go-down
        go-up
    done

    exit-and-clean
}

main
