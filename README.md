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
- `./install.sh --set-shell` - Shows a checklist of dotfiles to link, fetches oh-my-zsh, and switches the login shell to zsh.
  - In the checklist: ↑/↓ (or j/k) to move, space to toggle, `a` for all/none, enter to confirm, `q` to cancel.
  - Skip the checklist with `--all` or `--only .zshrc,.vimrc` (needed when there's no terminal, e.g. in a script).
  - The list of files lives in the `DOTFILES` array at the top of `install.sh`.
  - `.claude` is the Claude Code user config, stored as `claude/` in the repo (no dot, so Claude Code doesn't also read it as this repo's project config). Only hand-written config (`settings.json`, `CLAUDE.md`, `agents/`, `commands/`, `hooks/`, ...) is tracked; transcripts, credentials, caches and synced plugins/skills are git-ignored. Check `git status` before committing anything new in there.
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

Shows the same checklist, with the currently linked files pre-selected. Removes only the symlinks that point into this repo and restores the most recent backup of each file. Add `-T` for a dry run.
