#!/bin/zsh -f

#####################################
##  Local bashrc first hook
#####################################

[ -f ${HOME}/.zsh/zshrc.first ] && source ${HOME}/.zsh/.zshrc.first

#####################################
##  Shell customization
#####################################

[ -f ${HOME}/.zsh/shell_customization ] && source ${HOME}/.zsh/shell_customization

# include oh-my-zsh environment
[ -f ${HOME}/.zsh/prompt ] && source ${HOME}/.zsh/prompt

#####################################
##  Aliases
#####################################

[ -f ${HOME}/.zsh/aliases ] && source ${HOME}/.zsh/aliases

#####################################
##  Environment
#####################################

[ -f ${HOME}/.zsh/env ] && source ${HOME}/.zsh/env

#####################################
##  Local zshrc hook
#####################################

[ -f ${HOME}/.zsh/zshrc.perso ] && source ${HOME}/.zsh/zshrc.perso

#####################################
##  Cleaning
#####################################

# uniquify PATH
# uniquify MANPATH
# uniquify INFOPATH
# uniquify LD_LIBRARY_PATH

