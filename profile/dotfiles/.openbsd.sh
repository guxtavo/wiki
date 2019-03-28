export CVSROOT=anoncvs@mirror.osn.de:/cvs

export HISTFILE="/home/gfigueira/.ksh_history"
export HISTSIZE=9999

alias vpn_on="doas openvpn --daemon --config /etc/openvpn/SUSE.conf.PRG"
alias vpn_off="doas pkill openvpn"
alias vpn-dns="doas ksh /etc/openvpn/dns.suse"
alias vpn-dns-home="doas ksh /etc/openvpn/dns.home"
