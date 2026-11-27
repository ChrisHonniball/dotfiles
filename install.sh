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

# The directory this script lives in (works no matter where it's run from).
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup Directory
BACKUP_DIR="$SCRIPT_ROOT/backups"

# Dev flag so that you can do a test run with debug output.
DEVELOPMENT_ENVIRONMENT=false

# Directory to send the files to.
INSTALL_DIR="$HOME"

# Whether or not to install fonts.
INSTALL_FONTS=false

# Dir to install fonts to.
FONT_DIR="$HOME/Library/Fonts"

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
cd "$SCRIPT_ROOT"

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
# Blank lines and "#" comments are skipped, surrounding whitespace is trimmed,
# and absolute or "../" paths are rejected so an entry can never point outside
# the repo (or, if blank, at the whole install dir).
# The "|| [ -n ... ]" keeps a final line that has no trailing newline.
while IFS= read -r LINE || [ -n "$LINE" ]; do
  LINE="${LINE#"${LINE%%[![:space:]]*}"}"
  LINE="${LINE%"${LINE##*[![:space:]]}"}"
  if [ -z "$LINE" ] || [[ "$LINE" == \#* ]]; then
    continue
  fi
  if [[ "$LINE" == /* ]] || [[ "$LINE" == ".." ]] || [[ "$LINE" == ../* ]] || [[ "$LINE" == */../* ]] || [[ "$LINE" == */.. ]]; then
    echo -e "${RED}Ignoring invalid entry in symlinks.def: \"$LINE\"${RESET}"
    continue
  fi
  FILES+=("$LINE")
done < symlinks.def

# Each run gets its own timestamped backup folder so earlier backups are never
# overwritten. It is only created if something actually needs backing up.
RUN_BACKUP_DIR="$BACKUP_DIR/$(date +%Y-%m-%d_%H%M%S)"
if [ -e "$RUN_BACKUP_DIR" ]; then
  RUN_BACKUP_DIR="$RUN_BACKUP_DIR-$$"
fi
BACKED_UP=false

##########################################################
#!             Loop through the files/dirs               #
##########################################################

# Set a variable to the length of the array.
LENGTH=${#FILES[@]}
echo -e "\n${GREEN}Processing through $LENGTH files..."

# Loop through the files to create the symlinks.
for FILE in "${FILES[@]}"; do
  SRC="$SCRIPT_ROOT/$FILE"
  DEST="$INSTALL_DIR/$FILE"
  echo -e "\n${GREEN}Processing file \"$FILE\""

  if [ -L "$DEST" ] && [ "$(readlink "$DEST")" = "$SRC" ]; then
    # Already installed. Nothing to do.
    echo -e "${GREEN}Already linked: \"$DEST\" -> \"$SRC\""
    continue
  elif [ -L "$DEST" ]; then
    # A symlink pointing somewhere else (or dangling). Links hold no data, so
    # replace it without backing it up.
    echo -e "${YELLOW}Replacing existing symlink \"$DEST\" -> \"$(readlink "$DEST")\""
    if $DEVELOPMENT_ENVIRONMENT; then
      echo -e "TEST COMMAND: rm \"$DEST\""
    else
      rm "$DEST"
    fi
  elif [ -e "$DEST" ]; then
    # A real file/dir. Move it into this run's backup folder.
    echo -e "${YELLOW}Backing up existing \"$DEST\" to \"$RUN_BACKUP_DIR/$FILE\""
    if $DEVELOPMENT_ENVIRONMENT; then
      echo -e "TEST COMMAND: mv \"$DEST\" \"$RUN_BACKUP_DIR/$FILE\""
    else
      mkdir -p "$(dirname "$RUN_BACKUP_DIR/$FILE")"
      mv "$DEST" "$RUN_BACKUP_DIR/$FILE"
    fi
    BACKED_UP=true
  else
    echo -e "${YELLOW}No backup needed. File \"$DEST\" does not exist."
  fi

  echo -e "${GREEN}Creating symlink to \"$SRC\" at \"$DEST\""

  if $DEVELOPMENT_ENVIRONMENT; then
    echo -e "TEST COMMAND: ln -s \"$SRC\" \"$DEST\""
  else
    # Make sure the destination directories exist.
    mkdir -p "$(dirname "$DEST")"
    ln -s "$SRC" "$DEST"
  fi
done

if $INSTALL_FONTS; then
  echo -e "\n${GREEN}Installing Fonts to \"$FONT_DIR\"..."
  if $DEVELOPMENT_ENVIRONMENT; then
    echo -e "TEST COMMAND: cp -f \"$SCRIPT_ROOT\"/fonts/* \"$FONT_DIR\""
  else
    mkdir -p "$FONT_DIR"
    cp -f "$SCRIPT_ROOT"/fonts/* "$FONT_DIR"
  fi
fi

if $BACKED_UP; then
  echo -e "\n${YELLOW}Backups saved to \"$RUN_BACKUP_DIR\""
else
  echo -e "\n${GREEN}No backups required."
fi

# Notify that the script is complete.
echo -e "\n${GREEN}DONE!"

# Reset the font colors.
echo -e "${RESET}"
