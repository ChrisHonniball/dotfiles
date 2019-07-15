# My DotFiles

This (like other dotfiles) repositories are all of my dotfiles for setting on my computer.

## Cloning

```
cd ~
git clone --recursive git@github.com:ChrisHonniball/dotfiles.git dotfiles
```

## Installation

- `./install.sh` - Installs the configuration files for _most_ editors.
- `ln -s /Users/cjhonniball/dotfiles/sublime/ /Users/cjhonniball/Library/Application\ Support/Sublime\ Text\ 3/Packages/User` - Install Sublime Text `User` items
- `ln -s /Users/cjhonniball/dotfiles/merge/ /Users/cjhonniball/Library/Application\ Support/Sublime\ Merge/Packages/User` - Install Sublime Merge `User` items

## Uninstallation

```
./uninstall.sh
```
