# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin

export PATH
unset USERNAME

# color for ls and friends
export CLICOLOR=true

source ".dotfiles/subrepos/base16-shell/base16-flat.dark.sh"
alias ls='ls --color=auto'

export LANG=en_US.UTF-8
unset LC_CTYPE
