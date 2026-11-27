#!/bin/bash
# Uninstalling lives in install.sh so the two can't drift apart.
# Removes only symlinks that point into this repo and restores the latest backups.
# Accepts the same options, e.g. ./uninstall.sh -T for a dry run.
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/install.sh" --uninstall "$@"
