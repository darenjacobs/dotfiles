# .bash_profile
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Aliases
alias editor=vim
alias cle="clear"
alias grep="grep --color=auto"
alias add-ssh='eval `ssh-agent -s`; ssh-add'
alias l.='ls -d .* --color=auto'
alias ll='ls -al --color=auto'
alias ls='ls -F --color=auto'
alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

# Display Git branch
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " $(tput setaf 6)(${ref#refs/heads/})$(tput setaf 7)$(tput sgr0) "
}

export PS1="\[$(tput bold)\][\[$(tput setaf 4)\]\d\[$(tput setaf 7)\] \[$(tput setaf 2)\]\t\[$(tput setaf 7)\]][\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 3)\]$PROMPT_HOSTNAME\[$(tput setaf 7)\]] \[$(tput setaf 7)\]\w\[$(tput setaf 7)\]\$(parse_git_branch)\n> \[$(tput sgr0)\]"
export PROMPT_HOSTNAME=$(hostname | cut -f-2 -d.)
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTTIMEFORMAT="[%Y-%m-%d] [%T] "
export HISTFILESIZE=1000000
export PS_FORMAT=user:20,pid,pcpu,pmem,vsz,rss,tname,stat,start_time,bsdtime,args
export PATH=$HOME/.local/bin:${PATH}


shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoredups
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

if [[ $TERM = "screen-256color" ]] && [[ $(ps -p $PPID -o comm=) = "tmux: server" ]]; then
        mkdir $HOME/logs 2> /dev/null
        logname="$(date '+%Y%m%d%H%M%S').tmux.log"
        script -q -f $HOME/logs/${logname}
        exit
fi

tmux -2 new-session -A -s main
alias ls='ls --color=auto'
