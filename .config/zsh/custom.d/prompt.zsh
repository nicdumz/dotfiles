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
