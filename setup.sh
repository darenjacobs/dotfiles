#!/bin/bash

# install stuff
flavor=$(cat /etc/issue |cut -f1 -d' ')
if [ "${flavor}" == "Debian" ]; then
	sudo apt-get -y update
	sudo apt-get install -y tmux
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
	sudo dpkg -i ripgrep_0.10.0_amd64.deb
  rm ripgrep_0.10.0_amd64.deb
fi

if [ -f /etc/redhat-release ]; then
       sudo yum install -y tmux	
       sudo yum install epel-release
       sudo yum config-manager --set-enabled PowerTool
       sudo yum config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
       sudo yum install ripgrep
fi


if [ ! -d $HOME/.dotfiles ] && [ ! -h $HOME/.bash_profile ]; then
  mkdir $HOME/.bak && mv $HOME/.bash* $HOME/.bak && mv $HOME/.vim* $HOME/.bak
  mv $HOME/dotfiles $HOME/.dotfiles
fi

os_type=$(uname -a |cut -f1 -d' ')

if [ "${os_type}" == "Darwin" ]; then
    ln -s $HOME/.dotfiles/.bash_profile.mac $HOME/.bash_profile
    ln -s $HOME/.dotfiles/.bashrc.mac $HOME/.bashrc
else
    ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
    ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
fi
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.vim $HOME/.vim
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
