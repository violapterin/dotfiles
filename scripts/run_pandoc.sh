#!/usr/bin/env bash

# Filename: run-pandoc.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.md` (Markdown) file as `.pdf`
# Requirement: having assumed library `pandoc` and script `xelatex`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# The library `pandoc` exports, here, Markdown to LaTeX then to PDF.
# (`pandoc` seems to allow any character valid in Mac filename.)
COMPILER="pandoc"
EXT_BIN=".pdf"

# To check arguments, and compile.
DIR_REPO="${HOME}/templates_configs_scripts"
DIR_SCRIPTS="${DIR_REPO}/scripts"
SOURCE_NAME="parse_src_bin_name.sh"
source "${DIR_SCRIPTS}/${SOURCE_NAME}"

# Location of template for `pandoc`
ENGINE="xelatex"
TEMPLATE_PANDOC="${DIR_REPO}/tex_templates/template_pandoc.tex"

# `pandoc` options:
# `--standalone`: Output a single file,
# `--output`: Set output filename,
# `--template`: Called custom template for compiler's use,
# `--latex-engine`: Set LaTeX compiler.
options=(
      "--standalone"
      "--output=${bare_name_bin}${EXT_BIN}"
      "--template=${TEMPLATE_PANDOC}"
      "--latex-engine=${ENGINE}"
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${COMPILER}" ${options[*]} "${full_name_src}"
{ set +x; } 2>/dev/null
