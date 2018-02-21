# .bash_profile


# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
# Djacobs
[[ $- != *i* ]] && return
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " $(tput setaf 6)(${ref#refs/heads/})$(tput setaf 7)$(tput sgr0) "
}
#export HISTTIMEFORMAT="%F %T "
export HISTTIMEFORMAT="[%Y-%m-%d] [%T] "
export HISTFILESIZE=1000000
export PROMPT_HOSTNAME=$(hostname | cut -f-2 -d.)
export PS1="\[$(tput bold)\][\[$(tput setaf 2)\]\t\[$(tput setaf 7)\]][\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 3)\]$PROMPT_HOSTNAME\[$(tput setaf 7)\]] \[$(tput setaf 7)\]\w\[$(tput setaf 7)\]\$(parse_git_branch)> \[$(tput sgr0)\]"
export PATH=${PATH}:$HOME/local/bin:$HOME/ve/bin
export CDPATH=.:~/stash/
export PS_FORMAT=user:20,pid,pcpu,pmem,vsz,rss,tname,stat,start_time,bsdtime,args
export PATH

# Aliases
alias python=python2.7
alias grep="grep --color=auto"
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias tempenv='source ~/ve/bin/activate'
alias vi='vim'
alias l.='ls -d .* --color=auto'
alias ll='ls -al --color=auto'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
alias add-ssh='eval `ssh-agent -s`; ssh-add'


# Custom login stuff

# Tmux: Only run on my Linux jump box
this_host="ip-172-31-26-56"
this_node=$(hostname)
if [[ $this_node == $this_host ]]; then
        tmux new-session -A -s main
fi


HISTTIMEFORMAT="[%Y-%m-%d] [%T] "
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

PROMPT_COMMAND="history -a"
typeset -r PROMPT_COMMAND
clear
echo -ne ${RED}"Hello $USER, you are now logged in on $HOSTNAME ";echo "";
if [ -f /etc/redhat-release ]; then
  echo -e ${CYAN}'This baby is powered by:' $(cat /etc/redhat-release) ;
elif [ -f /etc/issue ];then
  echo -e ${CYAN}'This baby is powered by:' $(head -n 1 /etc/issue) ;
fi
echo -e "${WHITE}"; cal ;
echo -ne "${CYAN}Uptime for this server is ";uptime | awk /'up/ {print $3,$4}'

echo -ne '\033]2;'$USER@$HOSTNAME' '$(uptime)'\007'

if [[ $TERM = "screen" ]] && [[ $(ps -p $PPID -o comm=) = "tmux" ]]; then
        mkdir $HOME/logs 2> /dev/null
        logname="$(date '+%Y%m%d%H%M%S').tmux.log"
        script -q -f $HOME/logs/${logname}
        exit
fi
