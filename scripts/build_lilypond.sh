#!/usr/bin/env bash

# Filename: build_lilypond.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To compile graphics and audio files of one LilyPond project.
# Requirement: That `lilypond`, `fluidsynth`, and `lame` be installed;
#       also, `TITLE` and `DIR_TOP` must be specified in advance!

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# The location of music engraver LilyPond.
COMPILER="/Applications/LilyPond.app/Contents/Resources/bin/lilypond"
# To specify filename to save {w/o extension}.
OPT_COMPILER="--output ${path_bare_bin_common}"

# Define the dependency-checking function.
FULL_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${FULL_FUN_DEF}"

# The readable files wrapped in notation I defined.
DIR_WRAPPED="${DIR_TOP}/wrapped"
# The parts in notation LilyPond accepts.
DIR_PARTS="${DIR_TOP}/parts"
# The chief files compilation directly calls.
DIR_LINKAGE="${DIR_TOP}/linkage"
# The final output PDF, MIDI, WAV, and MP3.
DIR_PRODUCTS="${DIR_TOP}/products"

# Extensions of LilyPond source and my wrapper.
EXT_SRC=".ly"
EXT_WRP=".lyw"
EXT_GRPH=".pdf"
EXT_SND1=".midi"
EXT_SND2=".wav"
EXT_SND3=".mp3"

# `main.ly` is the principal source being input to LilyPond.
BARE_SRC_CHIEF="main"
path_full_src_chief="${DIR_LINKAGE}/${BARE_SRC_CHIEF}${EXT_SRC}"
# To append directory to `NAME`, and so on.
path_bare_bin_common="${DIR_PRODUCT}/${TITLE}"

# List of LylyPond sources.
list_src_parts="${DIR_SOURCE}*${EXT_SRC}"
list_src_linkage="${DIR_LINKAGE}*${EXT_SRC}"

# To remove my wrapping of LilyPond sources.
UNWRAPPER=

# `fluidsynth`, by default, converts MIDI to WAV.
# {see `fluidsynth -T help` for other supported formats.}
1ST_CONVERTER="fluidsynth"
# This renders MIDI file to raw audio data and store in [file].
OPT_1ST_CONVERTER="--fast-render=${path_bare_bin_common}${SND2}"
# FluidR3 is a free, open-source midi-to-sound synthesiser,
# basing on General Midi SoundFont format {.sf2}.
# The directory shown is used by Mac OS X as soundfont plug-ins.
SOUNDFONT="/Library/Audio/Sounds/Banks/FluidR3_GM.sf2"

# `lame` is an open-source audio encoder that converts WAV to MP3.
2ND_CONVERTER="lame"
# To choose quality of conversion.
OPT_2ND_CONVERTER="--preset standard"

# To delete binary files.
DELETE="rm"
OPT_DELETE="-f"

# To set the wrappers and sources inside current working directory.
list_path_full_wrp=$(find "${DIR_WRAPPED}" -name "*${EXT_WRP}")
list_path_full_src_lkg=$(find "${DIR_LINKAGE}" -name "*${EXT_SRC}")
list_path_full_src_pts=$(find "${DIR_PARTS}" -name "*${EXT_SRC}")

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
      "${DELETE}" "${OPT_DELETE}" "${DIR_PRODUCTS}/${TITLE}${EXT_GRPH}"
      "${DELETE}" "${OPT_DELETE}" "${DIR_PRODUCTS}/${TITLE}${EXT_SND1}"
      "${DELETE}" "${OPT_DELETE}" "${DIR_PRODUCTS}/${TITLE}${EXT_SND3}"

   else
      echo "Argument $1 not recognized. Stop." > /dev/stderr
      exit 1
   fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# No argument present, i.e. compile the binary.
if "${path_bare_bin_common}${EXT_GRPH}"

# For this project of this top directory, find main source, and compile.
for full_src in "${list_src_parts}"
do
      # Check timestamp according to dependency.
      hold="$(resp_old_new "${path_full_src}" "${path_full_bin}")"
      if [[ "${hold}" == "TRUE" ]]
      then
         continue
      fi
   done

   # Check timestamp according to dependency.
   whether_make="FALSE"
   for full_src in "${list_full_src_relavent}"
   do
      path_full_src_hold="${dir}${full_src}"
      hold=$(resp_old_new "${path_full_src_hold}" "${path_full_bin}")
      if [[ "${hold}" == "FALSE" ]]
      then
         whether_make="TRUE"
         break
      fi
   done

   if [[ "${whether_make}" == "FALSE" ]]
   then
      break
   fi



   dir=$(dirname "${path_full_src}")
path_full_src_chief="${DIR_LINKAGE}/${BARE_SRC_CHIEF}${EXT_SRC}"
   path_full_src="${dir}${full_src}"
   hold="$(resp_old_new "${path_full_src}" "${path_full_bin}")"
   if [[ "${hold}" == "FALSE" ]]
   then
      whether_make="TRUE"
      break
   fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

for dir_full_src in ${list_src}
do
   # If `src` is `foo.bar.baz`, `bare_common` is `foo`.
   full_src="$(basename ${dir_full_src})"
   dir=$(dirname "${dir_full_src}")
   bare_common="${full_src%%.*}"
   # Name the corresponding binary the same as directory.
   full_bin="${bare_common}${EXT_BIN}"

   # Ignore `∂`-prefixed (unfinished) files.
   if [[ "${full_src:0:1}" == "${FRAGMENT}" ]]
   then
      continue
   fi

   # Check timestamp according to dependency.
   whether_make=$(resp_old_new "${dir_full_src}" "${dir}/${full_bin}")
   if [[ "${whether_make}" == "TRUE" ]]
   then
      continue
   fi

   # Compilation of the binary file.
   echo "Compiling ${full_bin} from ${full_src} ..."
   set -x
   "${FULL_PRG}" "${dir_full_src}" "${bare_common}"
   { set +x; } 2>/dev/null

   last_dir="$(basename ${dir})"
   mv "${full_bin}" "${dir}/${last_dir}${EXT_BIN}"
done

