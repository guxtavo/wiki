# .bashrc

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

export PS1="[\W]\$ "
export HISTSIZE=9999
export HISTFILESIZE=9999
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '
shopt -s histappend
shopt -s checkwinsize
export DISABLE_AUTO_TITLE=true
export EDITOR=vi
export LS_COLORS=$LS_COLORS:'di=0;37:'
PATH="/home/gfigueira/bin/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/gfigueira/bin/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/gfigueira/bin/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/gfigueira/bin/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/gfigueira/bin/perl5"; export PERL_MM_OPT;
export PATH="$PATH:/home/gfigueira/bin/suse:/home/gfigueira/bin/wiki"

# fzf setup
if [[ ! "$PATH" == */home/gfigueira/git/fzf/bin* ]]; then
  export PATH="$PATH:/home/gfigueira/git/fzf/bin"
fi
[[ $- == *i* ]] && source "/home/gfigueira/git/fzf/shell/completion.bash" 2> /dev/null
source "/home/gfigueira/git/fzf/shell/key-bindings.bash"

# bash completion for global
global_func()
{
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=(`global -c $cur`)
}
complete -F global_func global


# aliases

alias 512=" vi ~/git/wiki/Zero512.md"
alias pi="ssh pi@192.168.10.1"
alias obsd="ssh root@192.168.1.243"
alias nocaps="setxkbmap -option ctrl:nocaps"
alias psg="ps kstart_time -ef"
alias pst="ps aux | sort -k10 | cut -b 1-79 | tail -11"
alias ds="dstat -c -D sda -r --disk-util --top-bio --top-io-adv"
alias jbacik="ps auxH -L | grep \" D\"  | awk '{print $3}' | xargs -I '{}' bash -c \"echo '{}'; cat /proc/'{}'/stack\" > /tmp/pid_stack.out"
alias 80="cut -b1-80"
alias webserver="python -m SimpleHTTPServer 8000"
alias dstate="awk '$8 ~ /^D/' ps"
alias w3m="w3m -M"
alias open="xdg-open"
alias a1="awk '{print $1}'"
alias a2="awk '{print $2}'"
alias a3="awk '{print $3}'"
alias edit_alias="vi ~/.bashrc;. ~/.bashrc; update_profile_git"
alias source_bash="source ~/.bashrc"
alias t_edit="vi ~/.tmux.conf; tmux source-file ~/.tmux.conf; update_profile_git"
alias l="ls -lh --group-directories-first" 
alias lr="ls -ltr | tail -40" 
alias ssh="ssh -X -o TCPKeepAlive=yes"
alias glo="git log --oneline"
alias gddir="git diff --dirstat=files,5,cumulative"
#alias gddirroot="git diff  --dirstat=files,0.000001,cumulative kernel-3.10.0-327.37.1.el7..kernel-3.10.0-514.el7  | grep " [a-z]\+/$" | sort -n"
alias journal="vi ~/git/wiki/journal.txt"
alias gbrl="git branch --remote --list"
alias rec="recordmydesktop --no-sound"
alias gitstat="~/git/wiki/profile/git-status.sh ~/git"
alias git_clean_all="git reset; git checkout .; git clean -fdx"
alias iosc="osc -A https://api.suse.de"
alias ptf="ssh l3slave.suse.de"
alias stel="ssh l3slave.suse.de /suse/bin/stel"
alias tel="ssh l3slave.suse.de /suse/bin/tel"
alias polio="ssh polio.suse.cz"
alias l3vm="ssh polio.suse.cz l3vm"
alias noe="ssh noe.suse.cz"
alias vpn="sudo ~/git/suse/bin/manage_vpn.sh"
alias zypper="sudo zypper"
alias pvirsh="sudo virsh -c qemu+ssh://gfigueira@polio.suse.cz/system"
alias suse="vi ~/git/suse/suse.txt"
alias progress="l3ls -m | egrep 'IN_PROGRESS|NEW|CONFIRM' | cut -b 1-80 | sort -k2"
alias pes="w3m -M https://pes.suse.de/L3/"
alias w3m_cheat_sheet="w3m -M https://github.com/janosgyerik/cheatsheets/blob/master/W3m-cheat-sheet.mediawiki"
alias markdown="w3m -M https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
alias vim_cheat_sheet="w3m -M https://vim.rtorr.com/"
alias rfc="elinks https://tools.ietf.org/rfc/index"
alias aurelio="vi git/suse/aurelio.txt"
alias script-save="script -t 2> time.log -a session.log"
alias scriptreplay="scriptreplay -t time.log -s session.log -d 2 -m 1"
alias vu="amixer -q sset Master 3%+"
alias vd="amixer -q sset Master 3%-"
alias use-e="egrep -i 'bug|error|warn|fatal'"
alias search="s"
alias google="s"
alias translate="~/git/translate-shell/translate"
alias pt="~/git/translate-shell/translate -t pt"
alias cz="~/git/translate-shell/translate -t cs"
alias st="~/git/wiki/profile/status-right-tumbleweed.sh"
alias orthos="ssh l3slave.suse.de /mounts/users-space/archteam/bin/orthos"

