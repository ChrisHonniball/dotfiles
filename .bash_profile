source ~/.profile
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

PATH=$PATH:$HOME/bin

export PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
