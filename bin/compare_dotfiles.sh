#!/bin/bash

OBSD_only=".profile .Xsessions"
SENSITIVE=".oscrc .muttrc .l3t.yaml"
GREP-V="pass|token"

FILES=$(ls -a ~/git/wiki/profile/dotfiles)

for x in $FILES; do
    if [ -f $x ]; then
        if ! diff ~/$x ~/git/wiki/profile/dotfiles/$x >/dev/null 2>&1; then
            echo cp ~/$x ~/git/wiki/profile/dotfiles
        fi
    fi
done
