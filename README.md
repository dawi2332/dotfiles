zsh-dotfiles
============
If you haven't guessed by now, yes, those are my dotfiles for ZSH.
Requires [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), works best with [homesick](https://github.com/technicalpickles/homesick).

zsh-startup Function
------------------------------
zsh-startup is a small function I wrote to put additional stuff into .zshenv, .zshrc and friends, depending on the OS or the name of the machine without cluttering those files with dozens of `if` or `case` statements.

### Syntax:

    zsh-startup FILENAME...

It will try to locate the given filename(s) in the directories common, os/$OSTYPE, host/$HOST below ~/.zsh and source them.

### Example:
`zsh-startup rc` will first source ~/.zsh/common/rc, then ~/.zsh/os/$OSTYPE/rc and finally ~/.zsh/host/$HOST/rc. As the filename "rc" implies, those files contain my additions to .zshrc. Note that `zsh-startup rc` is no longer being called at the end of .zshrc but has been moved to ~/.oh-my-zsh/custom/startup.zsh, in order to reduce the amount of merging needed to keep my .zshrc in sync with oh-my-zsh's template. 
