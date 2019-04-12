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
# `-a`: to display hidden files, say `.gitignore`
alias ls="ls -GFh --color"
alias Ls="ls -alGFh --color"

# Disk usage
alias Du="du -shc * | sort -hr"

# Double quotes ensures them to be passed properly.
alias Cd_music="cd \"${CLOUD}/music_composition\""
alias Cd_science="cd \"${CLOUD}/science_work\""
alias Cd_prog="cd \"${CLOUD}/computer_programs\""
alias Cd_books="cd \"${CLOUD}/library/books\""
alias Cd_papers="cd \"${CLOUD}/library/books\""
alias Cd_desktop="cd \"${HOME}/Desktop\""

# To browse PTT.
alias Browse_PTT="ssh bbsu@ptt.cc"
# To browse PTT2.
alias Browse_Ptt2="ssh bbsu@ptt2.cc"

# To edit with neovim.
alias V="nvim"

