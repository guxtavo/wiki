export CVSROOT=anoncvs@mirror.osn.de:/cvs

export HISTFILE="/home/gfigueira/.ksh_history"
export HISTSIZE=9999
export EDITOR=vi
set -o emacs

alias vpn_on="doas openvpn --daemon --config /etc/openvpn/SUSE.conf.PRG"
alias vpn_off="doas pkill openvpn"
alias vpn-dns="doas ksh /etc/openvpn/dns.suse"
alias vpn-dns-home="doas ksh /etc/openvpn/dns.home"

update_profile_git_openbsd()
{
  export SGR_shell_path="/home/gfigueira/git/wiki/profile"
  cp ~/.profile ${SGR_shell_path}/dotfiles/
  cp ~/.openbsd.sh ${SGR_shell_path}/dotfiles/
  cp ~/.tmux.conf ${SGR_shell_path}/dotfiles/.tmux.conf-openbsd
}
