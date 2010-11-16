compdef _hg hgs

alias mq='hg -R $(hg root)/.hg/patches'

series() {
    vim $(hg root)/.hg/patches/series
}
hgenv() {
    if (( $# != 2 )) then
        echo Usage: hgenv mercurialrepopath envname
        return -1
    fi
    repopath=$1
    envname=$2
    v=$(python -c 'import sys; print ".".join(map(str, sys.version_info[:2]))')
    mkvirtualenv $envname
    ln -s $repopath/mercurial $WORKON_HOME/$envname/lib/python$v/site-packages/
    ln -s $repopath/hgext $WORKON_HOME/$envname/lib/python$v/site-packages/
    ln -s $repopath/hg $WORKON_HOME/$envname/bin/
    hg --version
}
