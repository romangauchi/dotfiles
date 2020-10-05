#!/usr/bin/fish

# documentation: https://fishshell.com/docs/current/index.html#variables-color

# Regular synthax highlighting colors
set fish_color_normal normal
set fish_color_command normal
set fish_color_quote green
set fish_color_redirection blue
set fish_color_end magenta
set fish_color_error normal
set fish_color_param blue
set fish_color_comment black
set fish_color_match blue
set fish_color_selection blue
set fish_color_operator normal
set fish_color_escape cyan
set fish_color_autosuggestion 878787
set fish_color_user red
set fish_color_host normal
set fish_color_host_remote yellow
set fish_color_cancel red
set fish_color_status red
set fish_color_valid_path normal
set fish_color_history_current cyan

set fish_color_cwd blue
set fish_color_cwd_root red

# Background color for search match (selected pager item)
set fish_color_search_match --background=yellow

# Pager colors
set fish_pager_color_progress blue
set fish_pager_color_background normal
set fish_pager_color_prefix blue --bold
set fish_pager_color_completion 878787
set fish_pager_color_description 878787

# set fish_pager_color_selected_background yellow
set fish_pager_color_selected_prefix black -o
set fish_pager_color_selected_completion black -o
set fish_pager_color_selected_description black -o

set fish_key_bindings fish_default_key_bindings
