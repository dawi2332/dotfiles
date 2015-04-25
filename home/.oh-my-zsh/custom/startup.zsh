zsh-startup rc

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

for file in $ZDOTDIR/.zsh/env.d/*(N-.x:t); . $ZDOTDIR/.zsh/env.d/$file

# vim: ft=zsh ts=8 st=4 sts=4 et
