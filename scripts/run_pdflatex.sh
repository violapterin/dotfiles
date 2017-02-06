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

# the main command
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${COMPILER}" ${options[*]} "${name_src}"
{ set +x; } 2>/dev/null
