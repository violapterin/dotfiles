#!/usr/bin/env bash

# Filename: run-pdflatex.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.tex` (LaTeX) file as `.pdf`
# Requirement: having assumed script `pdflatex` and engine `pdftex`

# The engine `pdflatex` exports LaTeX as PDF.
COMPILER="pdflatex"

# As I have tested, `pdflatex` does not allow any
# `%` (percent) or `"` (double quote) in filename.
# Other all Bash-reserved characters must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).tex` is passed as `draft\ \(2016\).tex`.
name_src="$1"

# `pdflatex` options:
# -synctex=1`: Let PDF not contain info for looking up source.
# -interaction=nonstopmode`: Do not stop on error, but echo.
# -output-format=pdf`: Specify output format.
# -file-line-error`: Print filename and line number where error is.
options=(
      -synctex=0
      -interaction=nonstopmode
      -output-format=pdf
      -file-line-error
)

# To check argument, then run main commands.
# `set -x` echoes what is executed; `set +x` cancels this.
if [ "$#" -eq 0 ]; then
   echo "No arguments supplied. 1 or 2 expected, 0 present. Stop."
   exit 1
elif [ "$#" -gt 3 ]; then
   echo "Too many arguments. 1 or 2 expected, $# present. Stop."
   exit 1
elif [ "$#" -eq 1 ]; then
   # the main command
   # `set -x` echoes what is executed; `set +x` cancels this.
   set -x
   "${COMPILER}" ${options[*]} "${name_src}"
   { set +x; } 2>/dev/null
elif [ "$#" -eq 2 ]; then
   set -x
   "${COMPILER}" ${options[*]} "-jobname=$2" "${name_src}"
   { set +x; } 2>/dev/null
fi
