#!/bin/bash

# ----------------------------------------------------------------------------
# File: dotfiles-manager.sh
# Author: Roman Gauchi
# Date: May, 2020
# Description: dot files management scripts to deploy configuration files.
# ----------------------------------------------------------------------------

## Default options
BASEDIR="$(dirname $0)" # directory of this script
PROG="$(basename $0)"   # name of the script
DESTDIR="${HOME}"       # home destination directory
ENVNAME="dotfiles"      # environment (dir) to deploy
ARCHIVENAME="dotfiles_$(hostname)_$(date +%Y%m%d%H%M%S)" # archive name

# Add some color to your install
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
ENDC="\033[0m"

## Usage function to print some help
function usage
{
  echo "Usage: $PROG <operations> [options]" 1>&2
  echo
  echo "Description:"
  echo "  $PROG deploys and manages the environment files of the"
  echo "  current HOME directory or a given destination directory."
  echo "  Common environment files are targeted by default and can be overriden"
  echo "  by the arguments."
  echo
  echo "Operations:"
  echo "  -S, --sync            synchronize dotfiles to the HOME directory"
  echo "  -A, --archive         save your current dotfiles in an archive"
  echo "  -U, --upload          upload dotfiles from the HOME directory"
  echo
  echo "Options:"
  echo "      --home[=]<dir>    give another home destination directory"
  echo "                        (default: $DESTDIR)"
  echo "      --output[=]<file> give another archive name to save your dotfiles"
  echo "                        (default: $ARCHIVENAME)"
  echo "  -n, --dry-run         display status of new/updated/conflicting files"
  echo "  -f, --force           overwrites files without asking"
  echo "  -h, --help            display this help and exit"
}

## Parsing arguments function (https://stackoverflow.com/a/7680682)
# parameter: argument lists given by the user
function process_opts
{
  local OPTNAME OPTIND OPTERR OPTARG # arguments
  local optspec="SAUnfh-:"
  while getopts ${optspec} OPTNAME; do
	case "$OPTNAME" in
      -)
        case "$OPTARG" in
          sync)
            SYNC=1;;
          archive)
            ARCHIVE=1;;
          upload)
            UPLOAD=1;;
          home)
            DESTDIR="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ));;
          home=*)
            DESTDIR="${OPTARG#*=}";;
          output)
            ARCHIVENAME="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ));;
          output=*)
            ARCHIVENAME="${OPTARG#*=}";;
          dry-run)
            DRYRUN=1;;
          force)
            FORCE=1;;
          help)
            usage
            exit 0;;
          *)
            if [ "$OPTERR" != 1 ] && [ "${optspec:0:1}" != ":" ]; then
              echo "$PROG: unrecognized option '--$OPTARG'" >&2
              exit 1
            fi;;
        esac;;
      S)
        SYNC=1;;
      A)
        ARCHIVE=1;;
      U)
        UPLOAD=1;;
      n)
        DRYRUN=1;;
      f)
        FORCE=1;;
      h)
        usage
        exit 0;;
      *)
        # if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" != ":" ]; then
          # echo "$PROG: invalid option '-$OPTARG'" >&2
        # fi;;
        exit 1
    esac
  done
  if [ $# -ge $OPTIND ]; then
    echo "$PROG: unexpected command line argument: $@}"
    exit 1
  fi
  # specific errors for this script
  if [ -z $SYNC ] && [ -z $UPLOAD ] && [ -z $ARCHIVE ]; then
    echo -e "${RED}error:${ENDC} no operation specified (use -h for help)"
    exit 1
  fi
  if [ ! -z $SYNC ] && [ ! -z $UPLOAD ]; then
    echo -e "${RED}error:${ENDC} you need to choose between sync (-S) or upload (-U) operation"
    exit 1
  fi
  if [ ! -z $FORCE ] && [ ! -z $DRYRUN ]; then
    echo -e "${RED}error:${ENDC} you need to choose between force (-f) or dry-run (-n) option"
    exit 1
  fi
  if [ ! -d $DESTDIR ]; then
    echo -e "${RED}error:${ENDC} home directory '$DESTDIR' does not existing"
    exit 1
  fi
  if [ ! ${DESTDIR?} ]; then
    echo -e "${RED}error:${ENDC} home directory cannot be empty"
    exit 1
  fi
  if [ $DESTDIR == "." ]; then
    echo -e "${RED}error:${ENDC} home directory cannot be this root"
    exit 1
  fi
}

