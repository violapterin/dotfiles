# `~/.profile` is loaded by every interactive login shell when starting.

# To set the default editor.
VISUAL="nvim"
export VISUAL
EDITOR="${VISUAL}"
export EDITOR

# To prompt current username, time in minutes,
# and current directory (not full path).
PS1="\[\033[1;32m\]\u\[\033[1;34m\][\A]\[\033[1;31m\]@\W\[\033[1;37m\]$ \[\033[0;37m\]"
export PS1

# To specify color settings used by `ls`.
LSCOLORS="di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90"
export LSCOLORS


export PATH="$HOME/.cargo/bin:$PATH"
