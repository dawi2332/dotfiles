# kbd plugin

This plugin configures the ZLE key bindings for the current terminal.

Instead of binding a ZLE function to a key sequence, it's bound to a key name and either the terminfo(5) database or zsh's zkbd function is used to look up the actual key sequence.

## Configuration

By default, the kbd plugin looks up the key codes in the terminfo(5) database. This can be overriden by setting the variable `$KBD_CONFIG_METHOD` to "zkbd" in your .zshrc file.

The actual bindings from key names to ZLE functions are read from the file $ZDOTDIR/.zsh/kbd-bindings or - if set - by the file referenced by the variable `$KBD_BINDINGS_FILE`.

Before loading user-defined key bindings, a set of default key bindings is loaded.

### Syntax:

One key binding per line containing the name of the key (as used by zkbd) and the ZLE function, separated by a space.

### Example:

	Up history-substring-search-up
	Down history-substring-search-down
