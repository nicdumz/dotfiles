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

function ls
    command ls --color=auto $argv
end

function grep
    command grep --color=auto $argv
end

eval sh "$HOME/.dotfiles/subrepos/base16-shell/base16-flat.dark.sh"

if [ -f ~/.bashrc.after ]
    . ~/.bashrc.after
end
