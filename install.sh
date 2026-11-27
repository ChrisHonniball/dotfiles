#!/bin/bash

# Stop on errors, unset variables and failures inside pipelines.
set -euo pipefail

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

# Dir to install fonts to. Depends on the OS; empty means "unknown, pass --font-dir".
OS="$(uname -s)"
case "$OS" in
  Darwin) FONT_DIR="$HOME/Library/Fonts" ;;
  Linux)  FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts" ;;
  *)      FONT_DIR="" ;;
esac

# Whether to fetch git submodules (oh-my-zsh) before linking.
INIT_SUBMODULES=true

# Whether to change the login shell to zsh.
SET_SHELL=false

# Remove the symlinks and restore backups instead of installing.
UNINSTALL=false

# The files this repo can link, as "name|description" or
# "name|description|repo path". The name is the path in the install dir (and
# what --only takes); the repo path defaults to the same name. Add new ones here.
DOTFILES=(
  ".zshrc|zsh config: oh-my-zsh, prompt, aliases"
  ".bashrc|bash config: prompt, aliases"
  ".bash_profile|bash login setup: loads .bashrc and RVM"
  ".gitconfig|git settings and aliases"
  ".vimrc|vim config"
  # Stored as "claude/" (no dot) so Claude Code doesn't also read it as this
  # repo's project-level .claude config. See .gitignore for what's tracked.
  ".claude|Claude Code user config (settings, skills)|claude"
)

# How to pick files: "menu" (interactive), "all", or "only" (from --only).
SELECT_MODE="menu"
ONLY_LIST=""

# Whether or not to requrire root/sudo to run this script.
REQUIRE_ROOT=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [options]

Shows a checklist of this repo's dotfiles and symlinks the ones you pick into
your home directory. Existing real files are moved to a timestamped backup
folder first. Safe to run again: links that are already correct are left alone.

Before linking .zshrc it fetches the git submodules (oh-my-zsh) if needed.

With --uninstall it removes only the symlinks that point into this repo and
restores each file's most recent backup.

