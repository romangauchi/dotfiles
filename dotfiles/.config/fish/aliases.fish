#!/usr/bin/fish

# Colors
alias    ls  'ls	--color=auto --time-style=long-iso --group-directories-first'
alias  grep  'grep  --color=auto'
alias fgrep  'fgrep --color=auto'
alias egrep  'egrep --color=auto'
alias zgrep  'zgrep --color=auto'

# Builtins
alias rm     'rm -i'    # i: prompt before every removal
alias cp     'cp -ip'   # i: prompt before overwrite, p: preserve timestamps (date)
alias mv     'mv -i'    # i: prompt before overwrite
alias mkdir  'mkdir -p' # p: make parent directories as needed

alias ..     'cd ..'
alias ...    'cd ../..'
alias ....   'cd ../../..'
alias .....  'cd ../../../..'
alias ...... 'cd ../../../../..'
alias cd.    'cd ..'
alias cd..   'cd ..'
alias f	     'finger -s'
alias h      'history'
alias j      'ps'
alias l      'ls'
alias ll     'ls -lh'
alias la     'ls -lha'
alias lt     'ls -lhtr'
alias llog   'journalctl -xn'
alias tt     'tree -ACF'
alias ttd    'tt -d'
alias tta    'tt -a'
alias path   'echo $PATH'

alias duh    'du -h --max-depth=1 --exclude="*/.snapshot/*" | sort -h'
alias duhd   'du -shc ./* | sort -h'
alias duha   'du -sh .[^.]* | sort -h'

# Git (alias from .gitconfig)
alias gl     'git lg'
alias gr     'git repo && cd `git root` || git root'

# Tmux
alias tl     'tmux list-session'
alias ta     'tmux attach -t'
alias tn     'tmux new-session'
alias tw     'tmux new-window'
alias ts     'tmux split-window'
alias tvim   'tmux split-window vim'

# Custom
alias po     'poweroff'
alias a      'cat ~/.config/fish/aliases.fish'
alias aa     'vim ~/.config/fish/perso.fish'
alias aaa    'source ~/.config/fish/config.fish'
alias vv     'vim ~/.vimrc'
alias ae     'source bin/activate.csh'
alias de     'deactivate'

# Others stuffs
alias whatip  'curl -s http://whatismyip.akamai.com; echo'
alias weather 'curl fr.wttr.in/grenoble'

