# Filename: .bashrc
# Author: Tzu-Yu Jeng
# Date: mostly late 2016
# Description: An interactive non-login shell loads this file.
# Requirement: That it be saved in user's home, and included in `.bash_profile`.

# Do nothing if not running interactively.
[[ $- != *i* ]] && return

# # # # # # # # Settings, exportation, sourcing # # # # # # # # 

# To define environment variables.
export DOC="/home/aminopterin/Dropbox"
export PATH="${PATH}:${DOC}/code_repos/scripts/bash"
export PYTHONPATH="${PYTHONPATH}:${DOC}/code_repos/scripts/python"

# To set NeoVim as the default editor, such as Git commit logs.
export VISUAL="nvim"
export EDITOR="${VISUAL}"

# To compile LilyPond `.ly` file.
# export LilyPond="/Applications/LilyPond.app/Contents/Resources/bin/lilypond"

# Command-line completion resp. using up and down arrow keys.
bind "\"\e[A\": history-search-backward"
bind "\"\e[B\": history-search-forward"

# To ignore case in completing commands.
bind "set completion-ignore-case On"

# To initialize the `bash-completion` package.
source /usr/share/bash-completion/bash_completion

# # # # # # # # Display of color # # # # # # # # 

# To prompt current username, time in minutes,
# and current directory (not full path).
export PS1="\[\033[1;32m\]\u\[\033[1;34m\][\A]\[\033[1;31m\]@\W\[\033[1;37m\]$ \[\033[0;37m\]"

# To specify color settings used by `ls` ("list") display.
LSCOLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LSCOLORS

# # # # # # # # File management # # # # # # # #

# When changing directory, always expand a symlink.
alias cd="cd -P"

# `ls` for hidden & short form; `Ls` unhidden & long form;
# `-G`: to enable colorized output;
# `-F`: to display a slash;
# `-h`: to use human readable format, e.g. KB, MB, GB,...;
# `-l`: to use long format, including permissions and date modified;
# `-a`: to display hidden files, say `.gitignore`
alias ls="ls -GFh --color"
alias Ls="ls -alGFh --color"

# Disk usage
alias Du="du -shc * | gsort -hr"

# # # # # # # # Other aliases for applications # # # # # # # #

# `cd` (change directory) shortcuts.
# Double quotes ensures they are passed as a single token.
alias CdEssays="cd \"${DOC}/Chinese_writing/Chinese_essays/part_8_since_Jan_2017\""
alias CdArchive="cd \"${DOC}/Chinese_writing/authentic_archive\""
alias CdMusicWork="cd \"${DOC}/music_composition\""
alias CdScienceWork="cd \"${DOC}/science_work\""
alias CdPrograms="cd \"${DOC}/code_repos\""
alias CdBooks="cd \"${DOC}/books\""

# To browse PTT.
alias BrowsePtt="ssh bbsu@ptt.cc"
# To browse PTT2.
alias BrowsePtt2="ssh bbsu@ptt2.cc"

# To edit with neovim.
alias V="nvim"

