# $OpenBSD: dot.profile,v 1.4 2005/02/16 06:56:57 matthieu Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games:.
export PATH HOME TERM

###########
# aliases #
###########

# power aliases
alias psg="ps kstart_time -ef"

# User specific aliases
alias edit_alias="vi ~/.profile;. ~/.profile; update_profile_git"
alias t_edit="vi ~/.tmux.conf; tmux source-file ~/.tmux.conf; update_profile_git"
alias l="ls -lh" 
alias ll="ls -lahtr" 
alias lr="ls -ltr | tail -40" 
alias ssh="ssh -X -o TCPKeepAlive=yes"
alias journal="vi ~/git/wiki/journal.txt"
alias top="top -SC"

# git aliases
alias glo="git log --oneline"
alias gddir="git diff --dirstat=files,5,cumulative"
#alias gddirroot="git diff  --dirstat=files,0.000001,cumulative kernel-3.10.0-327.37.1.el7..kernel-3.10.0-514.el7  | grep " [a-z]\+/$" | sort -n"
alias gbrl="git branch --remote --list"
alias gitstat="~/git/wiki/profile/git-status.sh ~/git"
alias git_clean_all="git reset; git checkout .; git clean -fdx"

# SuSE
alias iosc="osc -A https://api.suse.de"
alias ptf="ssh l3slave.suse.de"
alias stel="ssh l3slave.suse.de /suse/bin/stel"
alias tel="ssh l3slave.suse.de /suse/bin/tel"
alias polio="ssh polio.suse.cz"
alias l3vm="ssh polio.suse.cz l3vm"
alias l3="ls ~/git/suse"
alias noe="ssh noe.suse.cz"
alias vpn_on="doas openvpn --daemon --config /etc/openvpn/SUSE.conf.PRG"
alias vpn-dns="doas /etc/openvpn/dns.suse"
alias vpn-dns-home="doas /etc/openvpn/dns.home"
alias vpn_off="doas pkill openvpn"
alias pvirsh="sudo virsh -c qemu+ssh://gfigueira@polio.suse.cz/system"
alias solid="w3m https://l3support.nue.suse.com/short/"
alias suse="vi ~/git/suse/suse.txt"
alias progress="l3ls -m | egrep 'IN_PROGRESS|NEW' | cut -b 1-80 | sort -k2"

# tmux clipboard management
alias copy="tmux show-buffer|xclip"

###########
# aliases #
###########

update_profile_git()
{
        cp ~/.profile ~/git/wiki/profile/
        cp ~/.Xdefaults ~/git/wiki/profile/
        cp ~/.vimrc ~/git/wiki/profile/
        cp ~/.tmux.conf ~/git/wiki/profile/.tmux.conf-openbsd
        cp ~/.gitconfig ~/git/wiki/profile/
        cp ~/.quiltrc ~/git/wiki/profile/
}

set_target()
{
        echo $1 > ~/.config/target
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
		aucat -i ~/git/wiki/profile/space.wav
		break;
         fi;
     done
}

alias 1500="countdown 1500 &"

#pomo()
#{
#	echo $date "-" $* >> git/wiki/pomo.log
#	1500
#}
