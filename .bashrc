# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#                . /etc/bashrc
#fi

# User specific aliases and functions
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " $(tput setaf 6)(${ref#refs/heads/})$(tput setaf 7)$(tput sgr0) "
}

export CDPATH=.:~/stash/
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias tempenv='source ~/ve/bin/activate'
alias vi='vim'
alias l.='ls -d .* --color=auto'
alias ll='ls -al --color=auto'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
alias add-ssh='eval `ssh-agent -s`; ssh-add'
