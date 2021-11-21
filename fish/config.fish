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

# if status --is-interactive
#     eval sh "$HOME/.dotfiles/subrepos/base16-shell/scripts/base16-flat.sh"
# end

# set -x TERM xterm-256color
set -x XDG_CONFIG_HOME $HOME/.config

function __fish_complete_users --description 'Print a list of local users, with the real user name as a description'
    awk 'BEGIN { FS = ":"; OFS = "\t" } $0 !~ /^[[:space:]]*#/ { print $1, $5 }' /etc/passwd
end
function ssh --wraps ssh
  # most remote hosts do not know xterm-kitty
  TERM=xterm /usr/bin/ssh $argv
end

set fish_color_command green
set fish_color_autosuggestion magenta

# Tide setup
set -g tide_context_always_display true
set -g tide_context_bg_color green
set -g tide_context_color_default black
set -g tide_context_color_root red
set -g tide_context_color_ssh black
set -g tide_left_prompt_items pwd git newline character
set -g tide_pwd_bg_color blue
set -g tide_status_failure_bg_color red
set -g tide_status_color_failure yellow
set -g tide_status_color_success green
set -g tide_always_display true
set -g tide_cmd_duration_bg_color C4A000
set -g tide_cmd_color_duration 000000
set -g tide_cmd_duration_icon 
set -g tide_git_bg_color 4E9A06
# set -g tide_git_color_branch white
# set -g tide_git_color_conflicted white
# set -g tide_git_color_dirty white
# set -g tide_git_color_operation white
# set -g tide_git_color_staged white
# set -g tide_git_color_stash white
# set -g tide_git_color_untracked white
# set -g tide_git_color_upstream white
set -g tide_jobs_bg_color 444444
set -g tide_jobs_color 4E9A06
set -g tide_jobs_verbose true
set -g tide_left_prompt_frame_color 585858
set -g tide_left_prompt_frame_enabled false
set -g tide_left_prompt_separator_diff_color 
set -g tide_left_prompt_separator_same_color 
set -g tide_left_prompt_prefix 
set -g tide_left_prompt_suffix " "
set -g tide_nvm_bg_color 75507B
set -g tide_nvm_color 2E3436
set -g tide_os_bg_color CED7CF
set -g tide_os_color 080808
set -g tide_print_newline_before_prompt false
set -g tide_prompt_color_frame_and_connection 585858
set -g tide_prompt_pad_items true
set -g tide_pwd_markers 'first'  'last'  'google3'
set -g tide_pwd_color_anchors E4E4E4
set -g tide_pwd_color_dirs E4E4E4
set -g tide_pwd_color_truncated_dirs BCBCBC
set -g tide_pwd_dir_icon 
set -g tide_pwd_icon_home 
set -g tide_right_prompt_frame_color 585858
set -g tide_right_prompt_frame_enabled false
set -g tide_right_prompt_separator_diff_color 
set -g tide_right_prompt_separator_same_color 
set -g tide_right_prompt_items 'status'  'cmd_duration'  'context'  'jobs'  'vi_mode'
set -g tide_right_prompt_prefix 
set -g tide_right_prompt_suffix 
set -g tide_rustc_bg_color FF8700
set -g tide_rustc_color 2E3436
set -g tide_status_always_display true
set -g tide_status_bg_color 2E3436
set -g tide_time_bg_color D3D7CF
set -g tide_time_color 000000
set -g tide_time_format
set -g tide_vi_mode_bg_color_default 008000
set -g tide_vi_mode_color_default 000000
set -g tide_vi_mode_icon_default DEFAULT
# set -g tide_vi_mode_insert_bg_color 444444
set -g tide_vi_mode_bg_color_replace 808000
set -g tide_vi_mode_color_replace 000000
set -g tide_vi_mode_icon_replace REPLACE
set -g tide_vi_mode_bg_color_visual 000080
set -g tide_vi_mode_color_visual 000000
set -g tide_vi_mode_icon_visual VISUAL
set -g tide_virtual_env_bg_color 444444
set -g tide_character_failure_color red
set -g tide_character_success_color green
set -g tide_character_icon 
