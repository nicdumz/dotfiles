setopt No_X_Trace;
setopt No_Verbose;

##### Completion #####
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

compdef _hg hgs

alias wget='noglob wget'
alias make='noglob make'
alias entensity='noglob entensity'

######### PROMPT ##########
VIMODE=''

setprompt() {
    setopt prompt_subst;

    declare -x PS1
    declare -x PS2;

    setopt Prompt_Percent
    #setopt No_Prompt_CR

    autoload -U colors
    colors
    autoload -U promptinit
    promptinit

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    NPR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    for COLOR in CYAN RED GREEN YELLOW BLUE WHITE BLACK; do
        eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
        eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    done

    # commandline style
    zle_highlight[(r)default:*]="default:fg=white,bold"

    setopt PROMPT_SUBST
    doprompt
}
doprompt() {
    #mostly inspired by http://pthree.org/2009/03/28/add-vim-editing-mode-to-your-zsh-prompt/
    # %f resests the front color
    PROMPT='${PR_BOLD_RED}<${PR_RED}<${PR_BOLD_BLACK}<%f \
%{$PR_BOLD_BLUE%}%n%f\
@%m: %{$PR_BOLD_RED%}${${(%):-%~}//\//${PR_BOLD_RED}/%f}%f \

${PR_BOLD_BLACK}>${PR_GREEN}>${PR_BOLD_GREEN}>%f ';

    PROMPT2='\
${PR_BOLD_BLACK}>${PR_GREEN}>${PR_BOLD_GREEN}>\
${PR_BOLD_WHITE} %_ ${PR_BOLD_BLACK}>${PR_GREEN}>\
${PR_BOLD_GREEN}>%f ';

    RPROMPT='%U${PR_BOLD_CYAN}${VIMODE}%u%f'
}
setprompt

chpwd() {
  [[ -t 1 ]] || return;
  print -Pn "\e]0;%n@%m: %~\a";
}

print -Pn "\e]0;%n@%m: %~\a";
#
##### HISTORY #####
export HISTSIZE=2000

export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

##### VIM ######
set -o vi
bindkey -v

function vim() {
    # replace vim somefile:xx -> vim somefile +xx
    /bin/vim ${(@z)*/:/ +}
}

function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/command}/(main|viins)/}"
    doprompt
    zle reset-prompt
}
zle -N zle-keymap-select

function accept_line {
    VIMODE=''
    builtin zle .accept-line
}
zle -N accept_line
bindkey -M vicmd "^M" accept_line

# edit commandline
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line
bindkey -M vicmd "^E" edit-command-line



#### Aliases, stuff.. ####

xset -b
eval "`dircolors -b`"
alias ls='ls -F --color=auto --ignore=\*.pyc --ignore=\*~'

zmodload zsh/parameter &>/dev/null

export PYTHONPATH="$HOME/local/lib/python:$PYTHONPATH"

export EDITOR=vim

alias mq='hg -R $(hg root)/.hg/patches'
export PATH="/usr/lib/ccache/bin:$HOME/local/bin:/usr/local/bin:$PATH"
export GREP_OPTIONS="--exclude-dir=\.svn"

export ERP5_BT5_CACHE=1
export BROWSER="/usr/bin/firefox"
. $HOME/local/lib/z.sh
