zdotdir=${ZDOTDIR:-$HOME}
export ZDOTDIR="$zdotdir"

HOSTNAME=${HOSTNAME:-`hostname`}

zsh-startup() {
    local prefix=$zdotdir/.zsh
    for file in $@
    do
        [ -r $prefix/common/$file ] && source $prefix/common/$file
        [ -r $prefix/os/$OSTYPE/$file ] && source $prefix/os/$OSTYPE/$file
        [ -r $prefix/host/$HOSTNAME/$file ] && source $prefix/host/$HOSTNAME/$file
    done
    unset file
}

zsh-startup env

# Prevent system-wide startup files from messing with our aliases
alias alias=:
