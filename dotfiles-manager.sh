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

FONTNAME="DejaVuSansMono"
FONTVERSION="v2.1.0" # Feb. 02, 2020

# Add some color to your install
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
ENDC="\033[0m"

if [[ "$OSTYPE" == darwin* ]]; then
  CMD_STAT="stat -f%m"
else
  CMD_STAT="stat -c%Y"
fi

## Usage function to print some help
function usage
{
  cat << EOF
Usage: $PROG <operations> [options]

Description:
  $PROG deploys and manages the environment files of the
  current HOME directory or a given destination directory.
  Common environment files are targeted by default and can be overriden
  by the arguments.

Operations:
  -S, --sync            synchronize dotfiles to the HOME directory
  -I, --install         install extra dependencies (fonts)
  -A, --archive         save your current dotfiles in an archive
  -U, --upload          upload dotfiles from the HOME directory

Options:
      --home[=]<dir>    give another home destination directory
                        (default: $DESTDIR)
      --output[=]<file> give another archive name to save your dotfiles
                        (default: $ARCHIVENAME)
  -n, --dry-run         display status of new/updated/conflicting files
  -f, --force           overwrites files without asking
  -h, --help            display this help and exit
EOF
}

## Parsing arguments function (https://stackoverflow.com/a/7680682)
# parameter: argument lists given by the user
function process_opts
{
  local OPTNAME OPTIND OPTERR OPTARG # arguments
  local optspec="SIAUnfh-:"
  while getopts ${optspec} OPTNAME; do
	case "$OPTNAME" in
      S) SYNC=1;;
      I) INSTALL=1;;
      A) ARCHIVE=1;;
      U) UPLOAD=1;;
      n) DRYRUN=1;;
      f) FORCE=1;;
      h) usage; exit 0;;
      -)
        case "$OPTARG" in
          sync) SYNC=1;;
          install) INSTALL=1;;
          archive) ARCHIVE=1;;
          upload) UPLOAD=1;;
          home) DESTDIR="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ));;
          home=*) DESTDIR="${OPTARG#*=}";;
          output) ARCHIVENAME="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ));;
          output=*) ARCHIVENAME="${OPTARG#*=}";;
          dry-run) DRYRUN=1;;
          force) FORCE=1;;
          help) usage; exit 0;;
          *)
            echo "$PROG: unknown option '--$OPTARG'" >&2
            exit 1;;
        esac;;
      *)
        echo "$PROG: unknown option '-${OPTARG}'" >&2
        exit 1;;
    esac
  done
  if [ $# -ge $OPTIND ]; then
    echo "$PROG: unexpected command line argument: $@}"
    exit 1
  fi
  # specific errors for this script
  if [[ -z $SYNC && -z $INSTALL && -z $UPLOAD && -z $ARCHIVE ]]; then
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

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

fmt_error() {
  printf '%sError: %s%s\n' "${RED}" "$*" "${ENDC}" >&2
}

## Synchronize dotfiles function
function sync_dotfiles
{
  # list all versioned files in the common dir
  for src in $(git ls-files $BASEDIR/$ENVNAME $(echo "$@" | grep "." | perl -pe "s|^|$BASEDIR/|")); do
    raw=$(echo $src | perl -pe 's|^\w+/||')
    dir=$(echo $src | perl -pe 's|^(\w+)/.*|$1|')
    dest="$DESTDIR/$raw"
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
        if [[ `${CMD_STAT} $src` -gt `${CMD_STAT} $dest` ]]; then
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
  done
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
  cd /tmp && tar -czf ${ARCHIVENAME}.tar.gz ${ARCHIVENAME} && cd - > /dev/null && cp /tmp/${ARCHIVENAME}.tar.gz .
}

## Install Nerd fonts (from release *.zip)
# parameter(1): name on the nerd font
# parameter(2): version of the nerd font
function install_nerdfonts
{
  local giturl="https://github.com/ryanoasis/nerd-fonts/releases/download"
  local fonturl="${giturl}/$2/$1.zip"
  local fontdir="${HOME}/.local/share/fonts"
  local currentdir="$(pwd)"
  # create dir
  mkdir -p $fontdir
  # download & unzip
  echo -e "${GREEN}> Downloading $1 fonts${ENDC}"
  cd /tmp && curl -fLo "${1}.zip" $fonturl && unzip -o "${1}.zip" -d $fontdir
  # reset font cache on Linux
  if which fc-cache >/dev/null 2>&1 ; then
    echo -e "${GREEN}> Resetting font cache${ENDC}"
    fc-cache -vf $fontdir
  fi
  cd $currentdir
}

## Install Powerline fonts (from github repo)
# parameter(1): name on the powerline font
function install_powerline_fonts
{
  local giturl="https://github.com/powerline/fonts.git"
  local cloneopt="--depth=1"
  local currentdir="$(pwd)"
  # clone the repo
  echo -e "${GREEN}> Downloading $1 fonts${ENDC}"
  git clone $giturl $cloneopt
  # install the fonts (in ./local/share/fonts)
  cd fonts && ./install.sh ${1} && cd ..
  # destroy the repo (because all fonts are installed)
  rm -rf fonts
  cd $currentdir
}

## Install Tmux plugin manager
function install_tpm
{
  local tpmurl="https://github.com/tmux-plugins/tpm"
  local tpmdir="${HOME}/.tmux/plugins/tpm"
  if [[ -d $tpmdir ]]; then
    echo -e "${GREEN}> Tmux plugin manager already installed${ENDC}"
  else
    echo -e "${GREEN}> Downloading Tmux plugin manager${ENDC}"
    git clone $tpmurl $tpmdir
    [[ -f ${HOME}/.tmux.conf ]] && tmux source ${HOME}/.tmux.conf
  fi
}

## Install (extra) dependencies
function install_deps
{
  if [[ -z $DRYRUN ]]; then
    case "$OSTYPE" in
      darwin*)  setup_macos;;
      linux*)   setup_linux;;
      *)        fmt_error "platform $OSTYPE not supported"
                exit 1;;
    esac
    install_nerdfonts $FONTNAME $FONTVERSION
    # install_powerline_fonts $FONTNAME
    install_tpm
  else
    echo "> Install $FONTNAME Nerd Fonts ($FONTVERSION)"
    # echo "> Install $FONTNAME Powerline Fonts (from github)"
    echo "> Install Tmux plugin manager (from github)"
  fi
}

