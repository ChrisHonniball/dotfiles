GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_STATESEPARATOR=""

source ~/dotfiles/shell/colors.sh
source ~/dotfiles/shell/git-prompt.sh

export LOCALE=UTF-8
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

PROMPT_COMMAND='__git_ps1 "\n\[$Cyan\]\u@\h:\[$Yellow\]\w\[$Color_Off\]" "\n\[$Color_Off\]\342\206\243 " " [%s]"'

alias tower=gittower
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
