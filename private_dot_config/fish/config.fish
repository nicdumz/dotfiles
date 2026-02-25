# Note: Remember that `set -Ux foo bar` sets variables globally.
set -g -x fish_greeting ''

# Depending on systems, locale can be en_US.UTF8 or en_US.UTF-8
set -x LANG (locale -a | grep -i "en_US.*utf")
set -x LC_ALL (locale -a | grep -i "en_US.*utf")
set -e LC_CTYPE

set -x CLICOLOR true

if test -f ~/brew/bin/brew
    fish_add_path $HOME/brew/bin
    fish_add_path (brew --prefix coreutils)"/libexec/gnubin"
    set -x MANPATH (brew --prefix coreutils)"/libexec/gnuman" $MANPATH
end

fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin

if test -f ~/.local/bin/nvim
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

# set -x TERM xterm-256color
set -x XDG_CONFIG_HOME $HOME/.config

function __fish_complete_users --description 'Print a list of local users, with the real user name as a description'
    awk 'BEGIN { FS = ":"; OFS = "\t" } $0 !~ /^[[:space:]]*#/ { print $1, $5 }' /etc/passwd
end
function ssh --wraps ssh
  # most remote hosts do not know xterm-kitty
  TERM=xterm /usr/bin/ssh $argv
end

# VS Code integration, see https://code.visualstudio.com/docs/terminal/shell-integration#_manual-installation
if string match -q "$TERM_PROGRAM" "vscode"
  . (code --locate-shell-integration-path fish)
end

set fish_color_command green
set fish_color_autosuggestion magenta

chezmoi completion fish | source
starship init fish | source
