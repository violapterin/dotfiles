#!/usr/bin/env bash

# Filename: run-xelatex.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.tex` (xeLaTeX) file as `.pdf`
# Requirement: having assumed script `xelatex` and engine `pdftex`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# The engine `pdflatex` exports LaTeX as PDF. As I have tested,
# `pdflatex` does not allow any `%` (percent) or `"` (double quote)
# in filename. All other Bash-reserved characters must be escaped,
# as usually the case for executables.
# Like: `draft (2016).tex` is passed as `draft\ \(2016\).tex`.
COMPILER="xelatex"
EXT_BIN=".pdf"

# To check arguments, and compile.
DIR_REPO="${HOME}/templates_configs_scripts"
DIR_SCRIPTS="${DIR_REPO}/scripts"

# `full_name_src` and `bare_name_bin` will be defined:
full_name_src=
bare_name_bin=
source "${DIR_SCRIPTS}/parse_src_bin_name.sh"

# `xelatex` options:
# -synctex=1`: Let PDF not contain info for looking up source.
# -interaction=nonstopmode`: Do not stop on error, but echo.
# -output-format=pdf`: Specify output format.
# -file-line-error`: Print filename and line number where error is.
options=(
      "-synctex=1"
      "-interaction=nonstopmode"
      "-jobname=${bare_name_bin}"
      "-file-line-error"
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${COMPILER}" ${options[*]} "${full_name_src}"
{ set +x; } 2>/dev/null