Files: $(i=0; while [ $i -lt ${#DOTFILES[@]} ]; do printf '%s ' "${DOTFILES[$i]%%|*}"; i=$((i + 1)); done)

Options:
  -a, --all             Use every file, without showing the checklist
  --only LIST           Use only these files, e.g. --only .zshrc,.vimrc
  -u, --uninstall       Remove the symlinks and restore backups
  --install-dir DIR     Where to create the symlinks (default: \$HOME)
  -b, --backup-dir DIR  Where to keep backups (default: <repo>/backups)
  --install-fonts       Also copy fonts/* into the font directory
  --font-dir DIR        Font directory (default: ${FONT_DIR:-none for $OS, required})
  --set-shell           Change your login shell to zsh (asks for your password)
  --no-submodules       Don't fetch/update git submodules
  -T, --test            Dry run: print what would happen, change nothing
  -h, --help            Show this help
EOF
}

die() {
  echo -e "${RED}$*${RESET}" >&2
  exit 1
}

########################################
#!             Arguments               #
########################################

# Make sure an option that takes a value actually got one.
require_value() {
  if [ $# -lt 2 ] || [ -z "$2" ] || [[ "$2" == -* ]]; then
    die "Option $1 requires a value. See --help."
  fi
}

# Process through sent arguments. If any.
while [ $# -gt 0 ]; do
  KEY="$1"

  case "$KEY" in
    --install-dir)
      require_value "$@"
      INSTALL_DIR="$2"
      shift
    ;;
    -b|--backup-dir)
      require_value "$@"
      BACKUP_DIR="$2"
      shift
    ;;
    --install-fonts)
      INSTALL_FONTS=true
    ;;
    --font-dir)
      require_value "$@"
      FONT_DIR="$2"
      shift
    ;;
    --set-shell)
      SET_SHELL=true
    ;;
    --no-submodules)
      INIT_SUBMODULES=false
    ;;
    -u|--uninstall)
      UNINSTALL=true
    ;;
    -a|--all)
      SELECT_MODE="all"
    ;;
    --only)
      require_value "$@"
      SELECT_MODE="only"
      ONLY_LIST="$2"
      shift
    ;;
    -T|--test)
      echo -e "${RED}########## DEV ##########\n"
      DEVELOPMENT_ENVIRONMENT=true
    ;;
    -h|--help)
      usage
      exit 0
    ;;
    *)
      echo -e "${RED}Unknown option: $KEY${RESET}\n" >&2
      usage >&2
      exit 1
    ;;
  esac

  shift
done

########################################
#!             Checks                  #
########################################

# Check to make sure we are running as the root user.
# We need these permissions for some file/dir movement.
if $REQUIRE_ROOT && [ "$EUID" -ne 0 ]; then
  die "This script must be run as root"
fi

if $UNINSTALL && { $INSTALL_FONTS || $SET_SHELL; }; then
  die "--uninstall can't be combined with --install-fonts or --set-shell."
fi

if ! $UNINSTALL && ! command -v zsh &> /dev/null; then
  die "command zsh not found. Please install first."
fi

if $INSTALL_FONTS && [ -z "$FONT_DIR" ]; then
  die "No default font directory for $OS. Pass --font-dir DIR."
fi

# change to the script's directory
cd "$SCRIPT_ROOT"

########################################################
#!             Choose files to be symlinked            #
########################################################

NUM_ITEMS=${#DOTFILES[@]}

item_name() { echo "${DOTFILES[$1]%%|*}"; }
item_desc() { local rest="${DOTFILES[$1]#*|}"; echo "${rest%%|*}"; }
# Path inside the repo: the optional third field, else the name.
item_src() {
  local rest="${DOTFILES[$1]#*|}"
  if [[ "$rest" == *"|"* ]]; then echo "${rest#*|}"; else item_name "$1"; fi
}
# Repo path for a name (as used in FILES).
src_for() {
  local i=0
  while [ $i -lt $NUM_ITEMS ]; do
    if [ "$(item_name $i)" = "$1" ]; then item_src $i; return; fi
    i=$((i + 1))
  done
  echo "$1"
}

# True if the file is already linked into the install dir from this repo.
is_linked() {
  [ -L "$INSTALL_DIR/$1" ] && [ "$(readlink "$INSTALL_DIR/$1")" = "$SCRIPT_ROOT/$(src_for "$1")" ]
}

# A short note on what installing would do to each file.
item_status() {
  local dest="$INSTALL_DIR/$1"
  if is_linked "$1"; then
    echo "linked"
  elif [ ! -e "$SCRIPT_ROOT/$(src_for "$1")" ]; then
    echo "missing from repo"
  elif [ -L "$dest" ]; then
    echo "other symlink, will be replaced"
  elif [ -e "$dest" ]; then
    echo "exists, will be backed up"
  else
    echo "not installed"
  fi
}

# SELECTED[i] is 1 when DOTFILES[i] is picked.
SELECTED=()
i=0
while [ $i -lt $NUM_ITEMS ]; do
  if $UNINSTALL; then
    # Uninstall: start with what's currently linked.
    if is_linked "$(item_name $i)"; then SELECTED[$i]=1; else SELECTED[$i]=0; fi
  else
    SELECTED[$i]=1
  fi
  i=$((i + 1))
done

# Interactive checklist drawn on the terminal. Arrow keys or j/k move, space
# toggles, "a" toggles all, enter confirms, q or Esc cancels.
choose_files() {
  local cur=0 key rest i count first=true action mark pointer
  if $UNINSTALL; then action="uninstall"; else action="install"; fi

  # Hide the cursor while the menu is up and always restore it on exit.
  trap 'printf "\033[?25h" > /dev/tty' EXIT
  printf '\033[?25l' > /dev/tty

  while true; do
    # Redraw in place: jump back to the top of the previous drawing.
    if ! $first; then printf '\033[%dA' $((NUM_ITEMS + 2)) > /dev/tty; fi
    first=false

    printf '\r\033[K%bChoose files to %s%b  (↑/↓ move, space toggle, a all, enter confirm, q quit)\n' \
      "$GREEN" "$action" "$RESET" > /dev/tty
    count=0
    i=0
    while [ $i -lt $NUM_ITEMS ]; do
      if [ "${SELECTED[$i]}" = 1 ]; then mark="x"; count=$((count + 1)); else mark=" "; fi
      if [ $i -eq $cur ]; then pointer="${YELLOW}>${RESET}"; else pointer=" "; fi
      printf '\r\033[K %b [%s] %-14s %-42s %b(%s)%b\n' "$pointer" "$mark" \
        "$(item_name $i)" "$(item_desc $i)" "$YELLOW" "$(item_status "$(item_name $i)")" "$RESET" > /dev/tty
      i=$((i + 1))
    done
    printf '\r\033[K  %d of %d selected\n' "$count" "$NUM_ITEMS" > /dev/tty

    IFS= read -rsn1 key < /dev/tty || key="q"
    if [ "$key" = $'\033' ]; then
      # Arrow keys arrive as ESC [ A / ESC [ B. A lone ESC means cancel.
      IFS= read -rsn2 -t 1 rest < /dev/tty || rest=""
      key="$key$rest"
    fi

    case "$key" in
      $'\033[A'|k) cur=$(( (cur - 1 + NUM_ITEMS) % NUM_ITEMS )) ;;
      $'\033[B'|j) cur=$(( (cur + 1) % NUM_ITEMS )) ;;
      " ")
        if [ "${SELECTED[$cur]}" = 1 ]; then SELECTED[$cur]=0; else SELECTED[$cur]=1; fi
      ;;
      a|A)
        # Select all, or clear all if everything is already selected.
        local new=1
        if [ $count -eq $NUM_ITEMS ]; then new=0; fi
        i=0
        while [ $i -lt $NUM_ITEMS ]; do SELECTED[$i]=$new; i=$((i + 1)); done
      ;;
      "") break ;;
      q|Q|$'\033')
        printf '\033[?25h' > /dev/tty
        echo -e "\n${YELLOW}Cancelled. Nothing was changed.${RESET}"
        exit 0
      ;;
    esac
  done

  printf '\033[?25h' > /dev/tty
  trap - EXIT
}

case "$SELECT_MODE" in
  all)
    i=0
    while [ $i -lt $NUM_ITEMS ]; do SELECTED[$i]=1; i=$((i + 1)); done
  ;;
  only)
    i=0
    while [ $i -lt $NUM_ITEMS ]; do SELECTED[$i]=0; i=$((i + 1)); done
    WANTED=()
    IFS=',' read -r -a WANTED <<< "$ONLY_LIST" || true
    # (Indexed loop: bash 3.2 errors on "${EMPTY[@]}" under set -u.)
    j=0
    while [ $j -lt ${#WANTED[@]} ]; do
      NAME="${WANTED[$j]// /}"
      j=$((j + 1))
      if [ -z "$NAME" ]; then continue; fi
      FOUND=false
      i=0
      while [ $i -lt $NUM_ITEMS ]; do
        if [ "$(item_name $i)" = "$NAME" ]; then SELECTED[$i]=1; FOUND=true; fi
        i=$((i + 1))
      done
      $FOUND || die "Unknown file in --only: \"$NAME\". See --help for the list."
    done
  ;;
  menu)
    if [ ! -t 0 ] || [ ! -t 1 ]; then
      die "No terminal for the checklist. Use --all or --only FILE,FILE (see --help)."
    fi
    choose_files
  ;;
esac

# FILES holds the chosen paths, in list order.
FILES=()
i=0
while [ $i -lt $NUM_ITEMS ]; do
  NAME="$(item_name $i)"
  if [ "${SELECTED[$i]}" = 1 ]; then
    # Don't create dangling links for entries that aren't in the repo.
    # (Uninstall still processes them so old links can be cleaned up.)
    if ! $UNINSTALL && [ ! -e "$SCRIPT_ROOT/$(item_src $i)" ]; then
      echo -e "${YELLOW}Skipping \"$NAME\": $(item_src $i) not found in $SCRIPT_ROOT${RESET}"
    else
      FILES+=("$NAME")
    fi
  fi
  i=$((i + 1))
done

if [ ${#FILES[@]} -eq 0 ]; then
  echo -e "${YELLOW}No files selected. Nothing to do.${RESET}"
  exit 0
fi

########################################
#!             Submodules              #
########################################

# .zshrc sources oh-my-zsh from this repo, so make sure it's checked out
# before linking it. Skipped when this isn't a git checkout (e.g. a zip download).
ZSHRC_SELECTED=false
for NAME in "${FILES[@]}"; do
  if [ "$NAME" = ".zshrc" ]; then ZSHRC_SELECTED=true; fi
done
if ! $UNINSTALL && $ZSHRC_SELECTED && $INIT_SUBMODULES && [ -f .gitmodules ] && git rev-parse --git-dir &> /dev/null; then
  echo -e "${GREEN}Updating git submodules..."
  if $DEVELOPMENT_ENVIRONMENT; then
    echo -e "TEST COMMAND: git submodule sync --recursive && git submodule update --init --recursive"
  elif ! { git submodule sync --recursive > /dev/null && git submodule update --init --recursive; }; then
    echo -e "${RED}WARNING: git submodule update failed. oh-my-zsh may be missing and zsh will not load it.${RESET}"
  fi
fi

# Run a command, or just print it in test mode.
run() {
  if $DEVELOPMENT_ENVIRONMENT; then
    echo -e "TEST COMMAND: $*"
  else
    "$@"
  fi
}

##########################################################
#!             Uninstall                                 #
##########################################################

if $UNINSTALL; then
  # Timestamped backup folders, oldest first (the names sort chronologically).
  shopt -s nullglob
  RUN_DIRS=("$BACKUP_DIR"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]_[0-9]*)
  shopt -u nullglob

  echo -e "\n${GREEN}Uninstalling ${#FILES[@]} files..."

  for FILE in "${FILES[@]}"; do
    SRC="$SCRIPT_ROOT/$(src_for "$FILE")"
    DEST="$INSTALL_DIR/$FILE"
    echo -e "\n${GREEN}Processing file \"$FILE\""

    if [ -L "$DEST" ] && [ "$(readlink "$DEST")" = "$SRC" ]; then
      echo -e "${GREEN}Removing symlink \"$DEST\""
      run rm "$DEST"
    elif [ -e "$DEST" ] || [ -L "$DEST" ]; then
      # Never touch anything we didn't create.
      echo -e "${YELLOW}Leaving \"$DEST\" alone: it isn't a symlink to this repo."
      continue
    fi

    # Find the most recent backup: newest timestamped folder first, then the
    # old flat layout (backups/<file>) used by earlier versions of this script.
    BACKUP=""
    i=$(( ${#RUN_DIRS[@]} - 1 ))
    while [ $i -ge 0 ]; do
      if [ -e "${RUN_DIRS[$i]}/$FILE" ] || [ -L "${RUN_DIRS[$i]}/$FILE" ]; then
        BACKUP="${RUN_DIRS[$i]}/$FILE"
        break
      fi
      i=$(( i - 1 ))
    done
    if [ -z "$BACKUP" ] && { [ -e "$BACKUP_DIR/$FILE" ] || [ -L "$BACKUP_DIR/$FILE" ]; }; then
      BACKUP="$BACKUP_DIR/$FILE"
    fi

    if [ -n "$BACKUP" ]; then
      echo -e "${YELLOW}Restoring backup \"$BACKUP\" to \"$DEST\""
      run mkdir -p "$(dirname "$DEST")"
      run mv "$BACKUP" "$DEST"
    else
      echo -e "${YELLOW}No backup to restore for \"$FILE\"."
    fi
  done

  # Tidy up backup folders that are now empty.
  if ! $DEVELOPMENT_ENVIRONMENT; then
    i=0
    while [ $i -lt ${#RUN_DIRS[@]} ]; do
      find "${RUN_DIRS[$i]}" -depth -type d -empty -delete
      i=$(( i + 1 ))
    done
    rmdir "$BACKUP_DIR" 2> /dev/null || true
  fi

  echo -e "\n${GREEN}DONE!${RESET}"
  exit 0
fi

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
  SRC="$SCRIPT_ROOT/$(src_for "$FILE")"
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
    # Linux needs the font cache refreshed; macOS picks fonts up automatically.
    if [ "$OS" = Linux ] && command -v fc-cache &> /dev/null; then
      fc-cache -f "$FONT_DIR" > /dev/null
    fi
  fi
fi

if $SET_SHELL; then
  ZSH_PATH="$(command -v zsh)"
  # Look up the real login shell; $SHELL can be stale or overridden.
  if [ "$OS" = Darwin ]; then
    LOGIN_SHELL="$(dscl . -read "/Users/$(id -un)" UserShell 2> /dev/null | awk '{print $2}' || true)"
  else
    LOGIN_SHELL="$(getent passwd "$(id -un)" 2> /dev/null | cut -d: -f7 || true)"
  fi
  LOGIN_SHELL="${LOGIN_SHELL:-$SHELL}"

  if [ "$LOGIN_SHELL" = "$ZSH_PATH" ]; then
    echo -e "\n${GREEN}Login shell is already $ZSH_PATH"
  elif ! grep -qx "$ZSH_PATH" /etc/shells; then
    echo -e "\n${RED}$ZSH_PATH is not listed in /etc/shells, so chsh will refuse it. Add it with:"
    echo -e "  echo \"$ZSH_PATH\" | sudo tee -a /etc/shells${RESET}"
  else
    echo -e "\n${GREEN}Changing login shell from $LOGIN_SHELL to $ZSH_PATH..."
    if $DEVELOPMENT_ENVIRONMENT; then
      echo -e "TEST COMMAND: chsh -s \"$ZSH_PATH\""
    else
      chsh -s "$ZSH_PATH"
    fi
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
