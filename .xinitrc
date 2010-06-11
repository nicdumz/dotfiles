#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

xrdb -merge $userresources

urxvtd -q -f -o

case "$1" in
    gnome) exec gnome-session ;;
    awesome) exec $HOME/local/bin/run_awesome ;;
    *) exec $HOME/local/bin/run_awesome ;; #exec gnome-session ;;
esac
