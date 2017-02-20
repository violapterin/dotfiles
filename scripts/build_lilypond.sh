#!/usr/bin/env bash

# Filename: build_lilypond.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.ly` (LilyPond) files into `.pdf`,
#    and generate `.midi` and `.mp3` too.
# Requirement: that the TeX engine specified be installed

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To specify location of program.
# Note that `NAME_PRG` must be specified in advance!
DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
FULL_PRG="${DIR_SCRIPTS}/${NAME_PRG}"

# Define the dependency-checking function.
NAME_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${NAME_FUN_DEF}"

# To delete binary files.
RM="rm -f"

# extensions resp. of souce and binary files
EXT_SRC=".tex"
EXT_BIN=".pdf"

# To set the LaTeX source files in the top directory,
# or in a subfolder, or in a subsubfolder.
list_src=$(find . -name "*${EXT_SRC}")

# Partial derivative, indicating fragmentary work.
FRAGMENT="∂"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

for dir_full_name_src in ${list_src}
do
   # If `src` is `foo.bar.baz`, `bare_name_common` is `foo`.
   full_name_src="$(basename ${dir_full_name_src})"
   dir="$(dirname ${dir_full_name_src})"
   bare_name_common="${full_name_src%%.*}"
   # Name the corresponding binary the same as directory.
   full_name_bin="${bare_name_common}${EXT_BIN}"

   # Ignore `∂`-prefixed (unfinished) files.
   if [ "${full_name_src:0:1}" == "${FRAGMENT}" ]; then
      continue
   fi

   # Check timestamp according to dependency.
   whether_make=$(resp_old_new "${dir_full_name_src}" "${dir}/${full_name_bin}")
   if [ "${whether_make}" == "TRUE" ]; then
      continue
   fi

   # Compilation of the binary file.
   echo "Compiling ${full_name_bin} from ${full_name_src} ..."
   "${FULL_PRG}" "${dir_full_name_src}" "${bare_name_common}"

   last_dir="$(basename ${dir})"
   mv "${full_name_bin}" "${dir}/${last_dir}${EXT_BIN}"
done

