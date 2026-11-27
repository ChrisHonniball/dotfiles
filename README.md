# My DotFiles

This (like other dotfiles) repositories are all of my dotfiles for setting on my computer.

## Cloning

```bash
cd ~
git clone --recursive git@github.com:ChrisHonniball/dotfiles.git dotfiles
```

## Installation

- Clone to `~/dotfiles`. `.zshrc` expects oh-my-zsh at `~/dotfiles/oh-my-zsh`.
- Verify that the host computer has zsh installed: `which zsh`
  - If not installed, install it using a pachage manager
- `./install.sh --set-shell` - Fetches oh-my-zsh, symlinks the files in `symlinks.def`, and switches the login shell to zsh.
  - Existing files are moved to `backups/<timestamp>/`. Safe to re-run.
  - Add `--install-fonts` to install the fonts in `fonts/`.
  - Add `-T` for a dry run, `--help` for all options.
- **If connected to a server do not logout!!!**
- Connect to server using a separate teminal to ensure all works.
  - If not... debug that shit...
- PROFIT

## Uninstallation

```bash
./uninstall.sh   # same as ./install.sh --uninstall
```

Removes only the symlinks that point into this repo and restores the most recent backup of each file. Add `-T` for a dry run.
