#!/bin/sh

if [ $PWD == $HOME ]; then
  echo "Run this from your dotfiles repo, not your home directory!"
  exit 0
fi

ln -sF $PWD/.* $HOME
unlink $HOME/.git
unlink $HOME/.gitignore
