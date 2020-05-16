#!/bin/tcsh

#####################################
##  Local cshrc first hook
#####################################

if ( -f "${HOME}/.csh/cshrc.first" ) source ${HOME}/.csh/cshrc.first

#####################################
##  Aliases
#####################################

if ( -f "${HOME}/.csh/aliases" ) source ${HOME}/.csh/aliases

#####################################
##  Environment
#####################################

if ( -f "${HOME}/.csh/env" ) source ${HOME}/.csh/env

#####################################
##  Local cshrc hook
#####################################

# Personnal aliases & path append
if ( -f "${HOME}/.csh/cshrc.perso" ) source ${HOME}/.csh/cshrc.perso

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

if ( ${?tcsh} == 0 || ${?USER} == 0 || ${?prompt} == 0) exit

#####################################
##  Shell customization
#####################################

if ( -f "${HOME}/.csh/shell_customization" ) source ${HOME}/.csh/shell_customization

