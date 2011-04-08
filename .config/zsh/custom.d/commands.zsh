eval "`dircolors -b`"
alias ls='ls -F --color=auto --ignore=\*.pyc --ignore=\*~'

function vim() {
    if (($# == 1)); then
        # replace vim somefile:xx -> vim somefile +xx
        /usr/bin/gvim -v ${(@z)*/:/ +}
    #    a=$*[1]
    #    s=${(s.:.)a}
    #    s[2]="+$s[2]"
    #    /usr/bin/gvim -v $s
    else
        /usr/bin/gvim -v -o $*
    fi
}

alias wget='noglob wget'
alias make='noglob make'
alias entensity='noglob entensity'

function resource() {
    . ${ZDOTDIR}/.zshrc
}

export LESS='R'
