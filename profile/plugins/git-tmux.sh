#!/usr/bin/env bash

update_tmp(){
  ~/git/wiki/profile/git-status.sh ~/git | egrep "Modified|Untracked" > /tmp/git_status
}

if test ! -e /tmp/git_status
then
  update_tmp
fi

if test "`find /tmp/git_status -mmin +3`"
then
  update_tmp
fi

cat /tmp/git_status | wc -l | awk '{print $1}'
