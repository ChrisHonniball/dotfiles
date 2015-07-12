#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

source settings.sh

########## Variables

while [[ $# > 0 ]]; do
  KEY=$1
  
  case $KEY in
    -b|--backupdir)
      backupdir="$2"
      shift
    ;;
    -f|--files)
      files="$2"
      shift
    ;;
  esac
  
  shift
done

backupdir=${backupdir:-~/dotfiles_backup} # old dotfiles backup directory

# list of files/folders to symlink in homedir
files=${files:-"vimrc gvimrc vim zshrc oh-my-zsh bash_profile gitconfig atom"}

##########

# check for dotfiles backup in homedir
if [ -d ~/$backupdir ]; then
  echo -e "\033[31m$backupdir does not exist. Old files will not restore."
fi

# move any existing dotfiles in homedir to dotfiles_backup directory, then create symlinks 
for file in $files; do
  if [ -h ~/.$file ]; then
    echo -e "\033[32mRemoving symlink to ~/.$file"
    rm ~/.$file
  else
    echo -e "\033[31m ~/.$file doesn't exist. Unable to delete symlink."
  fi
done
