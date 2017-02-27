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
FULL_PRG="${DIR_SCRIPTS}/${NAME_PRG}"

# Define the dependency-checking function.
NAME_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${NAME_FUN_DEF}"

# To delete binary files.
RM="rm -f"

# Defined names of extensions resp. of souce and binary files.
# Compiler reads `main.tex`, & join sources as `standalone.tex`
EXT_SRC=".tex"
EXT_BIN=".pdf"
BARE_NAME_SRC_CHIEF="main"
BARE_NAME_SRC_ALL="standalone"
FULL_NAME_SRC_CHIEF=${BARE_NAME_SRC_CHIEF}${EXT_SRC}
FULL_NAME_SRC_ALL=${BARE_NAME_SRC_ALL}${EXT_SRC}

# To set the `main.tex` sources inside current working directory.
list_chief_src=$(find . -name "${FULL_NAME_SRC_CHIEF}")

# Partial derivative, indicating fragmentary work.
FRAGMENT="∂"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

for dir_full_name_chief_src in ${list_chief_src}
do
   dir="$(dirname ${dir_full_name_chief_src})"
   cd "${dir}"
   # To hold all sources in the current working directory.
   list_relavent_src=$(find . -name "*${EXT_SRC}")
   # To remove the `standalone.tex` generated from `main.tex`.
   # (If the replaced contains `/`, 1st delimiter is `//` instead of `/`)
   list_relavent_src="${list_relavent_src//.\/${FULL_NAME_SRC_CHIEF}/}"

   # Name the corresponding binary the same as directory.
   bare_name_bin="$(basename ${dir})"
   full_name_bin="${bare_name_bin}${EXT_BIN}"
   dir_full_name_bin="${dir}/${full_name_bin}"

   # Ignore `∂`-prefixed (unfinished) files.
   if [ "${full_name_src:0:1}" == "${FRAGMENT}" ]
   then
      continue
   fi

   # Check timestamp according to dependency.
   "${whether_make}" == "FALSE"
   for full_name_src in "${list_relavent_src}"
   do
      dir_full_name_src="${dir}${full_name_src}"
      hold="$(resp_old_new "${dir_full_name_src}" "${dir_full_name_bin}")"
      if [ "${hold}" == "FALSE" ]
      then
         whether_make="TRUE"
         break
      fi
   done
   if [ "${whether_make}" == "FALSE" ]
   then
      continue
   fi

   # Compilation of the binary file.
   echo "Compiling ${full_name_bin} from ${FULL_NAME_SRC_CHIEF} ..."
   "${FULL_PRG}" "${dir_full_name_src}" "${bare_name_bin}"

   # XXX: prepare `standalone.tex`
   # ${????} "${FULL_NAME_SRC_CHIEF}" "${FULL_NAME_SRC_ALL}"
done
