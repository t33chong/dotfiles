#!/bin/sh

ln -sF $PWD/.* $HOME
unlink $HOME/.git
unlink $HOME/.gitignore
