setopt No_X_Trace;
setopt No_Verbose;

##### HISTORY #####
setopt hist_ignore_all_dups

##### VIM ######
set -o vi
bindkey -v

# edit commandline
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line
bindkey -M vicmd "^E" edit-command-line


#### Aliases, stuff.. ####

xset -b

zmodload zsh/parameter &>/dev/null

# send alarm signal when a command completes
# (useful for long-running tasks in awesome wm when displaying another tag)
precmd () {
    echo -ne '\a'
}

# try to organize this mess
for config_file ($ZDOTDIR/custom.d/*.zsh) source $config_file
unset config_file
