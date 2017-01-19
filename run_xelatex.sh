#!/usr/bin/env bash

# filename: run-xelatex.sh
# author: Tzu-Yu Jeng
# date: Jan. 2017
# description: to export `.tex` (xeLaTeX) file as `.pdf`
# requirement: having assumed script `xelatex` and engine `pdftex`

# The engine `xelatex` exports xeLaTeX as PDF.
program='xelatex'

# As I have tested, `xelatex` only disallow `%` (percent) in filename.
# Other Bash-reserved characters are okay, but must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).tex` is passed as `draft\ \(2016\).tex`.
nameSrc="$1"

# Despite being read into Bash, it's still necessary to escape
# Bash-reserved characters, just as if being entered literally.
nameSrc=$(printf '%q' "${nameSrc}")

# `xelatex` options:
#  -synctex=1`: Let PDF not contain info about source position's lookup.
#  -interaction=nonstopmode`: Do not stop on error, but echo error message.
#  -output-format=pdf`: Specify output format.
#  -file-line-error`: Print filename and line number where error is.
options=(
      -synctex=0
      -interaction=nonstopmode
      -file-line-error
)

# The full line of command
command="${program} ${options[*]} ${nameSrc}"
echo ${command} # first print it
eval ${command} # then evaluate it


