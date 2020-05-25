#!/bin/bash

OBSD_only=".profile .Xsessions"
SENSITIVE=".oscrc .muttrc .l3t.yaml"
GREPV="pass|token"

FILES=$(ls -a ~/git/wiki/devkit/dotfiles)

for x in $FILES; do
    if [ -f $x ]; then
        if ! diff ~/$x ~/git/wiki/devkit/dotfiles/$x >/dev/null 2>&1; then
            echo cp ~/$x ~/git/wiki/devkit/dotfiles
        fi
    fi
done

if ! diff ~/.config/i3/config ~/git/wiki/devkit/dotfiles/.config/i3/config >/dev/null 2>&1; then
    echo cp ~/.config/i3/config ~/git/wiki/devkit/dotfiles/.config/i3/
fi
