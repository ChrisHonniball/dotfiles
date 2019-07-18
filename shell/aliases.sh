alias tower=gittower
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias mvim='mvim >& /dev/null'
alias dc=docker-compose

# Asuite

alias watch='npm run dev-watch'
alias dev='npm run dev'

# Get in to various servers:
alias awsconsole='ssh ec2-user@awsconsole.avatarfleet.com'
alias asuite='cd /www/af30'
alias asuite1='ssh ec2-user@asuite1.avatarfleet.com'
alias asuite2='ssh ec2-user@asuite2.avatarfleet.com'
alias asuite3='ssh ec2-user@asuite3.avatarfleet.com'
alias asuite4='ssh ec2-user@asuite4.avatarfleet.com'
alias asuite5='ssh ec2-user@asuite5.avatarfleet.com'
alias asuite-test='ssh ec2-user@asuite-test.avatarfleet.com'
alias asuite-rumpke-test='ssh ec2-user@asuite-rumpke-test.avatarfleet.com'
alias asuite-nacsb-test='ssh ec2-user@asuite-nacsb-test.avatarfleet.com'
alias asuite-dev='ssh ec2-user@asuite-dev.avatarfleet.com'
alias asuite-demo='ssh ec2-user@asuite-demo.avatarfleet.com'

# Celery:
alias celery='docker-compose kill celery-worker && docker-compose up celery-worker'

# Bash session:
alias b='docker-compose exec python bash'

# Python interactive environment
alias p='docker-compose exec python ptpython -i /af30/scripts/asuite_utility_template.py'

Run clean Flask session
alias flask='docker-compose kill flask celery-worker && docker-compose up flask'

# GIT:
alias git-prune-match-remote='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'

# DB Builds and backups
alias build_db='docker-compose down && docker-compose up -d python && sleep 5 && docker-compose exec python python /af30/scripts/asuite/run_build_db.py'
alias backups='asuite ./backups.sh'
alias restore='asuite ./restore_backup.sh'
