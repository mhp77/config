##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##
##
## Abstract:
##   Shell initialization script ~/.bashrc implements run-time configuration for the Bourne-Again Shell (Bash). It is
## interpreted whenever Bash is invoked as an ordinary (i.e. non-login) interactive shell.
##
## Details:
## - We assume all of our terminals to support colours.
##
## References:
## - bash(1) man page
##   --> $ man bash
## - Advanced Bash-Scripting Guide
##   --> http://www.tldp.org/LDP/abs/abs-guide.pdf
## - ANSI escape code
##   --> http://en.wikipedia.org/wiki/ANSI_escape_code
##
## Author:
##   Michael H. Pock || MHP || mhp77@gmx.at
##
## © Copyleft 2016 MHP
##
##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##


## ********** Non-Interactive Bash **********

[ -z "${PS1}" ] && return

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Options **********

set -o physical

shopt -s checkwinsize
shopt -s extglob
shopt -s histappend
shopt -s no_empty_cmd_completion

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Variables **********

if [ -r /etc/debian_chroot ]; then
  debian_chroot=$(< /etc/debian_chroot)
fi

PS1="${debian_chroot:+(${debian_chroot})}\[\e[1;31m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\] \\\$ "

case "${TERM}" in
  xterm*|rxvt*)
    PS1="\[\e]0;\u@\h:\w\a\]${PS1}"
    ;;
  *)
esac

unset debian_chroot

## If HISTFILESIZE is not explicitly set it defaults to the value of HISTSIZE.
HISTSIZE=5000

HISTIGNORE=@(ls|ll?(d)|la)*( )

HISTCONTROL=erasedups

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Aliases **********

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Shell Resources **********

if [ "$(id -u)" -ne 0 ]; then
  ulimit -Ss hard
fi

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Programmable Completion **********

[ -r /etc/bash_completion ] && . /etc/bash_completion

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Miscellaneous **********

mesg n

## The Readline library binds the key C-s to the command forward-search-history. We will not be able to access this command,
## however, unless we explicitly disable XON/XOFF flow control ...
stty -ixon

##---------------------------------------------------------------------------------------------------------------------------##


## LocalWords: bashrc HISTFILESIZE HISTSIZE XON XOFF
