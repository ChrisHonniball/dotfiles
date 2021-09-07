source ~/dotfiles/backups/.bashrc > /dev/null

source ~/dotfiles/shell/colors.sh
source ~/dotfiles/shell/git-prompt.sh
source ~/dotfiles/shell/aliases.sh

PROMPT_COMMAND='__git_ps1 "
\[$Black\]\[$On_Cyan\] \u@\h \[$Color_Off\] \D{%F %T %Z}
\[$Black\]\[$On_Yellow\] \w \[$Color_Off\]
\[$Color_Off\]" "$ " "%s "'
