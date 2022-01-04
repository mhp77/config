##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##
##
## Abstract:
##   Shell initialization script ~/.bash_aliases provides alias definitions for the Bourne-Again Shell (Bash).
##
## Details:
##   None.
##
## References:
## - bash(1) man page
##   --> $ man bash
## - Advanced Bash-Scripting Guide
##   --> http://www.tldp.org/LDP/abs/abs-guide.pdf
##
## Author:
##   Michael H. Pock || MHP || mhp77@gmx.at
##
## © Copyleft 2016, 2019, 2022 MHP
##
##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##

if [ "$(id -u)" -ne 0 ]; then
  alias sudo='sudo '
fi

alias ls='ls --color=auto'
alias ll='ls -lhF'
alias la='ll -a'
alias lld='ll -d'

alias grep='grep --color=auto'
alias grepl='grep -inH -e'
alias grepr='grep -inHr -e'
alias grepp='ps -f | head -n 1; ps -Af --sort=-start_time | tail -n +5 | grep -i -e'

alias findbl='find -xtype l'

alias stripr='find -type f                                                                                                      \
\( -regex ".+\.[oa]" -exec strip -pg {} \; -o \( -regex ".+\.so\(\..+\)?" -o -executable \) -exec strip -ps {} \; \)'

alias keepop='bash -c "deborphan -Z && deborphan -p required -a --no-show-section | sort | deborphan -A -"'

alias e='emacs -nw'
alias ecomp='emacs -q --batch -f batch-byte-compile'

alias otp='gpg --decrypt ~/.openvpn/totp.gpg 2>/dev/null | xargs oathtool --base32 --totp'

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gs='git status'

##---------------------------------------------------------------------------------------------------------------------------##
