#!/bin/sh

if [ $PWD == $HOME ]; then
  echo "Run this from your dotfiles repo, not your home directory!"
  exit 0
fi

ln -sF $PWD/.* $HOME
unlink $HOME/.git
unlink $HOME/.gitignore
unlink $HOME/.sshrc.d

cp -R .sshrc.d $HOME/.sshrc.d

if [ ! -d $HOME/.config/nvim ]; then
  ln -s $PWD/.vim $HOME/.config/nvim
  ln -s $PWD/.vimrc $HOME/.config/nvim/init.vim
fi