## Setup for MacOS from scratch
function setup_macos
{
  echo -e "${GREEN}> Setup requirements for MacOS${ENDC}"
  if [ `xcode-select -p >/dev/null` ]; then
    xcode-select --install
  fi
  command_exists brew || {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  }
  # make sure the system has all requirements
  brew install git
  command_exists wget || { brew install wget; }
  command_exists gls  || { brew install coreutils; }
  command_exists tree || { brew install tree; }
  command_exists tmux || { brew install tmux; }
  command_exists htop || { brew install htop; }
}

## Setup Linux requirements
function setup_linux
{
  command_exists git  || { fmt_error "git is not installed"; exit 1; }
  command_exists wget || { fmt_error "wget is not installed"; exit 1; }
}

## Upload dotfiles function
function upload_dotfiles
{
  # list all versioned files in the common dir
  for src in $(git ls-files $BASEDIR/$ENVNAME $(echo "$@" | grep "." | perl -pe "s|^|$BASEDIR/|")); do
    raw=$(echo $src | perl -pe 's|^\w+/||')
    dir=$(echo $src | perl -pe 's|^(\w+)/.*|$1|')
    dest="$DESTDIR/$raw"

    if [[ ! -f $dest ]]; then
      echo -en "${CYAN}            Missing File${ENDC}"
    else
      if diff -q $src $dest 2>&1 > /dev/null; then
        echo -en "${GREEN}              Up-to-date${ENDC}"
      else
        if [[ `${CMD_STAT} $dest` -gt `${CMD_STAT} $src` ]]; then
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
  done
}

## Main function
process_opts $@
[[ ! -z $ARCHIVE ]] && archive_dotfiles
[[ ! -z $INSTALL ]] && install_deps
[[ ! -z $SYNC    ]] && sync_dotfiles
[[ ! -z $UPLOAD  ]] && upload_dotfiles
exit 0

# vim: set shiftwidth=2:
