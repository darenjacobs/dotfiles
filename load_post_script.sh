# Aliases
alias l.='ls -d .* --color=auto'
alias ll='ls -al --color=auto'
alias ls='ls -F --color=auto'
alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

# Display Git branch
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " $(tput setaf 6)(${ref#refs/heads/})$(tput setaf 7)$(tput sgr0) "
}

export PROMPT_HOSTNAME=$(hostname | cut -f-2 -d.)
export PS1="\[$(tput bold)\][\[$(tput setaf 4)\]\d\[$(tput setaf 7)\] \[$(tput setaf 2)\]\t\[$(tput setaf 7)\]][\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 3)\]$PROMPT_HOSTNAME\[$(tput setaf 7)\]] \[$(tput setaf 7)\]\w\[$(tput setaf 7)\]\$(parse_git_branch)\n> \[$(tput sgr0)\]"
