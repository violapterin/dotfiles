#!/usr/bin/env bash

# Filename: share_tex_family.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: 
# Requirement: That the relevant TeX engine specified be installed.
# Usage: This will be sourced by each TeX-making scripts.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To specify location of program.
# Note: `NAME_PROGRAM` and `DIR_TOP` must be specified in advance!
DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
PATH_FULL_PROGRAM="${DIR_SCRIPTS}/${NAME_PROGRAM}"

# Define the dependency-checking function.
FULL_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${FULL_FUN_DEF}"

# To delete binary files.
RM="rm -f"

# Defined names of extensions resp. of souce and binary files.
# Compiler reads `main.tex`, & join sources as `standalone.tex`
EXT_SRC=".tex"
EXT_GRPH=".pdf"
BARE_SRC_CHIEF="main"
BARE_SRC_ALL="standalone"
FULL_SRC_CHIEF="${BARE_SRC_CHIEF}${EXT_SRC}"
FULL_SRC_ALL="${BARE_SRC_ALL}${EXT_SRC}"

# To set the `main.tex` sources inside current working directory.
list_full_src_chief=$(find "${DIR_TOP}" -name "${FULL_SRC_CHIEF}")

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

# XXX

   else
      echo "Argument $1 not recognized. Stop." > /dev/stderr
      exit 1
   fi
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# For every project within top directory, find main source, and compile
for path_full_src_chief_dm in "${list_full_src_chief}"
do
   dir=$(dirname "${path_full_src_chief_dm}")
   cd "${dir}"
   # To hold all sources in the current working directory.
   list_full_src_rlv=$(find . -name "*${EXT_SRC}")
   # To remove the `standalone.tex` generated from `main.tex`.
   # (If the replaced contains `/`, 1st delimiter is `//` instead of `/`)
   list_full_src_rlv="${list_full_src_rlv//.\/${FULL_SRC_CHIEF}/}"

   # Name the corresponding binary the same as directory.
   bare_bin=$(basename "${dir}")
   full_bin="${bare_bin}${EXT_GRPH}"
   path_full_bin="${dir}/${full_bin}"

   # Ignore `∂`-prefixed (unfinished) files.
   if [[ "${full_src:0:1}" == "${FRAGMENT}" ]]
   then
      continue
   fi

   # Check timestamp according to dependency.
   whether_make="FALSE"
   for full_src_dm in "${list_full_src_rlv}"
   do
      path_full_src="${dir}${full_src_dm}"
      hold=$(resp_old_new "${path_full_src}" "${path_full_bin}")
      if [[ "${hold}" == "FALSE" ]]
      then
         whether_make="TRUE"
         break
      fi
   done

   if [[ "${whether_make}" == "TRUE" ]]
   then
      # Compilation of the binary file.
      echo "Compiling ${full_bin} from ${path_full_src_chief_dm} ..."
      "${FULL_PRG}" "${path_full_src_chief_dm}" "${bare_bin}"

      # XXX: prepare `standalone.tex`
      # ${????} "${FULL_SRC_CHIEF}" "${FULL_SRC_ALL}"
   fi
done