## Upload dotfiles function
function upload_dotfiles
{
  if [[ ! -f $dest ]]; then
    echo -en "${CYAN}            Missing File${ENDC}"
  else
    if diff -q $src $dest 2>&1 > /dev/null; then
      echo -en "${GREEN}              Up-to-date${ENDC}"
    else
      if [[ $(stat -c%Y $dest) -gt $(stat -c%Y $src) ]]; then
        changes="Older"
      else
        changes="Newer"
      fi
      if [[ -z $FORCE ]]; then
        echo -en "${YELLOW}     $changes Changes Exist${ENDC}"
        if [[ -z $DRYRUN ]]; then
          echo " ($dir) $raw"
          echo -en "${BLUE}==> Overwrite, Edit (show diffs) or Ignore? [o/e/i] ${ENDC}"
          read answer
          if [[ $answer == "o" ]] || [[ $answer == "O" ]]; then
            cp -a $dest $src
            echo -en "${RED}             Overwritten${ENDC}"
          elif [[ $answer == "e" ]] || [[ $answer == "E" ]]; then
            vim $src -c "vert diffsplit $dest"
            if diff -q $src $dest 2>&1 > /dev/null; then
                echo -en "${GREEN}                 Updated${ENDC}"
            else
                echo -en "${YELLOW}               Unchanged${ENDC}"
            fi
          else
            echo -en "                 ${YELLOW}Skipped${ENDC}"
          fi
        fi
      else
        cp -a $dest $src
        echo -en "$changes (-f) > ${RED}Overwritten${ENDC}"
      fi
    fi
  fi
  echo " ($dir) $raw"
}

## Synchronize dotfiles function
function sync_dotfiles
{
  if [[ ! -f $dest ]]; then
    if [[ -z $DRYRUN ]]; then
      mkdir -p $(dirname $dest)
      cp -a $src $dest
      echo -en "${CYAN}                 Created${ENDC}"
    else
      echo -en "${CYAN}                New File${ENDC}"
    fi
  else
    if diff -q $src $dest 2>&1 > /dev/null; then
      echo -en "${GREEN}              Up-to-date${ENDC}"
    else
      if [[ $(stat -c%Y $src) -gt $(stat -c%Y $dest) ]]; then
        changes="Older"
      else
        changes="Newer"
      fi
      if [[ -z $FORCE ]]; then
        echo -en "${YELLOW}     $changes Changes Exist${ENDC}"
        if [[ -z $DRYRUN ]]; then
          echo " ($dir) $raw"
          echo -en "${BLUE}==> Owerwrite file? [y/n] ${ENDC}"
          read answer
          if [[ $answer == "y" || $answer == "Y" ]]; then
            cp -a $src $dest
            echo -en "             ${RED}Overwritten${ENDC}"
          else
            echo -en "                 ${YELLOW}Skipped${ENDC}"
          fi
        fi
      else
        cp -a $src $dest
        echo -en "$changes (-f) > ${RED}Overwritten${ENDC}"
      fi
    fi
  fi
  echo " ($dir) $raw"
}

## Archive current dotfiles function
function archive_dotfiles
{
  rm -rf /tmp/${ARCHIVENAME}
  mkdir -p /tmp/${ARCHIVENAME}
  # list all file names existing in the git and the home directory
  for f in $(git ls-files | perl -pe 's|^\w+/||' | sort | uniq); do
    if [ -f ${DESTDIR}/$f ]; then
      echo "Saving ${DESTDIR}/$f"
      mkdir -p /tmp/${ARCHIVENAME}/$(dirname $f)
      cp -a ${DESTDIR}/$f /tmp/${ARCHIVENAME}/$(dirname $f)
    fi
  done
  # compress into a tar.gz
  cd /tmp
  tar -czf ${ARCHIVENAME}.tar.gz ${ARCHIVENAME}
  cd - > /dev/null
  cp /tmp/${ARCHIVENAME}.tar.gz .
}

## Main function
function main
{
  # list all versioned files in the common dir
  for src in $(git ls-files $BASEDIR/$ENVNAME $(echo "$@" | grep "." | perl -pe "s|^|$BASEDIR/|"))
  do
    raw=$(echo $src | perl -pe 's|^\w+/||')
    dir=$(echo $src | perl -pe 's|^(\w+)/.*|$1|')
    dest="$DESTDIR/$raw"

    [[ ! -z $SYNC   ]] && sync_dotfiles
    [[ ! -z $UPLOAD ]] && upload_dotfiles
  done
}

process_opts $@
if [ ! -z $ARCHIVE ]; then
  archive_dotfiles
fi
main

# vim: set shiftwidth=2:
