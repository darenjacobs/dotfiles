#!/bin/bash
if [ ! -d $HOME/.dotfiles ] && [ ! -h $HOME/.bash_profile ]; then
  mkdir $HOME/.bak && mv $HOME/.bash* $HOME/.bak && mv $HOME/.vim* $HOME/.bak
  mv $HOME/dotfiles $HOME/.dotfiles
fi

flavor=$(uname -a |cut -f1 -d' ')

if [ "${flavor}" == "Darwin" ]; then 
    ln -s $HOME/.dotfiles/.bash_profile.mac $HOME/.bash_profile
    ln -s $HOME/.dotfiles/.bashrc.mac $HOME/.bashrc
else
    ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
    ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
fi
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.vim $HOME/.vim
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
