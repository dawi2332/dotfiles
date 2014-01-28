export BLOCKSIZE="K"
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESSOPEN="|lesspipe.sh %s"
export LESS="-R"

local prefix=${ZDOTDIR:-$HOME}/.zsh
[ -r $prefix/common/env ] && source $prefix/common/env
[ -r $prefix/os/$OSTYPE/env ] && source $prefix/os/$OSTYPE/env
[ -r $prefix/host/$HOSTNAME/env ] && source $prefix/host/$HOSTNAME/env
unset prefix

alias alias=:
