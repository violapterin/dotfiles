#!/usr/bin/env bash

# Filename: build_markdown.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export all `.md` (Markdown) files inside current directory as `.pdf`.
# Usage: `build_markdown.sh <markdown_source>`
# Requirement: That `pandoc` and `xelatex` be installed.
# Variable(s) defined in advance: `DIR_TOP`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# `DIR_TOP` should contain several (standalone) Markdown files,
# each of them intended to be compiled.

# To specify location of program.
FULL_PROGRAM="run_pandoc.sh"
DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
PATH_FULL_PROGRAM="${DIR_SCRIPTS}/${FULL_PROGRAM}"

# Define the dependency-checking function.
FULL_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${FULL_FUN_DEF}"

# To delete binary files.
DELETE="rm"
OPT_DELETE="-f"

# extensions resp. of souce and binary files
EXT_SRC=".md"
EXT_GRPH=".pdf"

# To set the Markdown sources inside current working directory.
list_global_path_full_src=$(find "${DIR_TOP}" -name "*${EXT_SRC}")

# Partial derivative, indicating fragmentary work.
FRAGMENT="∂"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

if [[ "$#" -gt 1 ]]
then
   echo "Too many arguments. 0 or 1 expected, $# present. Stop." > /dev/stderr
   exit 1

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To clean binary files.
elif [[ "$#" -eq 1 ]]
then
   if [[ "$1" == "clean" ]]
      # For every Markdown source, compile PDF in the same place.
      for path_full_src_dm in ${list_global_path_full_src}
      do
         # See the next section for more comments.
         dir=$(dirname "${path_full_src_dm}")
         full_src="$(basename ${path_full_src_dm})"
         bare_common="${full_src%%.*}"
         full_bin="${bare_common}${EXT_GRPH}"
         path_full_bin="${dir}/${full_bin}"

         "${DELETE}" "${OPT_DELETE}" "${path_full_bin}"
      done
      exit 0

   else
      echo "Argument $1 not recognized. Stop." > /dev/stderr
      exit 1
   fi
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Otherwise, no argument present.
# For every Markdown source, compile PDF in the same place.
for path_full_src_dm in ${list_global_path_full_src}
do
   # If `src` is `foo.bar.baz`, `bare_common` is `foo`.
   dir=$(dirname "${path_full_src_dm}")
   full_src="$(basename ${path_full_src_dm})"
   bare_common="${full_src%%.*}"

   # Name the corresponding binary the same as according source.
   full_bin="${bare_common}${EXT_GRPH}"
   path_full_bin="${dir}/${full_bin}"

   # Ignore `∂`-prefixed (unfinished) files.
   if [[ "${full_src:0:1}" == "${FRAGMENT}" ]]
   then
      continue
   fi

   # Check timestamp according to dependency.
   whether_make="FALSE"
   hold=$(resp_old_new "${path_full_src}" "${path_full_bin}")
   if [[ "${hold}" == "FALSE" ]]
   then
      "${whether_make}"="TRUE"
   fi

   if [[ "${whether_make}" == "TRUE" ]]
   then
      echo "Compiling ${full_bin} from ${full_src} ..."
      set -x
      "${PATH_FULL_PROGRAM}" "${path_full_src}" "${path_full_bin}"
      { set +x; } 2>/dev/null
   fi
done
