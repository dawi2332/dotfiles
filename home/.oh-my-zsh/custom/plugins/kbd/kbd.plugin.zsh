# kbd plugin for oh-my-zsh by David Winter <dawi2332@gmail.com>

kbd_plugin_dir=$(dirname "$0")

# Create zkbd configuration file using zkbd function.
kbd_zkbd_setup() {
    echo "Failed to read your zkbd key settings from $1."
    if read -q \?"Would you like to set up zkbd for this terminal? (y/n) "; then
        # zkbd assumes that $DISPLAY can be used safely as part of a
        # filename when initially recording the keybindings. That's not
        # always the case so we need to 'fix' it here if necessary.
        local old_display=$DISPLAY
        export DISPLAY=${DISPLAY#${DISPLAY%:[0-9]*}}
        echo
        autoload zkbd && zkbd
        export DISPLAY=$old_display
    fi
}

# Load key codes from zkbd configuration file.
kbd_zkbd() {
    local zkbd_keyfile=${ZDOTDIR}/.zkbd/$TERM-${${DISPLAY#${DISPLAY%:[0-9]*}}:-$VENDOR-$OSTYPE}
    if [[ ! -f $zkbd_keyfile ]]; then
        kbd_zkbd_setup $zkbd_keyfile
    fi
    source $zkbd_keyfile
}

# Look up key codes in terminfo database.
kbd_terminfo() {
    zmodload zsh/terminfo
    typeset -g -A key
    key[F1]=${terminfo[kf1]}
    key[F2]=${terminfo[kf2]}
    key[F3]=${terminfo[kf3]}
    key[F4]=${terminfo[kf4]}
    key[F5]=${terminfo[kf5]}
    key[F6]=${terminfo[kf6]}
    key[F7]=${terminfo[kf7]}
    key[F8]=${terminfo[kf8]}
    key[F9]=${terminfo[kf9]}
    key[F10]=${terminfo[kf10]}
    key[F11]=${terminfo[kf11]}
    key[F12]=${terminfo[kf12]}
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
    # Any ideas what to map this to?
    key[Menu]=

    # When the terminal has smkx and rmkx capabilities, set-up appropriate
    # functions for ZLE to put the terminal into "application mode".
    if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        function zle-line-init () {
            echoti smkx
        }
        function zle-line-finish () {
            echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
    fi
}

# Default key bindings.
kbd_defaults() {
    kbd_load_file $kbd_plugin_dir/kbd-bindings.default
}

kbd_bindkeys() {
    local bindings_file=${KBD_BINDINGS_FILE:-$ZDOTDIR/.zsh/kbd-bindings}
    kbd_load_file $bindings_file
}

kbd_load_file() {
    local file=$1
    if [[ -r $file ]]; then
        while read k b; do
            [[ -n ${key[$k]} ]] && bindkey "${key[$k]}" $b
        done < $file
    fi
}

kbd_init() {
    case $KBD_CONFIG_METHOD in
        zkbd)
            kbd_zkbd
            ;;
        terminfo|*)
            kbd_terminfo
            ;;
    esac

    kbd_defaults
    kbd_bindkeys
    unset key
}

kbd_init
