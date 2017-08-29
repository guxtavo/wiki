#############################
# Source global definitions #
#############################

# https://github.com/torvalds/linux/blob/master/Documentation/CodingStyle

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#######
# fzf #
#######

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gfigueira/git/fzf/bin* ]]; then
  export PATH="$PATH:/home/gfigueira/git/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gfigueira/git/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/gfigueira/git/fzf/shell/key-bindings.bash"

##########
# global #
##########

# bash completion for global
# to enable type: complete -F global_func global
global_func()
{
        local cur
        cur=${COMP_WORDS[COMP_CWORD]}
        COMPREPLY=(`global -c $cur`)
}
# set completion on
complete -F global_func global

############################
# History specific command #
############################

#shopt -s histappend
#set -o vi

#############
# funcoeszz #
#############

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/home/gfigueira/git/funcoeszz/funcoeszz"  # script
export ZZDIR="/home/gfigueira/git/funcoeszz/zz"
source "$ZZPATH"

#############
# Variables #
#############

export PS1="[\W]\$ "
#export PATH=$PATH:~/redhat/scripts::~/redhat/git/myscripts/rh
export HISTSIZE=9999999
#export PROMPT_COMMAND='history -a; history -n'
export DISABLE_AUTO_TITLE=true
export EDITOR=vi

###########
# aliases #
###########

# power aliases
alias psg="ps kstart_time -ef"
alias ds="dstat -c -D sda -r --disk-util --top-bio --top-io-adv"
alias jbacik="ps auxH -L | grep \" D\"  | awk '{print $3}' | xargs -I '{}' bash -c \"echo '{}'; cat /proc/'{}'/stack\" > /tmp/pid_stack.out"

# User specific aliases
alias edit_alias="vi ~/.bashrc;. ~/.bashrc; update_profile_git"
alias source_bash="source ~/.bashrc"
alias t_edit="vi ~/.tmux.conf; tmux source-file ~/.tmux.conf; update_profile_git"
alias l="ls -lh" 
alias lr="ls -ltr | tail -40" 
alias ssh="ssh -X -o TCPKeepAlive=yes"

# Red Hat specific aliases
alias dropbox="lftp ftp://gfigueir@flopbox.corp.redhat.com"
alias fubar="ssh -c blowfish gfigueir@fubar.gsslab.pnq.redhat.com"
alias optimus="ssh gfigueir@optimus.gsslab.rdu2.redhat.com"
alias gg="/home/gfigueir/redhat/git/support-scripts/internal/gg"
alias csr="vi ~/redhat/git/myscripts/csr"
alias rhst="redhat-support-tool"
alias rter="printf '\e[8;40;105t'"
alias rh="cd ~/redhat/git/myscripts/rh"
alias p="dbus-send --session --dest=org.hexchat.service --print-reply --type=method_call /org/hexchat/Remote org.hexchat.plugin.Command string:'msg #gss-emea'"
alias c="~/redhat/git/myscripts/csr -m|less"
alias x="xsos -ay .|more"
alias fc="fold -sw 80 ~/Documents/80.txt | xsel"
alias cas="tail -f ~/redhat/scripts/cases.log"
alias dstate="awk '$8 ~ /^D/' ps"
alias nco="~/redhat/scripts/nco.sh"
alias eco="~/redhat/scripts/eco.sh"
alias pco="~/redhat/scripts/pco.sh"
alias ada="~/redhat/scripts/ada.sh"
alias tca="~/redhat/scripts/tca.sh"
alias csr="~/redhat/scripts/myscripts/csr . | less"
alias css="~/redhat/scripts/css.sh"
alias cdcl="cd;clear"

# git aliases
alias glo="git log --oneline"
alias gddir="git diff --dirstat=files,5,cumulative"
#alias gddirroot="git diff  --dirstat=files,0.000001,cumulative kernel-3.10.0-327.37.1.el7..kernel-3.10.0-514.el7  | grep " [a-z]\+/$" | sort -n"
alias journal="vi ~/git/wiki/journal.txt"
alias gbrl="git branch --remote --list"
alias rec="recordmydesktop --no-sound"
alias gitstat="~/git/wiki/profile/git-status.sh ~/git"
alias 17="cal 2017"
alias git_clean_all="git reset; git checkout .; git clean -fdx"

# SuSE
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
alias solid="elinks https://l3support.nue.suse.com/short/"

# tmux clipboard management
alias copy="tmux show-buffer|xclip"

# funcoes zz
# adding pagers for nice scripts 
# pagers are so short they should be a one-line function

# zzajuda
# zzlembrete
# zzlinux

wiki() { zzwikipedia -en $* | less ; }
dict() { zzenglish $* | less ; }
pt() { zzdicbabylon $* ; }

