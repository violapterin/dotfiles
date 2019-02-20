# `~/.profile` is loaded by every interactive login shell when starting.

# To define environment variables.
CLOUD="/home/aminopterin/Dropbox"
export CLOUD
PATH="${PATH}:${CLOUD}/code_repos/scripts/bash"
export PATH
PYTHONPATH="${CLOUD}/code_repos/scripts/python"
export PYTHONPATH
OSFONTDIR="/usr/share/fonts"
export OSFONTDIR

# To set NeoVim as the default editor, such as Git commit logs.
VISUAL="nvim"
export VISUAL
EDITOR="${VISUAL}"
export EDITOR

# To prompt current username, time in minutes,
# and current directory (not full path).
PS1="\[\033[1;32m\]\u\[\033[1;34m\][\A]\[\033[1;31m\]@\W\[\033[1;37m\]$ \[\033[0;37m\]"
export PS1

# To specify color settings used by `ls` ("list") display.
LSCOLORS="di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90"
export LSCOLORS

