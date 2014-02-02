# kbd plugin

This plugin configures the ZLE key bindings for the current terminal. Either the terminfo(5) database or zkbd can be used to look up the codes for each key.

## Configuration
By default, the kbd plugin looks up the key codes in the terminfo(5) database. This can be overriden by setting the variable `$KBD_CONFIG_METHOD` to "zkbd" in your ~/.zshrc file.

The actual bindings from key (names) to ZLE functions are read from the file referenced by the variable `$KBD_BINDINGS_FILE`, each line containing the name of a key and a ZLE function separated by a space.

Example:
``
Up history-substring-search-up
Down history-substring-search-down
``