alias dado=zzdado
alias define=zzdefinr

#############
# functions #
#############

kb() 
{ 
        redhat-support-tool  kb $1 | less 
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
        rm -f $tmp_file ; }
eexec()
{ 
        iexec http://etherpad.corp.redhat.com/ep/pad/export/${1}/latest?format=txt
}

# tshark functions
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

# Aarav functions
#cco() { DATE=`date +%Y%m%d-%H%M` ;
#        vi ${DATE}.txt ;
#        echo File created ${DATE}.txt ;
#        gpaste file ${DATE}.txt ; }
#
#ec() { LOCAL_FILE=`ls -tr *.txt | tail -1` ;
#       vi $LOCAL_FILE ;
#       echo Finishing editing $LOCAL_FILE ;
#       gpaste file $LOCAL_FILE ; }

# clone kernel git repos
clone_rhel6() 
{
        cd ~/git 
	git clone git://git.app.eng.bos.redhat.com/rhel6.git
	cd rhel6
	git remote add rhel-6.0-z      git://git.app.eng.bos.redhat.com/rhel-6.0.z.git
	git remote add rhel-6.1-z      git://git.app.eng.bos.redhat.com/rhel-6.1.z.git 
	git remote add rhel-6.2-z      git://git.app.eng.bos.redhat.com/rhel-6.2.z.git
	git remote add rhel-6.3-z      git://git.app.eng.bos.redhat.com/rhel-6.3.z.git 
	git remote add rhel-6.4-z      git://git.app.eng.bos.redhat.com/rhel-6.4.z.git
	git remote add rhel-6.5-z      git://git.app.eng.bos.redhat.com/rhel-6.5.z.git 
	git remote add rhel-6.6-z      git://git.app.eng.bos.redhat.com/rhel-6.6.z.git 
	git remote add rhel-6.7-z      git://git.app.eng.bos.redhat.com/rhel-6.7.z.git
	git fetch --all --tags
	cd ..
}

clone_rhel7() 
{
	cd ~/git
	git clone git://git.app.eng.bos.redhat.com/rhel7.git
	cd rhel7
	git remote add rhel-7.0-z git://git.app.eng.bos.redhat.com/rhel-7.0.z.git 
	git remote add rhel-7.1-z git://git.app.eng.bos.redhat.com/rhel-7.1.z.git 
	git remote add rhel-7.2-z git://git.app.eng.bos.redhat.com/rhel-7.2.z.git
	git fetch --all --tags
	cd ..
}

afk() 
{ 
	context=`dbus-send --dest=org.xchat.service --print-reply --type=method_call /org/xchat/Remote org.xchat.plugin.FindContext string:"Red Hat IRC" string:"" | tail -n1 | awk '{print $2}'`
	dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.SetContext uint32:$context
	dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.Command string:"anick capcom|afk" 
}

oln()
{ 
	context=`dbus-send --dest=org.xchat.service --print-reply --type=method_call /org/xchat/Remote org.xchat.plugin.FindContext string:"Red Hat IRC" string:"" | tail -n1 | awk '{print $2}'`
	dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.SetContext uint32:$context
	dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.Command string:"anick capcom"
}

lunch()
{ 
	context=`dbus-send --dest=org.xchat.service --print-reply --type=method_call /org/xchat/Remote org.xchat.plugin.FindContext string:"Red Hat IRC" string:"" | tail -n1 | awk '{print $2}'`
	dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.SetContext uint32:$context
	dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.Command string:"anick capcom|lunch"
}

irc() 
{
        tail -f .config/xchat2/xchatlogs/* | egrep --line-buffered -v "CHANSERV gives|EDNING|LOGGING|Topic for|CHANSERV gives|is now known|has quit \(|xchatlogs|^$|has joined|points of karma.|Ping timeout:" | grep -i --color -E '^|gux|capcom|ping emea|ping brq|ping sbr-kernel'
}

ca() 
{ 
        redhat-support-tool getcase $1 | less
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
        cp ~/.tmux.conf ~/git/wiki/profile/
        cp ~/.gitconfig ~/git/wiki/profile/
}

pidstat_15()
{
        pidstat 5  | awk '{ if ($8 > 1.5) print}'
}

google()
{
        # replace default functionality, open I
        #elinks --dump www.google.com/search?q=$1 | head -16 | tail -1
        elinks www.google.com/search?q=$1
}

# I'm feeling lucky
gl()
{
        elinks --dump www.google.com/search?q=$1 | head -16 | tail -1
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
		play -q /usr/lib64/libreoffice/share/gallery/sounds/space.wav
		break;
         fi;
     done
}
alias pomo="countdown 1500 &"
