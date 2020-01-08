export EDITOR=vi

export HISTSIZE=9999
export HISTFILESIZE=9999
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '
shopt -s histappend
shopt -s checkwinsize

export DISABLE_AUTO_TITLE=true

export PATH="/home/gfigueira/bin/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/gfigueira/bin/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/gfigueira/bin/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/gfigueira/bin/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/gfigueira/bin/perl5"
export LINUX_GIT=/home/gfigueira/git/linux
export COMP_WORDBREAKERS=${COMP_WORKBREAKERS/:/}
#export LS_COLORS=$LS_COLORS:'di=0;37:'
export PROMPT_COMMAND="history -a; history -n"

# aliases

alias webserver="python -m SimpleHTTPServer 8000"
alias open="xdg-open"
alias edit_alias="vi ~/.linux.sh;. ~/.bashrc; update_profile_git"
alias source_bash="source ~/.bashrc"
alias l="ls -1F --group-directories-first" 
alias ll="ls -lF --group-directories-first" 
alias ls="ls -F --group-directories-first"
alias zypper="sudo zypper"
alias translate="~/git/translate-shell/translate"
alias pt="~/git/translate-shell/translate -t pt"
alias cz="~/git/translate-shell/translate -t cs"
alias st="~/git/wiki/profile/shell.sh"

# SDI
alias b="bzg -b"
alias iosc="osc -A https://api.suse.de"
alias oosc="osc -A https://api.opensuse.org"
alias rpm-url="rpm -q --qf '%{DISTURL}\n'"
alias vpn="sudo ~/git/suse/bin/manage_vpn.sh"
alias vpns="sudo systemctl status openvpn@SUSE-NUE | tail -10 | cut -b64-144 | tail -1"

alias nmcli-show="nmcli device show wlp1s0"
alias nmcli-list="nmcli device wifi list"
alias nmcli-connect="sudo nmcli device wifi connect"

# functions

# brightness
bright ()
{
    echo $1 | sudo tee -a /sys/class/backlight/intel_backlight/brightness
}

rpm_size()
{
  sudo  rpm -qia | \
    awk '$1=="Name" { n=$3} $1=="Size" {s=$3} $1=="Description" {print s  " " n }' | \
    sort -n
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

# update Unix WIKI - linux version
update_profile_git()
{
  # FIXME - some vim plugins have wrong permissions
  # find . | egrep "*.pack|*.idx" | grep "objects/pack/" | while read a; do \
  # chmod 644 $a; done

  export SGR_shell_path="/home/gfigueira/git/wiki/profile"
  cp ~/.bashrc ${SGR_shell_path}/dotfiles/
  cp ~/.linux.sh ${SGR_shell_path}/dotfiles/
  cp ~/.common.sh ${SGR_shell_path}/dotfiles/
  cp ~/.vimrc ${SGR_shell_path}/dotfiles/
  cp -r ~/.vim ${SGR_shell_path}/dotfiles/
  cp ~/.tmux.conf ${SGR_shell_path}/dotfiles/
  cp ~/.gitconfig ${SGR_shell_path}/dotfiles/
  cp ~/.quiltrc ${SGR_shell_path}/dotfiles/
  cp ~/.irssi/agon.theme ${SGR_shell_path}/dotfiles/.irssi
  cp ~/.irssi/config ${SGR_shell_path}/dotfiles/.irssi
  cp ~/.aspell* ${SGR_shell_path}/dotfiles/
  cp ~/.rpmmacros ${SGR_shell_path}/dotfiles/
  cp ~/.mutt-color ${SGR_shell_path}/dotfiles/
  cp ~/.mailcap ${SGR_shell_path}/dotfiles/
  cp ~/.i3status.conf ${SGR_shell_path}/dotfiles/
  cp ~/.config/i3/config ${SGR_shell_path}/dotfiles/.config/i3/
  cat ~/.muttrc | egrep -v "imap_pass|smtp_pass" > ${SGR_shell_path}/dotfiles/.muttrc
  cat ~/.oscrc | egrep -v "pass =" > ${SGR_shell_path}/dotfiles/.oscrc
  cat ~/.l3t.yaml | egrep -v "auth-token" > ${SGR_shell_path}/dotfiles/.l3t.yaml

  echo -n "refresh store.data <y/n>? "
  read answer
  if [ "$answer" = "y" ]
    then
      tar cf ~/store.tgz ~/.password-store/
      openssl enc -aes-256-cbc \
        -in ~/store.tgz \
        -out $SGR_shell_path/dotfiles/.store.data
      rm ~/store.tgz
      # openssl enc -d -aes-256-cbc -in .store.data -out store.tgz
  fi
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
