# .bash_profile

# Check if the shell is interactive
case $- in
    *i*) ;;
      *) return;;
esac

# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Function to force color output in `ls` and maintain default layout
ls() {
    if [ -t 1 ]; then
        # If stdout is a terminal, use the default ls behavior
        command ls -F --color=auto "$@"
    else
        # If stdout is not a terminal, force the column layout and color
        command ls -F --color=always -C "$@"
    fi
}

less() {

    if [ -t 1 ]; then
        # stdout is a terminal
        command less "$@"
    else
        # stdout is not a terminal, run less without logging
        { command less "$@"; } <$(tty) >$(tty) 2>&1
    fi
}


more() {

    if [ -t 1 ]; then
        # stdout is a terminal
        command more "$@"
    else
        # stdout is not a terminal, run more without logging
        { command more "$@"; } <$(tty) >$(tty) 2>&1
    fi
}

# Wrapper function for vim to avoid warnings when output is not a terminal
vim() {
    if [ -t 1 ]; then
        # stdout is a terminal
        command vim "$@"
    else
        # stdout is not a terminal, run vim without logging
        { command vim "$@"; } <$(tty) >$(tty) 2>&1
    fi
}

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

# Prompt customization
export PS1="\[$(tput bold)\][\[$(tput setaf 4)\]\d\[$(tput setaf 7)\] \[$(tput setaf 2)\]\t\[$(tput setaf 7)\]][\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 3)\]$PROMPT_HOSTNAME\[$(tput setaf 7)\]] \[$(tput setaf 7)\]\w\[$(tput setaf 7)\]\$(parse_git_branch)\n> \[$(tput sgr0)\]"
export PROMPT_HOSTNAME=$(hostname | cut -f-2 -d.)
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTTIMEFORMAT="[%Y-%m-%d] [%T] "
export HISTFILESIZE=1000000
export PS_FORMAT=user:20,pid,pcpu,pmem,vsz,rss,tname,stat,start_time,bsdtime,args
export PATH=$HOME/.local/bin:${PATH}

# History options
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoredups
PROMPT_COMMAND="history -a"
typeset -r PROMPT_COMMAND

# Welcome message
clear
echo -ne ${RED}"Hello $USER, you are now logged in on $HOSTNAME "; echo ""
if [ -f /etc/redhat-release ]; then
    whats_this=$(cat /etc/redhat-release)
elif [ -f /etc/issue ]; then
    whats_this=$(head -n 1 /etc/issue | awk '{gsub(/\\n|\\l/, ""); print}')
fi
echo -e ${CYAN}"This baby is powered by: ${whats_this}"
echo -e "${WHITE}"; cal
echo -ne "${CYAN}Uptime for this server is "; uptime | awk /'up/ {print $3,$4}'
echo -ne '\033]2;'$USER@$HOSTNAME' '$(uptime)'\007'

# Check if running in tmux and log session if so
if [[ $TERM = "screen-256color" ]] && [[ $(ps -p $PPID -o comm=) = "tmux: server" ]]; then
    mkdir -p $HOME/logs
    logname="$(date '+%Y%m%d%H%M%S').tmux.log"
    exec > >(tee -a "$HOME/logs/${logname}") 2>&1
fi

# Ensure terminal type is correct
export TERM=xterm-256color

# Start tmux session
tmux -2 new-session -A -s main

# Aliases (redefined here to ensure they are set if the above commands change the environment)
alias ls='ls --color'
