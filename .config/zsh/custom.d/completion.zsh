zmodload zsh/complist
autoload -U compinit
compinit

setopt auto_list
#setopt correct

zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' completer _expand _complete

# on completion list menu, display dirs in bold blue, and selection on
# white on blue bg
zstyle ':completion:*' list-colors "di=01;34:ma=44;37"
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

setopt extendedglob

autoload -U bashcompinit
bashcompinit
