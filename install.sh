#!/bin/bash

# Text colors.
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

#echo -e "${GREEN}This text is green"
#echo -e "${YELLOW}This text is yellow"
#echo -e "${RED}This text is red"
#echo -e "${RESET}This text is normal again"

########################################
#!             Variables               #
########################################

# Set a variable for the dir of this script.
SCRIPT_ROOT=$PWD

# Backup Directory
BACKUP_DIR=$SCRIPT_ROOT/backups

# Dev flag so that you can do a test run with debug output.
DEVELOPMENT_ENVIRONMENT=false

# Directory to send the files to.
INSTALL_DIR=~

# Whether or not to install fonts.
INSTALL_FONTS=false

# Dir to install fonts to.
FONT_DIR=~/Library/Fonts

# Whether or not to requrire root/sudo to run this script.
REQUIRE_ROOT=false

# Check to make sure we are running as the root user.
# We need these permissions for some file/dir movement.
if $REQUIRE_ROOT; then
  if [[ $EUID -ne 0 ]]; then
     echo -e "${RED}This script must be run as root${RESET}"
     exit 1
  fi
fi


if ! command -v zsh &> /dev/null
then
    echo -e "${RED}command zsh not found. Please install first.${RESET}"
    exit
fi

########################################
#!             Arguments               #
########################################

# Process through sent arguments. If any.
while [[ $# > 0 ]]; do
  KEY=$1

  case $KEY in
    --install-dir)
      INSTALL_DIR="$2"
      shift
    ;;
    -b|--backup-dir)
      BACKUP_DIR="$2"
      shift
    ;;
    -f|--files)
      files="$2"
      shift
    ;;
    --install-fonts)
      INSTALL_FONTS=true
      shift
    ;;
    --font-dir)
      FONT_DIR="$2"
      shift
    ;;
    -T|--test)
      echo -e "${RED}########## DEV ##########\n"
      DEVELOPMENT_ENVIRONMENT=true
    ;;
  esac

  shift
done

# change to the script's directory
cd $SCRIPT_ROOT

########################################################
#!             Set files to be symlinked               #
########################################################

# files array should contain this repo's file/dir that is to be symlinked.
declare -a FILES

# Import the lines from symlinks.def into an array for processing.
if [ ! -f symlinks.def ]; then
  echo -e "\n${RED}Unable to locate \"symlinks.def\".\n\nFAILED${RESET}"
  exit 1
fi
while read LINE; do
  FILES+=("$LINE")
done < symlinks.def

# create backup directory
echo -e "${GREEN}Creating \"$BACKUP_DIR\" for backup of any existing files"
if $DEVELOPMENT_ENVIRONMENT; then
  echo -e "TEST COMMAND: mkdir -p $BACKUP_DIR"
else
  mkdir -p $BACKUP_DIR
fi

##########################################################
#!             Loop through the files/dirs               #
##########################################################

# Set a variable to the length of the array.
LENGTH=${#FILES[@]}
echo -e "\n${GREEN}Processing through $LENGTH files..."

# Loop through the files to create the symlinks.
for FILE in ${FILES[@]}; do
  echo -e "\n${GREEN}Processing file \"$FILE\""

  # Check if the file/dir exists. If it does, back it up.
  if [ -d $INSTALL_DIR/$FILE ] || [ -f $INSTALL_DIR/$FILE ]; then
    # Move the file to this repo's backups folder.
    echo -e "${YELLOW}Backing up existing \"$INSTALL_DIR/$FILE\" to \"$BACKUP_DIR/$FILE\""

    if $DEVELOPMENT_ENVIRONMENT; then
      echo -e "mv -f $INSTALL_DIR/$FILE $BACKUP_DIR/$FILE"
    else
      FILE_DIR=$(dirname "backups/$FILE")
      if [ ! -d $FILE_DIR ]; then
        mkdir -p $FILE_DIR
      fi

      mv -f $INSTALL_DIR/$FILE $BACKUP_DIR/$FILE
    fi
  else
    echo -e "${YELLOW}No backup needed. File \"${INSTALL_DIR}/$FILE\" does not exist."
  fi

  echo -e "${GREEN}Creating symlink to \"${SCRIPT_ROOT}/$FILE\" at \"${INSTALL_DIR}/$FILE\""

  # Make sure the destination directories exist.
  if $DEVELOPMENT_ENVIRONMENT; then
    # Create symlink to the repo's test directory.
    echo -e "TEST COMMAND: ln -s \"${SCRIPT_ROOT}/$FILE\" \"${INSTALL_DIR}/$FILE\""
  else
    FILE_DIR=$(dirname "${INSTALL_DIR}/$FILE")
    if [ ! -d $FILE_DIR ]; then
      mkdir -p $FILE_DIR
    fi

    # Create symlink to the repo's directory.
    ln -sf "${SCRIPT_ROOT}/$FILE" "${INSTALL_DIR}/$FILE"
  fi
done

if [ $INSTALL_FONTS ]; then
  echo -e "\n${GREEN}Installing Fonts..."
  if $DEVELOPMENT_ENVIRONMENT; then
    echo -e "TEST COMMAND: cp -f $SCRIPT_ROOT/fonts/* $FONT_DIR"
  else
    cp -f $SCRIPT_ROOT/fonts/* $FONT_DIR
  fi
fi

if [ "$DEVELOPMENT_ENVIRONMENT" = false ]; then
  # Remove backup directory if empty.
  if [ ! "$(ls -A ${SCRIPT_ROOT}/backups)" ]; then
    rmdir $BACKUP_DIR
    echo -e "\n${RED}No Backups required. Backup directory removed."
  fi
fi

# Notify that the script is complete.
echo -e "\n${GREEN}DONE!"

# Reset the font colors.
echo -e "${RESET}"
