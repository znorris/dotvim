#!/bin/bash
set -ex

# Test if we have python3 install in vim
# this check isn't good enough
# if ! vim --version |grep -w '+python3'; then
#   echo "Go install vim with python3 support first."
#   exit 1
# fi

if [ -d ~/.vim ]; then
  echo "The ~/.vim directory exists. Proceeding will remove this directory."
  read -p "Are you sure? (y / N) " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
    then
      continue
  else
    exit 0
  fi
fi

basedir=~/.vim/dotvim

# Git our sweet repo
git clone git@github.com:znorris/dotvim.git ${basedir}

vimfile=~/.vimrc
gvimfile=~/.gvimrc
# Back up old vim config files
if [ -f $vimfile ]; then
  mv ${vimfile} ~/.vimrc.bak
fi
if [ -f $gvimfile ]; then
  mv ${gvimfile} ~/.gvimrc.bak
fi

# Set new config files
ln -s ${basedir}/vimrc ~/.vimrc
ln -s ${basedir}/gvimrc ~/.gvimrc

# Setup Vundle plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall

# Install YouCompleteMe
~/.vim/bundle/youcompleteme/install.py
