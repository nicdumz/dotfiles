set -g -x fish_greeting ''

# Depending on systems, locale can be en_US.UTF8 or en_US.UTF-8
set -x LANG (locale -a | grep -i "en_US.*utf")
set -e LC_CTYPE

set -x CLICOLOR true

if type -p brew > /dev/null
    set PATH (brew --prefix coreutils)"/libexec/gnubin" $PATH
    set -x MANPATH (brew --prefix coreutils)"/libexec/gnuman" $MANPATH
end

set -x PATH $HOME/.local/bin $PATH

set -x EDITOR vim
set -x P4DIFF 'colordiff -u'

. ~/.bash_aliases
if [ -f ~/.bash_aliases.after ] then
    . ~/.bash_aliases.after
end

eval sh "$HOME/.dotfiles/subrepos/base16-shell/base16-flat.dark.sh"

alias vim=nvim
