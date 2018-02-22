#!/bin/bash
if [ ! -d $HOME/.dotfiles ] && [ ! -h $HOME/.bash_profile ]; then
  mkdir $HOME/.bak && mv $Home/.bash* $HOME/.bak
  mv $HOME/dotfiles $HOME/.dotfiles
  ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
  ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
  ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
  ln -s $HOME/.dotfiles/.vim $HOME/.vim
  ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
fi
