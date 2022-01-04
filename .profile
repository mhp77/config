##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##
##
## Abstract:
##   Shell initialization script ~/.profile implements run-time configuration for the Bourne Shell (Sh) and some of its
## descendants (such as Bash). It is interpreted whenever Sh (or one of its descendants) is invoked as a login shell.
## Furthermore, it is read and executed by /etc/gdm3/Xsession.
##
## Details:
## - We assume all of our terminals to support colours.
##
## References:
## - bash(1) man page
##   --> $ man bash
## - dash(1) man page
##   --> $ man dash
## - Advanced Bash-Scripting Guide
##   --> http://www.tldp.org/LDP/abs/abs-guide.pdf
##
## Author:
##   Michael H. Pock || MHP || mhp77@gmx.at
##
## © Copyleft 2016, 2019 MHP
##
##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##


## ********** Environment Variables **********

## The dircolors program decides, based on the value of the TERM environment variable, whether or not the underlying terminal
## supports colours. We do not assume, however, that any of our terminals really lacks colour support. As a consequence, we
## deem it reasonable to invoke dircolors merely at login time and mess around with it by faking some terminal known to support
## colours. This approach is, admittedly, rather dirty, but still necessary since the TERM environment variable is not set
## during login to a graphical shell. Moreover, it ensures that dircolors works correctly in an Emacs shell buffer, which –
## albeit appearing as a ‘dumb’ terminal – definitely supports colours if the underlying terminal does so.
if [ -x /usr/bin/dircolors ]; then
  eval "$(TERM=xterm /usr/bin/dircolors --sh)"
fi

if [ -x /usr/bin/emacs ]; then
  EDITOR='/usr/bin/emacs --no-window-system'
  export EDITOR
fi

if [ "$(id -u)" -ne 0 ]; then

  extra_progs_dir=/opt

  if [ -z "${BASE_PATH}" ]; then
    BASE_PATH=${PATH}
    export BASE_PATH
  fi

  PATH=${BASE_PATH}
  [ -d "${extra_progs_dir}"/pdfsizeopt ] && PATH=${PATH}:${extra_progs_dir}/pdfsizeopt

  if [ -x /usr/bin/tlmgr ]; then
    TEXMFHOME=~/share/texmf
    TEXINPUTS=.:./{data,figs,tex}//:../common//:
    BIBINPUTS=.:../common//:
    export TEXMFHOME TEXINPUTS BIBINPUTS
  fi

  if [ -x /usr/bin/java ]; then
    CLASSPATH=.:/usr/local/share/java/*
    export CLASSPATH
  fi

  if [ -x /usr/bin/bup ]; then
    BUP_DIR=/media/backup_disk/backup_${USER}
    export BUP_DIR
  fi

  if [ -x /usr/bin/assword ]; then
    ASSWORD_PASSWORD=prompt
    ASSWORD_XPASTE=xclip
    export ASSWORD_PASSWORD ASSWORD_XPASTE
  fi

  unset extra_progs_dir

fi

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Bash **********

if [ -n "${BASH}" -a -n "${PS1}" ]; then
  [ -f ~/.bashrc ] && . ~/.bashrc
fi

##---------------------------------------------------------------------------------------------------------------------------##


## LocalWords: dircolors
