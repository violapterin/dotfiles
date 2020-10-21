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

# for Ruby
export GEM_HOME="${HOME}/gems"
export PATH="${HOME}/gems/bin:${PATH}"
# for Rust
export PATH="${HOME}/.cargo/bin:${PATH}"
# for ConTeXt
export OSFONTDIR="${HOME}/.fonts:/usr/share/fonts"
export TEXROOT="/usr/local/context/tex"
export PATH="/usr/local/context/tex/texmf-linux-64/bin:/usr/local/context/bin:${PATH}"
