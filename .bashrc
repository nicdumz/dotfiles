# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:cd ~:cd ..:[bf]g:exit"

# append to the history file, don't overwrite it
shopt -s histappend

# exclamation marks are evil
set +o histexpand

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PS1="\h:\w \[\033[31m\]\$\[\033[0m\] "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=$PATH:$HOME/.local/bin
unset USERNAME

# if homebrew is there.
if [[ $(type -P brew) ]]; then
    export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
    export MANPATH=$(brew --prefix coreutils)/libexec/gnuman:$MANPATH
fi

# color for ls and friends
export CLICOLOR=true

# Depending on systems, locale can be en_US.UTF8 or en_US.UTF-8
export LANG=$(locale -a | grep -i "en_US.*utf")
unset LC_CTYPE

source "$HOME/.dotfiles/subrepos/base16-shell/base16-flat.dark.sh"

if [ -f ~/.bashrc.after ]; then
    . ~/.bashrc.after
fi
