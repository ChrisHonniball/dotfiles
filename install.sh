#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

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
files=${files:-"vimrc gvimrc vim zshrc oh-my-zsh bash_profile bashrc gitconfig atom"}

##########

# create dotfiles_backup in homedir
echo -e "\033[33mCreating $backupdir for backup of any existing dotfiles"
mkdir -p $backupdir

# change to the dotfiles directory
cd ~/dotfiles

# move any existing dotfiles in homedir to backup directory, then create symlinks 
for file in $files; do
  if [ -h ~/.$file ]; then
    echo -e "\033[31m~/.$file symlink exists. Removing..."
    rm ~/.$file
  fi
  
  if [ -f ~/.$file ] || [ -d ~/$file ]; then
    echo -e "\033[31mBacking up existing ~/$file to ~/dotfiles_backup/$file"
    mv -f ~/.$file ~/dotfiles_backup/$file
  fi
  
  if [ -f ~/dotfiles/$file ] || [ -d ~/dotfiles/$file ]; then
    echo -e "\033[32mCreating symlink to ~/.$file"
    ln -sf ~/dotfiles/$file ~/.$file
  else
    echo -e "\033[31m ~/.$file doesn't exist in ~/dotfiles. Unable to create symlink."
  fi
done

# remove backup directory if empty
if [ ! "$(ls -A $backupdir)" ]; then
  rmdir $backupdir
  echo -e "\033[31mNo Backups required. Backup directory removed."
fi
