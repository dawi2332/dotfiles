# David Winter <dawi2332@gmail.com>

zkbd_setup() {
    echo "Failed to read your zkbd key settings from $1."
    if read -q \?"Would you like to set up zkbd for this terminal? (y/n) "
    then
        # zkbd assumes that $DISPLAY can be used safely as part of a
        # filename when initially recording the keybindings. That's not
        # always the case so we need to 'fix' it here if necessary.
        local old_display=$DISPLAY
        export DISPLAY=${DISPLAY#${DISPLAY%:[0-9]*}}
        echo
        autoload zkbd && zkbd
        export DISPLAY=$old_display
        unset $old_display
    fi
}

zkbd_init() {
    local zkbd_keyfile=${ZDOTDIR}/.zkbd/$TERM-${${DISPLAY#${DISPLAY%:[0-9]*}}:-$VENDOR-$OSTYPE}
    if [[ ! -f $zkbd_keyfile ]]
    then
        zkbd_setup $zkbd_keyfile
    fi
    source $zkbd_keyfile
    unset $zkbd_keyfile
}

zle-line-init() {
    echoti smkx
}

zle-line-finish() {
    echoti rmkx
}

terminfo_init() {
    typeset -g -A key
    key[Backspace]=${terminfo[kbs]}
    key[Insert]=${terminfo[kich1]}
    key[Home]=${terminfo[khome]}
    key[PageUp]=${terminfo[kpp]}
    key[Delete]=${terminfo[kdch1]}
    key[End]=${terminfo[kend]}
    key[PageDown]=${terminfo[knp]}
    key[Up]=${terminfo[kcuu1]}
    key[Down]=${terminfo[kcud1]}
    key[Left]=${terminfo[kcub1]}
    key[Right]=${terminfo[kcuf1]}

    zle -N zle-line-init
    zle -N zle-line-finish
}

default_keybindings() {
    [[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
    [[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
    [[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
    [[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
    [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
    [[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
    [[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
    [[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
    [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
    [[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
    [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
}

bindkeys() {
    bindings_file=${KBD_BINDINGS_FILE:-$ZDOTDIR/.zsh/kbd-bindings}
    if [[ -r $bindings_file ]]
    then
        while read k b
        do
            [[ -n ${key[$k]} ]] && bindkey "${key[$k]}" $b
        done < $bindings_file
        unset k b
    else
        default_keybindings
    fi
}

case $KBD_CONFIG_METHOD in
    zkbd)
        zkbd_init
        ;;
    terminfo|*)
        terminfo_init
        ;;
esac

bindkeys
unset key
