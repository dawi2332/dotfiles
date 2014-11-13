zsh-startup() {
    local prefix=${ZDOTDIR:-$HOME}/.zsh
    local hostname=${HOST/.*/}
    for file in $@
    do
        [ -r $prefix/common/$file ] && source $prefix/common/$file
        [ -r $prefix/os/$OSTYPE/$file ] && source $prefix/os/$OSTYPE/$file
        [ -r $prefix/host/$hostname/$file ] && source $prefix/host/$hostname/$file
    done
    unset file
}

zsh-startup env

# Prevent system-wide startup files from messing with our aliases
alias alias=:
