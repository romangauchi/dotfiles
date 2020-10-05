#!/usr/bin/fish

#####################################
##  Shell customization
#####################################

if test -f $__fish_config_dir/colors.fish
    . $__fish_config_dir/colors.fish
end
if test -f $__fish_config_dir/prompt.fish
    . $__fish_config_dir/prompt.fish
end

#####################################
##  Aliases
#####################################

if test -f $__fish_config_dir/aliases.fish
    . $__fish_config_dir/aliases.fish
end
if test -f $__fish_config_dir/abbrs.fish
    . $__fish_config_dir/abbrs.fish
end

#####################################
##  Environment
#####################################

if test -f $__fish_config_dir/env.fish
    . $__fish_config_dir/env.fish
end

