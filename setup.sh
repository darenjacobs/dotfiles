#!/bin/bash

# install stuff
flavor=$(cat /etc/issue |cut -f1 -d' ')
if [ "${flavor}" == "Debian" ]; then
	sudo apt-get -y update
	sudo apt-get install -y tmux
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
  sudo dpkg -i ripgrep_13.0.0_amd64.deb
  rm  ripgrep_13.0.0_amd64.deb
fi

if [ -f /etc/redhat-release ]; then
       sudo yum install tmux -y
       sudo yum install vim -y
       sudo yum install epel-release -y
       sudo yum config-manager --set-enabled PowerTool -y
       sudo yum config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
       sudo yum install ripgrep -y
fi


if [ ! -d $HOME/.dotfiles ] && [ ! -h $HOME/.bash_profile ]; then
  mkdir $HOME/.bak && mv $HOME/.bash* $HOME/.bak
  mv $HOME/dotfiles $HOME/.dotfiles
fi
if [ -f $HOME/.vimrc ]; then
  mv $HOME/.vim* $HOME/.bak
fi

os_type=$(uname -a |cut -f1 -d' ')

if [ "${os_type}" == "Darwin" ]; then
    ln -s $HOME/.dotfiles/.bash_profile.mac $HOME/.bash_profile
else
    ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
fi
ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.vim $HOME/.vim
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
