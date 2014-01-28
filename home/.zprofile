local prefix=${ZDOTDIR:-$HOME}/.zsh
[ -r $prefix/common/profile ] && source $prefix/common/profile
[ -r $prefix/os/$OSTYPE/profile ] && source $prefix/os/$OSTYPE/profile
[ -r $prefix/host/$HOSTNAME/profile ] && source $prefix/host/$HOSTNAME/profile
unset prefix
