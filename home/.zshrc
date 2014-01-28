# Set some prompt and other stuff
PROMPT='[%B%m%b] %~%# '
RPROMPT=' %*'
PROMPT2='%_> '
PROMPT3='?# '
PROMPT4='+%N:%i> '
MAILCHECK=60
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zhistory
DIRSTACKSIZE=20
#WATCHFMT='%n %a %l from %m at %T.'
LOGCHECK=120
HOSTNAME=`hostname`

# Watch for my friends
watch=(all)                     # watch for everybody but me

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="awesomepanda"
DEFAULT_USER=david
ZSH_THEME="dawi2332"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github svn osx brew pip django autojump history-substring-search vi-mode kbd)
unalias alias
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
typeset -U path
path=($HOME/.bin /usr/local/share/npm/bin /usr/local/bin $path)

setopt autoresume completealiases correct
unsetopt extendedglob correctall

# Search path for the cd command
cdpath=(. .. ~ $cdpath)

# Where to look for autoloaded function definitions
fpath=($HOME/.zsh/functions $fpath)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

local prefix=${ZDOTDIR:-$HOME}/.zsh
for file in rc aliases
do
	[ -r $prefix/common/$file ] && source $prefix/common/$file
	[ -r $prefix/os/$OSTYPE/$file ] && source $prefix/os/$OSTYPE/$file
	[ -r $prefix/host/$HOSTNAME/$file ] && source $prefix/host/$HOSTNAME/$file
done
unset $prefix
