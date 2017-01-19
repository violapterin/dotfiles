#!/usr/bin/env bash

# filename: run-pdflatex.sh
# author: Tzu-Yu Jeng
# date: Jan. 2017
# description: to export `.tex` (LaTeX) file as `.pdf`
# requirement: having assumed script `pdflatex` and engine `pdftex`

# The engine `pdflatex` exports LaTeX as PDF.
program='pdflatex'

# As I have tested, `pdflatex` does not allow any
# `%` (percent) or `"` (double quote) in filename.
# Other all Bash-reserved characters must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).tex` is passed as `draft\ \(2016\).tex`.
nameSrc="$1"

# Despite being read into Bash, it's still necessary to escape
# Bash-reserved characters, just as if being entered literally.
nameSrc=$(printf '%q' "${nameSrc}")

# `pdflatex` options:
#  -synctex=1`: Let PDF not contain info about source position's lookup.
#  -interaction=nonstopmode`: Do not stop on error, but echo error message.
#  -output-format=pdf`: Specify output format.
#  -file-line-error`: Print filename and line number where error is.
options=(
      -synctex=0
      -interaction=nonstopmode
      -output-format=pdf
      -file-line-error
)

# The full line of command
command="${program} ${options[*]} ${nameSrc}"
echo ${command} # first print it
eval ${command} # then evaluate it


