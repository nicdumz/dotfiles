eval "`dircolors -b`"
alias ls='ls -F --color=auto --ignore=\*.pyc --ignore=\*~'

function vim() {
    # replace vim somefile:xx -> vim somefile +xx
    /usr/bin/gvim -v ${(@z)*/:/ +}
}

alias wget='noglob wget'
alias make='noglob make'
alias entensity='noglob entensity'
