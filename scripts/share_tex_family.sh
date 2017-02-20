#!/usr/bin/env bash

# Filename: share_tex_family.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export all `.tex` (TeX family) files into `.pdf`;
#    This file will be source by each TeX-compiling scripts.
# Requirement: that the TeX engine specified be installed

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To specify location of program.
# Note that `NAME_PRG` must be specified in advance!
DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
FULL_PRG="${DIR_REPO}/${NAME_PRG}"

# Define the dependency-checking function.
NAME_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${NAME_FUN_DEF}"

# To delete binary files.
RM="rm -f"

# extensions resp. of souce and binary files
EXT_SRC=".tex"
EXT_BIN=".pdf"

# To set the Markdown source files in the top directory,
# or in a subfolder, or in a subsubfolder.
SRC="*$(EXT_SRC) */*$(EXT_SRC) */*/*$(EXT_SRC)"

# Partial derivative, indicating unfinished work.
PARTIAL="∂"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

for src in ${SRC}
do
   # Basename of the containing directory.
   jobname="$(basename $(dirname ${src}))"
   # Name the corresponding binary the same as directory.
   bin="${src//${EXT_SRC}/${EXT_BIN}}"

   # Ignore `∂`-prefixed (unfinished) files.
   if [ "${src:0:1}" -eq "${PARTIAL}" ]; then
      continue
   fi

   # Check timestamp according to dependency.
   if [ $(resp_old_new "${src}" "${bin}") -eq "TRUE" ]; then
      continue
   fi

   # Compilation of the binary file.
   echo "Compiling ${bin} from ${src} ..."
   "${FULL_PRG}" "${src}" "${jobname}"
done

