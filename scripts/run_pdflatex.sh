#!/usr/bin/env bash

# Filename: run-pdflatex.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.tex` (LaTeX) file as `.pdf`
# Requirement: having assumed script `pdflatex` and engine `pdftex`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# The engine `pdflatex` exports LaTeX as PDF.
# As I have tested, `pdflatex` does not allow any
# `%` (percent) or `"` (double quote) in filename.
# Other all Bash-reserved characters must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).tex` is passed as `draft\ \(2016\).tex`.
COMPILER="pdflatex"
EXT_BIN=".pdf"

# To check arguments, and compile. Now defining `full_name_src ` and `bare_name_bin`.
DIR_REPO="${HOME}/templates_configs_scripts"
DIR_SCRIPTS="${DIR_REPO}/scripts"
SOURCE_NAME="parse_src_bin_name.sh"
source "${DIR_SCRIPTS}/${SOURCE_NAME}"

# `pdflatex` options:
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
