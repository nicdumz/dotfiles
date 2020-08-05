# Note: Remember that `set -Ux foo bar` sets variables globally.
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
set -x PATH $HOME/go/bin $PATH

if test -f ~/.local/bin/fish
    set -x EDITOR ~/.local/bin/nvim
else
    set -x EDITOR nvim
end
set -x P4DIFF 'colordiff -u'
set -x CC clang

. ~/.bash_aliases
if test -f ~/.bash_aliases.after
    . ~/.bash_aliases.after
end

if test -f ~/.config/fish/config-google.fish
    . ~/.config/fish/config-google.fish
end

# if status --is-interactive
#     eval sh "$HOME/.dotfiles/subrepos/base16-shell/scripts/base16-flat.sh"
# end

# set -x TERM xterm-256color
set -x XDG_CONFIG_HOME $HOME/.config

function __fish_complete_users --description 'Print a list of local users, with the real user name as a description'
    awk 'BEGIN { FS = ":"; OFS = "\t" } $0 !~ /^[[:space:]]*#/ { print $1, $5 }' /etc/passwd
end
