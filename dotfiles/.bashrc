#!/bin/bash

#####################################
##  Local bashrc first hook
#####################################

[ -f ${HOME}/.bash/bashrc.first ] && source ${HOME}/.bash/bashrc.first

#####################################
##  Aliases
#####################################

[ -f ${HOME}/.bash/aliases ] && source ${HOME}/.bash/aliases

#####################################
##  Environment
#####################################

[ -f ${HOME}/.bash/env ] && source ${HOME}/.bash/env

#####################################
##  Local bashrc hook
#####################################

[ -f ${HOME}/.bash/bashrc.perso ] && source ${HOME}/.bash/bashrc.perso

#####################################
##  Cleaning
#####################################

uniquify PATH
uniquify MANPATH
uniquify INFOPATH
uniquify LD_LIBRARY_PATH

#####################################
### stop in non interactive shell
#####################################

case $- in *i*) ;; *) return ;; esac

#####################################
##  Shell customization
#####################################

[ -f ${HOME}/.bash/shell_customization ] && source ${HOME}/.bash/shell_customization

