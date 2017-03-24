#! /usr/bin/env bash

# Filename: build_pdflatex.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To compile PDF document of several LaTeX projects using `pdflatex`.
# Requirement: See the called script `run_pdflatex.sh`.
# Variable(s) defined in advance: `DIR_TOP`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# `DIR_TOP` should contain several LaTeX project directories
# that are intended to be compiled, and has a `main.tex` in it.

DIR_SCRIPTS="/Users/amino/templates_configs_scripts/scripts"
FULL_MAKER="share_tex_family.sh"
FULL_PROGRAM="run_pdflatex.sh"

source "${DIR_SCRIPTS}/${FULL_MAKER}"
