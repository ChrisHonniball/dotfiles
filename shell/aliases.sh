alias tower=gittower
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias mvim='mvim >& /dev/null'
alias dc=docker-compose

source '/Users/cjhonniball/www/af30/environment.sh'
alias build_db='docker-compose up -d python && docker-compose exec python python /af30/scripts/asuite/run_build_db.py'
