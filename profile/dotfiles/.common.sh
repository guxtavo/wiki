# common to all unixes

# variables

# basic setup
export PS1="$(echo '($?)') \W \$(__git_ps1 '(%s)')$ "
export PATH="$PATH:/home/gfigueira/bin/suse:/home/gfigueira/bin/wiki"

# aliases

# time
alias date_london="TZ=Europe/London date"
alias date_prague="TZ=Europe/Prague date"
alias date_brazil="TZ=Brazil/East date"
alias date_provo="TZ=US/Mountain date"
alias date_beijing="TZ=Asia/Beijing date"

# journals
alias journal="vi ~/git/wiki/index.md"
alias suse="vi ~/git/suse/wiki/calendar.md"
alias sdi="vi ~/git/suse/index.md"
alias 512=" vi ~/git/wiki/Zero512.md"

# random stuff
alias w3m="w3m -M"
alias 80="cut -b1-80"
alias ssh="ssh -X -o ServerAliveInterval=5"
alias use-e="egrep -i 'bug|error|warn|fatal'"
alias rsyncssh="rsync -r -a -v -e ssh --delete --info=progress2"

# web favourites
alias pes="w3m https://pes.suse.de/L3/"
alias markdown="w3m https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
alias vim_cheat_sheet="w3m https://vim.rtorr.com/"
alias rfc="w3m https://tools.ietf.org/rfc/index"

# script
alias script-save="script -t 2> time_$(date +%s).log -a session_$(date +%s).log"
alias scriptreplay="scriptreplay -t time.log -s session.log -d 2 -m 1"

# git
alias git_clean_all="git reset; git checkout .; git clean -fdx"

# sdi
alias lthree="ssh l3slave.suse.de"
alias polio="ssh polio.suse.cz"
alias l3vm="ssh polio.suse.cz l3vm"
alias vv="virt-viewer -c qemu+ssh://gfigueira@polio.suse.cz/system -w"
alias ism="ssh l3slave.suse.de /mounts/work/src/bin/is_maintained -b"
alias orthos="ssh l3slave.suse.de /mounts/users-space/archteam/bin/orthos"
alias stel="ssh l3slave.suse.de /suse/bin/stel"
alias tel="ssh l3slave.suse.de /suse/bin/tel"
alias orthos="ssh sconsole1.arch.suse.de"

# functions

dice()
{
  echo $(( ( RANDOM % 19 )  + 1 ))
}

define()
{
  w3m -dump definr.com/$1
}

s()
{
  w3m -M www.google.com/search?q="$(echo $*)"
}

wiki()
{
  w3m -M https://en.wikipedia.org/wiki/Special:Search/"$(echo $*)"
}

fz()
{
  w3m -M fastzilla.suse.de/?q="$@"
}

mu()
{
  w3m https://maintenance.suse.de/search/?q="$@"
}

check()
{
  echo $1 | aspell -a
}

stopwatch()
{
  since=$(date +%s);watch -tn 1 eval "echo \$(($1-\$(date +%s)+$since))"
}

countdown ()
{
  id=$(od -vAn -N2 -tx1 < /dev/urandom | sed 's/ //g')
  tmux display-message "Timer $id created"
  if (($# != 1)) || [[ $1 = *[![:digit:]]* ]]; then
    echo "Usage: countdown seconds";
    return;
  fi;
  local t=$1 remaining=$1;
  SECONDS=0;
  while sleep .9; do
    echo $remaining > /dev/shm/countdown.$id;
    if (( (remaining=t-SECONDS) <= 0 )); then
      rm -rf /dev/shm/countdown.$id
      set AUDIODRIVER=oss
      play -q ~/git/wiki/profile/resources/space.wav
      tmux display-message "Timer $id is over"
      break;
    fi;
  done
}

alias ten="countdown 10 &"
alias tea="countdown 300 &"
alias pomodoro="countdown 1500 &"
alias deep="countdown 5400 &"

e8()
{
  COL=$(stty size | awk '{print $2}')
  cut -b1-$COL
}

colors()
{
  for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i} "; done
}

# run fortune and set caps as ctrl
fortune ~/git/wiki/profile/resources/quotes
setxkbmap -option ctrl:nocaps
