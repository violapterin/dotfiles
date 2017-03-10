#!/usr/bin/env bash

# Filename: run_pandoc.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export `.md` (Markdown) file as `.pdf`.
# Requirement: That library `pandoc`, script `xelatex`, and engine `xetex` be installed.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# The library `pandoc` exports, here, Markdown to LaTeX then to PDF.
# (`pandoc` seems to allow any character valid in Mac filename.)
COMPILER="pandoc"
EXT_BIN=".pdf"

# To check arguments, and compile.
DIR_REPO="${HOME}/templates_configs_scripts"
DIR_SCRIPTS="${DIR_REPO}/scripts"
DIR_TEMPLATES="${DIR_REPO}/tex_templates"

# `full_src` and `bare_bin` will be defined:
full_src=
bare_bin=
source "${DIR_SCRIPTS}/parse_src_bin_name.sh"

# Location of template for `pandoc`
ENGINE="xelatex"
TEMPLATE_PANDOC="${DIR_TEMPLATES}/template_pandoc.tex"

# `pandoc` options:
# `--standalone`: Output a single file,
# `--output`: Set output filename,
# `--template`: Called custom template for compiler's use,
# `--latex-engine`: Set LaTeX compiler.
options=(
      "--standalone"
      "--output=${bare_bin}${EXT_BIN}"
      "--template=${TEMPLATE_PANDOC}"
      "--latex-engine=${ENGINE}"
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${COMPILER}" ${options[*]} "${full_src}"
{ set +x; } 2>/dev/null
