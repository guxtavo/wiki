if test "`find /tmp/git_status -mmin +10`"
then
  ~/git/wiki/profile/git-status.sh ~/git | egrep "Modified|Untracked" > /tmp/git_status
fi

cat /tmp/git_status | wc -l
