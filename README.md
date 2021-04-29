# My DotFiles

This (like other dotfiles) repositories are all of my dotfiles for setting on my computer.

## Cloning

```
cd ~
git clone --recursive git@github.com:ChrisHonniball/dotfiles.git dotfiles
```

## Installation

- Verify that the host computer has zsh installed: `which zsh`
  - If not installed, install it using a pachage manager
- Switch default shell to zsh: `chsh -s $(which zsh)`
- `./install.sh` - Installs the configuration files for _most_ editors.
- **If connected to a server do not logout!!!**
- Connect to server using a separate teminal to ensure all works.
  - If not... debug that shit...
- PROFIT

## Uninstallation

```
./uninstall.sh
```
