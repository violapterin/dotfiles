#!/usr/bin/env bash

# Filename: build_markdown.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export all `.md` (Markdown) files into `.pdf`.
# Requirement: That `pandoc` and `xelatex` be installed.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To specify location of program.
# Note: `FULL` and `DIR_TOP` must be specified in advance!
DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
PATH_FULL_PROGRAM="${DIR_SCRIPTS}/${FULL_PROGRAM}"

# Define the dependency-checking function.
FULL_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${FULL_FUN_DEF}"

# To delete binary files.
DELETE="rm -f"

# extensions resp. of souce and binary files
EXT_SRC=".md"
EXT_BIN=".pdf"

# To set the Markdown sources inside current working directory.
list_global_src=$(find . -name "*${EXT_SRC}")

# Partial derivative, indicating fragmentary work.
FRAGMENT="∂"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

if [[ "$#" -gt 1 ]]
then
   echo "Too many arguments. 0 or 1 expected, $# present. Stop." > /dev/stderr
   exit 1

elif [[ "$#" -eq 1 ]]
then
   if [[ "$1" -eq "clean" ]]
      "${DELETE}" 
   else
      echo "Argument $1 not recognized. Stop." > /dev/stderr
      exit 1
   fi

# No argument present.
elif
then
   # For every Markdown source, compile PDF in the same place.
   for dir_full_src in ${list_global_src}
   do
      # If `src` is `foo.bar.baz`, `bare_common` is `foo`.
      dir="$(dirname ${dir_full_src})"
      cd "${dir}"
      full_src="$(basename ${dir_full_src})"
      bare_common="${full_src%%.*}"

      # Name the corresponding binary the same as according source.
      full_bin="${bare_common}${EXT_BIN}"
      dir_full_bin="${dir}/${full_bin}"

      # Ignore `∂`-prefixed (unfinished) files.
      if [[ "${full_src:0:1}" == "${FRAGMENT}" ]]
      then
         continue
      fi

      # Check timestamp according to dependency.
      hold="$(resp_old_new "${dir_full_src}" "${dir_full_bin}")"
      if [[ "${hold}" == "TRUE" ]]
      then
         continue
      fi

      # Compilation of the binary file.
      echo "Compiling ${full_bin} from ${full_src} ..."
      set -x
      "${FULL_PRG}" "${dir_full_src}" "${bare_common}"
      { set +x; } 2>/dev/null
   done
fi
