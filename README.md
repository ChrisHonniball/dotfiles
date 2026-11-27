# My DotFiles

This (like other dotfiles) repositories are all of my dotfiles for setting on my computer.

## Cloning

```bash
cd ~
git clone git@github.com:ChrisHonniball/dotfiles.git dotfiles
```

Clone to `~/dotfiles`: the shell configs load files from `~/dotfiles/...` by path. No need for `--recursive`; `install.sh` fetches the oh-my-zsh submodule itself (over HTTPS, so no SSH key is needed for that part).

## Installation

1. Verify that zsh is installed: `which zsh`. If not, install it with a package manager.
2. Preview what will happen (changes nothing):

   ```bash
   ./install.sh --dry-run
   ```

3. Install:

   ```bash
   ./install.sh --set-shell
   ```

   A checklist of dotfiles appears. ↑/↓ (or j/k) to move, space to toggle, `a` for all/none, enter to confirm, `q` to cancel. The script then:
   - fetches oh-my-zsh (only if `.zshrc` is selected)
   - moves any existing real file to `backups/<timestamp>/` and symlinks the repo's version in its place
   - switches the login shell to zsh (`--set-shell`, asks for your password)

4. **If connected to a server do not logout!!!** Connect using a separate terminal to ensure all works.
   - If not... debug that shit...
5. PROFIT

Safe to re-run: files that are already linked are left alone, and every run's backups go in their own timestamped folder.

### What gets linked

| Home path | Repo path | What it is |
| --- | --- | --- |
| `~/.zshrc` | `.zshrc` | zsh config: oh-my-zsh, prompt, aliases |
| `~/.bashrc` | `.bashrc` | bash config: prompt, aliases |
| `~/.bash_profile` | `.bash_profile` | bash login setup: loads `.bashrc` and RVM |
| `~/.gitconfig` | `.gitconfig` | git settings and aliases |
| `~/.vimrc` | `.vimrc` | vim config |
| `~/.claude` | `claude/` | Claude Code user config |

To add a file, add a line to the `DOTFILES` array at the top of `install.sh`: `"path|description"`, or `"path|description|repo path"` when the repo path differs from the home path.

### Claude Code config (`claude/`)

Stored without the dot so Claude Code doesn't also read it as this repo's project-level `.claude` config. Claude Code writes session transcripts, shell snapshots, IDE auth tokens, credentials (on Linux), caches and synced plugins/skills into this folder, so `.gitignore` ignores everything in it except hand-written config: `settings.json`, `CLAUDE.md`, `keybindings.json`, `agents/`, `commands/`, `hooks/`, `output-styles/`, `statusline*`. Check `git status` before committing anything new in there, and don't put API keys in `settings.json`.

On a new machine where Claude Code is already set up, installing `.claude` backs up the existing `~/.claude`. On Linux that includes the login token, so you'll need to log in again.

### Options

| Option | What it does |
| --- | --- |
| `-n`, `--dry-run` | Print what would happen, change nothing (also `-T`, `--test`) |
| `-a`, `--all` | Use every file, without the checklist |
| `--only LIST` | Use only these files, e.g. `--only .zshrc,.vimrc` |
| `--set-shell` | Change the login shell to zsh |
| `--install-fonts` | Also copy `fonts/*` into the font directory |
| `--font-dir DIR` | Font directory (default: `~/Library/Fonts` on macOS, `~/.local/share/fonts` on Linux) |
| `--no-submodules` | Don't fetch/update oh-my-zsh |
| `--install-dir DIR` | Where to create the links (default: `$HOME`) |
| `-b`, `--backup-dir DIR` | Where to keep backups (default: `backups/`) |
| `-u`, `--uninstall` | Remove the links and restore backups (see below) |
| `-h`, `--help` | Show all options |

Without a terminal (e.g. in a script), the checklist can't be shown, so `--all` or `--only` is required.

## Uninstallation

```bash
./uninstall.sh --dry-run   # preview first
./uninstall.sh             # same as ./install.sh --uninstall
```

Shows the same checklist, with the currently linked files pre-selected. Removes only symlinks that point into this repo (anything else is left alone) and restores the most recent backup of each file.

Files with no backup are simply removed. For `.claude` that means Claude Code starts fresh until you reinstall; the data stays safe in `~/dotfiles/claude`. Untick `.claude` if you want to keep using it.
