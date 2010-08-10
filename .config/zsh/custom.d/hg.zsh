compdef _hg hgs

alias mq='hg -R $(hg root)/.hg/patches'

series() {
    vim .hg/patches/series
}
