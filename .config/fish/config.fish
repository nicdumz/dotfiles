set -g -x fish_greeting ''

# Depending on systems, locale can be en_US.UTF8 or en_US.UTF-8
set -x LANG (locale -a | grep -i "en_US.*utf")
set -e LC_CTYPE

set -x CLICOLOR true

if test -f ~/brew/bin/brew
    set PATH $HOME/brew/bin $PATH
    set PATH (brew --prefix coreutils)"/libexec/gnubin" $PATH
    set -x MANPATH (brew --prefix coreutils)"/libexec/gnuman" $MANPATH
end

set -x PATH $HOME/.local/bin $PATH

set -x EDITOR nvim
set -x P4DIFF 'colordiff -u'

. ~/.bash_aliases
if test -f ~/.bash_aliases.after
    . ~/.bash_aliases.after
end

eval sh "$HOME/.dotfiles/subrepos/base16-shell/base16-flat.dark.sh"
