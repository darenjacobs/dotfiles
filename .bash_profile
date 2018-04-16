# .bash_profile


# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export HISTTIMEFORMAT="[%Y-%m-%d] [%T] "
export HISTFILESIZE=1000000
export PROMPT_HOSTNAME=$(hostname | cut -f-2 -d.)
export PS1="\[$(tput bold)\][\[$(tput setaf 2)\]\t\[$(tput setaf 7)\]][\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 3)\]$PROMPT_HOSTNAME\[$(tput setaf 7)\]] \[$(tput setaf 7)\]\w\[$(tput setaf 7)\]\$(parse_git_branch)> \[$(tput sgr0)\]"
export PATH=${PATH}:$HOME/local/bin:$HOME/ve/bin
export CDPATH=.:~/stash/
export PS_FORMAT=user:20,pid,pcpu,pmem,vsz,rss,tname,stat,start_time,bsdtime,args
export PATH

# Custom login stuff

# Tmux: Only run on my jump box
this_host="ansible"
this_node=$(hostname)
if [[ $this_node == $this_host ]]; then
        tmux -2 new-session -A -s main
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
  whats_this=$(cat /etc/redhat-release)
elif [ -f /etc/issue ];then
  whats_this=$(head -n 1 /etc/issue)
fi
echo -e ${CYAN}"This baby is powered by: ${whats_this}" ;
echo -e "${WHITE}"; cal ;
echo -ne "${CYAN}Uptime for this server is ";uptime | awk /'up/ {print $3,$4}'

echo -ne '\033]2;'$USER@$HOSTNAME' '$(uptime)'\007'

if [[ $TERM = "screen" ]] && [[ $(ps -p $PPID -o comm=) = "tmux" ]]; then
        mkdir $HOME/logs 2> /dev/null
        logname="$(date '+%Y%m%d%H%M%S').tmux.log"
        script -q -f $HOME/logs/${logname}
        exit
fi