# functions

dado()
{
  echo $(( ( RANDOM % 19 )  + 1 ))
}

define()
{
  w3m -dump definr.com/$1
}

bawk(){
  awk '/"$1"/,/^$/' $2
}

di()
{
  w3m -dump "http://www.dict.org/bin/Dict?Form=Dict2&Database=*&Query=$1" | less
}

loc()
{
  find . -name "*$1*"
}

new()
{
  ~/redhat/scripts/new.sh $1
  cd ~/redhat/cases/$1
}

cdc()
{
  if [ -d  ~/redhat/cases/$1 ]
  then
    cd ~/redhat/cases/$1
    ls -l ; else mkdir ~/redhat/cases/$1
    cd ~/redhat/cases/$1
    ls -l
  fi
}

erpm()
{
  rpm2cpio $1 | cpio -idmv
}

eimg()
{
  mv $1 $1.gz
  gunzip $1.gz
  mkdir img
  mv $1 img/
  cd img
  cat $1 | cpio -idmv
}

iexec()
{
  tmp_file=`mktemp` \
    curl -s "$1" -o $tmp_file ; \
    chmod +x $tmp_file ; \
    $tmp_file; \
    rm -f $tmp_file ;
}

t_con()
{
  tshark -tad -r $1 -z "conv,tcp" -q
}

t_phs()
{
  tshark -tad -r $1 -z "io,phs" -q
}
t_exp()
{
  tshark -tad -r $1 -z "expert,note,tcp" -q
}

t_latency()
{
  tshark -n -r $1  -T fields -e ip.src -e tcp.analysis.ack_rtt "tcp.analysis.ack_rtt" 2>/dev/null | sort -nrk2 | head
}

make_git_alias()
{
  export PS1="\\w:\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\$ "
}

battery_left(){
  acpi -V | head -1 | awk '{print $5}' | cut -b 1-5
}

weather(){
  if test "`find /tmp/weather -mmin +30`"
  then
    curl wttr.in/Brno > /tmp/weather
  fi
  head -4 /tmp/weather  | tail -2 | cut -b 31-71 | sed 'N;s/\n/ /'
}

function git_branches()
{
  if [[ -z "$1" ]]; then
    echo "Usage: $FUNCNAME <dir>" >&2
    return 1
  fi

  if [[ ! -d "$1" ]]; then
    echo "Invalid dir specified: '${1}'"
    return 1
  fi

  # Subshell so we don't end up in a different dir than where we started.
  (
  cd "$1"
  for sub in *; do
    [[ -d "${sub}/.git" ]] || continue
    echo "$sub [$(cd "$sub"; git  branch | grep '^\*' | cut -d' ' -f2)]"
  done
  )
}

update_profile_git()
{
  cp ~/.bashrc ~/git/wiki/profile/
  cp ~/.vimrc ~/git/wiki/profile/
  cp ~/.tmux.conf ~/git/wiki/profile/.tmux.conf-tumbleweed
  cp ~/.gitconfig ~/git/wiki/profile/
  cp ~/.quiltrc ~/git/wiki/profile/
  cp -r ~/.vim ~/git/wiki/profile/
  cp ~/.mutt-color ~/git/wiki/profile/
  cp ~/.irssi/agon.theme ~/git/wiki/profile/.irssi
  cp ~/.aspell* ~/git/wiki/profile/
}

