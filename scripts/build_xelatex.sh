#! /usr/bin/env bash

# Filename: build_xelatex.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export all `.tex` (LaTeX) file as `.pdf`, using `xelatex`
# Requirement: See the called script `run_xelatex.sh`
# Usage: `run_xelatex.sh <latex_source>`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
FULL_MAKER="share_tex_family.sh"
FULL_PROGRAM="run_xelatex.sh"

source "${DIR_SCRIPTS}/${FULL_MAKER}"
