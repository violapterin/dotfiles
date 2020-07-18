# `~/.bashrc` is loaded by an interactive non-login bash shell.

# To do nothing if not running interactively.
[[ $- != *i* ]] && return

# To load `.profile`, if it exists.
[ -r ~/.profile ] && source ~/.profile

# Command-line completion resp. using up and down arrow keys.
bind "\"\e[A\": history-search-backward"
bind "\"\e[B\": history-search-forward"

# To ignore case in completing commands.
bind "set completion-ignore-case On"

# To initialize the `bash-completion` package.
source /usr/share/bash-completion/bash_completion

# `-P`: to always expand a symlink.
alias cd="cd -P"

# `-G`: to enable colorized output;
# `-F`: to display a slash;
# `-h`: to use human readable format, e.g. KB, MB, GB,...;
# `-l`: to use long format, including permissions and date modified;
# `-a`: to display hidden files, say `.gitignore`.
alias ls="ls -GFh --color"
alias Ls="ls -alGFh --color"

# Print disk usage.
alias Du="du -shc * | sort -hr"

# To edit with neovim.
alias V="nvim"

# To clear output.
alias C="clear"

