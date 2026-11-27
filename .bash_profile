source ~/.profile
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

PATH=$PATH:$HOME/bin

export PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source /Users/cjhonniball/.rvm/scripts/rvm
