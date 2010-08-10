#!/bin/zsh
ZDOTDIR=~/.config/zsh

export HISTSIZE=2000

export HISTFILE=${HOME}/.history
export SAVEHIST=$HISTSIZE

export PYTHONPATH="$HOME/local/lib/python:$PYTHONPATH"

export EDITOR=vim

export PATH="/usr/lib/ccache/bin:$HOME/local/bin:/usr/local/bin:$PATH"
export GREP_OPTIONS="--exclude-dir=\.svn"

export BROWSER="/usr/bin/firefox"

export ERP5_BT5_CACHE=1
# ugggggh
unset PYTHONDONTWRITEBYTECODE
