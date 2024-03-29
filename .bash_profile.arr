# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# Get bash-completion
eval "$(/opt/homebrew/bin/brew shellenv)"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# User specific aliases and functions
alias editor=vim
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias k="kubectl"
alias tf="terraform"
alias ls="ls -GF"
alias ll="ls -al"
alias lll="ls -al |less"
alias cle="clear"
alias grep="grep --color=auto"
alias add-ssh='eval `ssh-agent -s`; ssh-add'
alias onprem="ssh djacobs@208.95.61.140"
[[ $- != *i* ]] && return
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " $(tput setaf 6)(${ref#refs/heads/})$(tput setaf 7)$(tput sgr0) "
}
export HISTTIMEFORMAT="%F %T "
export HISTFILESIZE=1000000
export PROMPT_HOSTNAME=$(hostname | cut -f-2 -d.)
export PS1="\[$(tput bold)\][\[$(tput setaf 4)\]\d\[$(tput setaf 7)\] \[$(tput setaf 2)\]\t\[$(tput setaf 7)\]][\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 3)\]$PROMPT_HOSTNAME\[$(tput setaf 7)\]] \[$(tput setaf 7)\]\w\[$(tput setaf 7)\]\$(parse_git_branch)\n➤ \[$(tput sgr0)\]"
export PATH=${PATH}:~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin/git
export PS_FORMAT=user:20,pid,pcpu,pmem,vsz,rss,tname,stat,start_time,bsdtime,args
export EDITOR=/usr/local/bin/vim
export BASH_SILENCE_DEPRECATION_WARNING=1
neofetch
