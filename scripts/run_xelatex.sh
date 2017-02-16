#!/usr/bin/env bash

# Filename: run-xelatex.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.tex` (xeLaTeX) file as `.pdf`
# Requirement: having assumed script `xelatex` and engine `pdftex`

# To check arguments.
this_dir=$(dirname "$0")
source "${this_dir}/check_arguments.sh"

# The engine `xelatex` exports xeLaTeX as PDF.
# As I have tested, `xelatex` only disallow `%` (percent) in filename.
# Other Bash-reserved characters are okay, but must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).tex` is passed as `draft\ \(2016\).tex`.
COMPILER="xelatex"
EXT_BIN=".pdf"

# To check arguments, and compile.
this_dir=$(dirname "$0")
source "${this_dir}/check_arguments.sh"

# `xelatex` options:
# -synctex=1`: Let PDF not contain info for looking up source.
# -interaction=nonstopmode`: Do not stop on error, but echo.
# -output-format=pdf`: Specify output format.
# -file-line-error`: Print filename and line number where error is.
options=(
      -synctex=1
      -interaction=nonstopmode
      -jobname="${basename_bin}"
      -output-format=pdf
      -file-line-error
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${COMPILER}" ${options[*]} "${name_src}"
{ set +x; } 2>/dev/null
