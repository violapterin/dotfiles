#! /usr/bin/env bash

# Filename: build_lualatex.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export all `.tex` (LaTeX) file as `.pdf`, using `lualatex`.
# Requirement: See the called script `run_lualatex.sh`.
# Usage: Run this, with working directory containing several project
#    directories, each of them intended to be compiled.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
FULL_MAKER="share_tex_family.sh"
FULL_PROGRAM="run_lualatex.sh"

source "${DIR_SCRIPTS}/${FULL_MAKER}"
