# Note: Remember that `set -Ux foo bar` sets variables globally.
set -g -x fish_greeting ''

# Depending on systems, locale can be en_US.UTF8 or en_US.UTF-8
set -x LANG (locale -a | grep -i "en_US.*utf")
set -e LC_CTYPE

set -x LC_ALL "en_US.utf8"
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
function ssh --wraps ssh
  # most remote hosts do not know xterm-kitty
  TERM=xterm /usr/bin/ssh $argv
end

set fish_color_command green
set fish_color_autosuggestion white

# Tide setup
set tide_context_always_display true
set tide_context_bg_color green
set tide_context_default_color black
set tide_context_root_color red
set tide_context_ssh_color black
set tide_left_prompt_items pwd git newline
set tide_pwd_bg_color blue
set tide_status_failure_bg_color red
set tide_status_failure_color yellow
set tide_status_success_color green
set tide_always_display true
set tide_cmd_duration_bg_color C4A000
set tide_cmd_duration_color 000000
set tide_cmd_duration_icon 
set tide_git_bg_color 4E9A06
set tide_git_branch_color 000000
set tide_git_conflicted_color 000000
set tide_git_dirty_color 000000
set tide_git_operation_color 000000
set tide_git_staged_color 000000
set tide_git_stash_color 000000
set tide_git_untracked_color 000000
set tide_git_upstream_color 000000
set tide_jobs_bg_color 444444
set tide_jobs_color 4E9A06
set tide_left_prompt_frame_color 585858
set tide_left_prompt_frame_enabled true
set tide_left_prompt_item_separator_diff_color 
set tide_left_prompt_item_separator_same_color 
set tide_left_prompt_pad_items true
set tide_left_prompt_prefix 
set tide_left_prompt_suffix 
set tide_nvm_bg_color 75507B
set tide_nvm_color 2E3436
set tide_os_bg_color CED7CF
set tide_os_color 080808
set tide_print_newline_before_prompt false
set tide_prompt_connection_color 585858
set tide_pwd_anchors 'first'  'last'  'google3'
set tide_pwd_color_anchors E4E4E4
set tide_pwd_color_dirs E4E4E4
set tide_pwd_color_truncated_dirs BCBCBC
set tide_pwd_dir_icon 
set tide_pwd_home_icon 
set tide_right_prompt_frame_color 585858
set tide_right_prompt_frame_enabled true
set tide_right_prompt_item_separator_diff_color 
set tide_right_prompt_item_separator_same_color 
set tide_right_prompt_items 'status'  'cmd_duration'  'context'  'jobs'  'vi_mode'
set tide_right_prompt_pad_items true
set tide_right_prompt_prefix 
set tide_right_prompt_suffix 
set tide_rust_bg_color FF8700
set tide_rust_color 2E3436
set tide_status_always_display true
set tide_status_success_bg_color 2E3436
set tide_time_bg_color D3D7CF
set tide_time_color 000000
set tide_time_format
set tide_vi_mode_default_bg_color 008000
set tide_vi_mode_default_color 000000
set tide_vi_mode_default_icon DEFAULT
set tide_vi_mode_insert_bg_color 444444
set tide_vi_mode_replace_bg_color 808000
set tide_vi_mode_replace_color 000000
set tide_vi_mode_replace_icon REPLACE
set tide_vi_mode_visual_bg_color 000080
set tide_vi_mode_visual_color 000000
set tide_vi_mode_visual_icon VISUAL
set tide_virtual_env_bg_color 444444
