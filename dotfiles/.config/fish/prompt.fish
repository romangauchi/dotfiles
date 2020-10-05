#!/usr/bin/fish

function parse_git_branch -d 'Used to show git info in prompt'
  set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ $status -eq 0 ]
	echo -n " "
    if [ $branch = "HEAD" ]
      set branch (git rev-parse --short HEAD 2>/dev/null)
    end
    set git_status (git status --porcelain 2>/dev/null)
    if test -n (echo $git_status)
      set_color -o red
      echo -n "[*$branch]"
    else
      set_color -o green
      echo -n "[$branch]"
    end
    set_color normal
  end
end

function fish_prompt -d 'Set custom prompt'
  # cache variable rather than calculate each time
  if not set -q __fish_prompt_hostname
	set -g __fish_prompt_hostname (hostname | cut -d . -f 1)
  end
  set_color -b cyan
  echo -n " $USER " 
  set_color cyan
  set_color -b green
  echo -n ""
  set_color black
  echo -n " $__fish_prompt_hostname "
  set_color -b normal
  set_color green
  echo -n " "
  set_color yellow
  echo -n (prompt_pwd)
  set_color normal
  parse_git_branch
  echo
  set_color red
  echo -n " "
  set_color normal
end

## Right prompt
function fish_right_prompt
  # parse_git_branch
end
