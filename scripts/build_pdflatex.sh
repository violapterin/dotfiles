#! /usr/bin/env bash

# Filename: build_pdflatex.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export all `.tex` (LaTeX) file as `.pdf`, using `pdflatex`.
# Requirement: See the called script `run_pdflatex.sh`.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
FULL_MAKER="share_tex_family.sh"
FULL_PROGRAM="run_pdflatex.sh"

source "${DIR_SCRIPTS}/${FULL_MAKER}"