pidstat_15()
{
  pidstat 5  | awk '{ if ($8 > 1.5) print}'
}

s()
{
  # replace default functionality, open I
  #elinks --dump www.google.com/search?q=$1 | head -16 | tail -1
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

set_target()
{
  echo $1 > ~/.config/target
}

# limit.pid - blkio wrarpper for running pids
# Usage: ./limit_pid [bps] PID
limit_io_pid()
{
  cgroup_name=$(basename $(mktemp -d))
  blkio_path=/sys/fs/cgroup/blkio
  mm_ids="253:1" # fedora-root
  pid=$2
  bw=$1

  sudo mkdir ${blkio_path}/${cgroup_name}

  echo "${mm_ids} ${bw}" | sudo tee \
    ${blkio_path}/${cgroup_name}/blkio.throttle.write_bps_device 
  echo "${mm_ids} ${bw}" | sudo tee \
    ${blkio_path}/${cgroup_name}/blkio.throttle.read_bps_device 
  echo ${pid} | sudo tee \
    ${blkio_path}/${cgroup_name}/tasks
}

# limit_io_run - blkio wrarpper for ephemeral processes
# Usage: ./limit.io [bps] command [args]
limit_io_run()
{

  cgroup_name=$(basename $(mktemp -d))
  blkio_path=/sys/fs/cgroup/blkio
  command=${*:2}
  mm_ids="253:1" # fedora-vg
  bw=$1

  sudo mkdir ${blkio_path}/${cgroup_name}

  echo "${mm_ids} ${bw}" | sudo tee \
    ${blkio_path}/${cgroup_name}/blkio.throttle.write_bps_device
  echo "${mm_ids} ${bw}" | sudo tee \
    ${blkio_path}/${cgroup_name}/blkio.throttle.read_bps_device

  if [ $(id -u) != "0" ]
  then 
    sudo chown -R $(id -u) ${blkio_path}/${cgroup_name}/
  fi

  cgexec -g blkio:${cgroup_name} $command
  sudo cgdelete -g blkio:${cgroup_name}
}

# lslimit - list blkio cgroups bw and pids
# Usage: ./lslimit
lslimit()
{
  blkio_path=/sys/fs/cgroup/blkio
  READ_PATH="/blkio.throttle.read_bps_device"
  WRITE_PATH="/blkio.throttle.write_bps_device"

  for i in $(ls -d $blkio_path/tmp*/)
  do
    echo
    echo $i
    echo
    cat ${i}${WRITE_PATH}
    cat ${i}${READ_PATH}
    cat ${i}/tasks | perl -p -e 's/\n/ /g'
    echo
  done
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
  if (($# != 1)) || [[ $1 = *[![:digit:]]* ]]; then
    echo "Usage: countdown seconds";
    return;
  fi;
  local t=$1 remaining=$1;
  SECONDS=0;
  while sleep .9; do
    echo $remaining > /tmp/countdown;
    if (( (remaining=t-SECONDS) <= 0 )); then
      rm -rf /tmp/countdown
      set AUDIODRIVER=oss
      play -q ~/git/wiki/profile/space.wav
      break;
    fi;
  done
}

pomo(){
  if [ -e /tmp/countdown ]; then
    kill -9 $(cat /tmp/pomo)
    rm /tmp/pomo
    rm /tmp/countdown
  else
    countdown 1500 &
    echo $! > /tmp/pomo
  fi
}

irc_get()
{
  total=0
  grep -hc capcom ~/irclogs/suse/* | while read a
do
  total=$(( $a + $total ))
  echo $total
done | tail -1
}

e8()
{
  COL=$(stty size | awk '{print $2}')
  cut -b1-$COL
}

colors()
{
  for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i} "; done
}

# End of variables, aliases and functions

fortune ~/git/wiki/profile/quotes
setxkbmap -option ctrl:nocaps
