# Filename: .bashrc
# Author: Tzu-Yu Jeng
# Date: mostly late 2016
# Description: An interactive non-login shell loads this file.
# Requirement: That it be saved in user's home, and included in `.bash_profile`.

# # # # # # # # Settings, exportation, sourcing # # # # # # # # 

# To define environment variables.
export DOC="/Users/amino/Documents"
export PATH="${PATH}:${DOC}/code_repos/scripts/bash"
export PYTHONPATH="${PYTHONPATH}:${DOC}/code_repos/scripts/python"

# To set MacVim as the default editor, such as Git commit logs.
export VISUAL="mvim -v"
export EDITOR="${VISUAL}"

# To compile LilyPond `.ly` file.
export LilyPond="/Applications/LilyPond.app/Contents/Resources/bin/lilypond"

# Command-line completion resp. using up and down arrow keys.
bind "\"\e[A\": history-search-backward"
bind "\"\e[B\": history-search-forward"

# To ignore case in completing commands.
bind "set completion-ignore-case On"

# Initialize the `bash-completion` package.
# (Install with `brew install bash-completion`.)
source /usr/local/etc/bash_completion

# # # # # # # # Display of color # # # # # # # # 

# To prompt current username, time in minutes,
# and current directory (not full path).
export PS1="\[\033[1;32m\]\u\[\033[1;34m\][\A]\[\033[1;31m\]@\W\[\033[1;37m\]$ \[\033[0;37m\]"

# To enable color in command line interface.
export CLICOLOR=1

# To specify color settings used by `ls` ("list") display.
export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"

# # # # # # # # File management # # # # # # # #

# When changing directory, always expand a symlink.
alias cd="cd -P"

# `ls` for hidden & short form; `Ls` unhidden & long form;
# `-G`: to enable colorized output;
# `-F`: to display a slash;
# `-h`: to use human readable format, e.g. KB, MB, GB,...;
# `-l`: to use long format, including permissions and date modified;
# `-a`: to display hidden files, say `.DS_Store`
alias ls="ls -GFh"
alias Ls="ls -alGFh"

# Disk usage
alias Du="du -shc * | gsort -hr"

# To show hidden files in Mac `Finder.app`.
alias ShowFiles="defaults write com.apple.finder AppleShowAllFiles YES"
# To show hidden files in Mac `Finder.app`.
alias HideFiles="defaults write com.apple.finder AppleShowAllFiles NO"

# # # # # # # # Other aliases for applications # # # # # # # #

# `cd` (change directory) shortcuts.
# Double quotes ensures they are passed as a single token.
alias ToEssays="cd \"${DOC}/essays_vol_8\""
alias ToAllFairCopies="cd \"${DOC}/all_fair_copies\""
alias ToLilypondWork="cd \"${DOC}/LilyPond_work\""
alias ToLatexWork="cd \"${DOC}/LaTeX_work\""
alias ToPrograms="cd \"${DOC}/code_repos\""
alias ToBooks="cd \"${DOC}/books\""

# To open with MacVim embedded in the terminal.
alias Vim="mvim -v"

# To browse PTT.
alias BrowsePtt="ssh bbsu@ptt.cc"
# To browse PTT2.
alias BrowsePtt2="ssh bbsu@ptt2.cc"

