source ~/.profile
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_STATESEPARATOR=""

source ~/dotfiles/shell/colors.sh
source ~/dotfiles/shell/git-prompt.sh

export LOCALE=UTF-8
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export MSDK_HOME=/www/html/localhost-tools/paymentech-sdk/JPMC_MSDK_1.0.0
export JAVA_HOME=/usr
export MSDK_LOG_DIR=/www/log

PROMPT_COMMAND='__git_ps1 "
\[$Black\]\[$On_Cyan\] \u@\h \[$Color_Off\] \D{%F %T %Z}
\[$Black\]\[$On_Yellow\] \w \[$Color_Off\]
\[$Color_Off\]" "$ " "%s "'

alias tower=gittower
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias dc=docker-compose
alias flask='docker-compose up -d --remove-orphans postgres python && docker-compose up flask'
alias awsconsole='ssh ec2-user@awsconsole.avatarfleet.com'
