ZSH=$HOME/.oh-my-zsh

export CFLAGS="-march=native -O2"
export CXXFLAGS=${CFLAGS}
export EDITOR=vim
export JAVA_HOME=/usr/lib/jvm/default-java
JAVA_OPTS="-d32 -client -J-Xmx1024m"
export JAVACMD=~/bin/drip
LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias tmux="TERM=screen-256color-bce tmux"
alias git="nocorrect git"
alias sudo="nocorrect sudo"

alias daily-upgrade="sudo apt-get update && sudo apt-get upgrade"
alias install="sudo apt-get install --no-install-recommends"
alias uninstall="sudo apt-get autoremove"
alias service="sudo sudo service"
alias extract="tar xf"
alias service="sudo service"
alias reload!='source ~/.zshrc'
alias w='tmux attach -t'
alias mux='tmux new-session -s `basename \`(git rev-parse --show-toplevel) || pwd\``'
alias ack='ack-grep --color'
alias up='cd ..'
alias wow='git st'


[[ -s /home/andrei/.nvm/nvm.sh ]] && . /home/andrei/.nvm/nvm.sh # This loads NVM

PATH=$PATH:$HOME/bin:$HOME/.gem/ruby/2.0.0/bin
source /usr/local/share/chruby/auto.sh

autoload -U promptinit && promptinit
prompt pure

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
