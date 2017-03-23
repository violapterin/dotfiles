#!/usr/bin/env bash

# Filename: build_lilypond.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To compile PDF score and synthesized MP3 of a LilyPond project.
# Requirement: That `lilypond`, `fluidsynth`, and `lame` be installed;
#    also, `TITLE` and `DIR_TOP` must be specified in advance!
# Variable(s) defined in advance: `TITLE`, `DIR_TOP`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# `DIR_TOP` should be the top directory of the desired LilyPond project.
# `TITLE` should be the name of the project.

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
FULL_SRC_CHIEF="${BARE_SRC_CHIEF}${EXT_SRC}"
path_full_src_chief="${DIR_LINKAGE}/${FULL_SRC_CHIEF}"
# To append directory to `NAME`, and so on.
path_bare_bin_common="${DIR_PRODUCT}/${TITLE}"
path_full_grph="${path_bare_bin_common}${EXT_GRPH}"
path_full_snd1="${path_bare_bin_common}${EXT_SND1}"
path_full_snd2="${path_bare_bin_common}${EXT_SND2}"
path_full_snd3="${path_bare_bin_common}${EXT_SND3}"

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

# Parts within the current working directory.
list_path_full_src_pts=$(find "${DIR_PARTS}" -name "*${EXT_SRC}")

# Wrappers within the current working directory.
list_path_full_src_wrp=$(find "${DIR_WRAPPED}" -name "*${EXT_WRP}")

# Linker-sources within the current working directory.
list_path_full_src_lkg=$(find "${DIR_LINKAGE}" -name "*${EXT_SRC}")
# To remove `main.ly` in the list.
list_path_full_src_lkg="${list_path_full_src_lkg//.\/${FULL_SRC_CHIEF}/}"

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
      "${DELETE}" "${OPT_DELETE}" "${path_full_grph}"
      "${DELETE}" "${OPT_DELETE}" "${path_full_snd1}"
      "${DELETE}" "${OPT_DELETE}" "${path_full_snd2}"
      "${DELETE}" "${OPT_DELETE}" "${path_full_snd3}"

   else
      echo "Argument $1 not recognized. Stop." > /dev/stderr
      exit 1
   fi
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To unwrap sources.
whether_make="FALSE"

for path_full_src_pts_dm in "${list_path_full_src_pts}"
do
   dir=$(dirname "${path_full_src_pts_dm}")
   full_src_pts_dm=$(basename "${path_full_src_pts_dm}")
   bare_src_pts_dm="${full_src_pts_dm%%.*}"
   
   # The relevant wrappers from which `path_full_src_pts_dm` is generated.
   for path_full_src_wrp_dm "${list_path_full_src_wrp}"
   do
      full_src_wrp_dm=$(basename "${path_full_src_wrp_dm}")
      bare_src_wrp_dm="${full_src_wrp_dm%%.*}"
      if [[ ${bare_src_wrp_dm} == ${bare_src_pts_dm}* ]]
      then
         list_path_full_src_wrp_rlv+=("${path_full_src_wrp_dm}")
      fi
   done

   for path_full_src_wrp_rlv_dm in "${list_path_full_src_wrp_rlv}"
   do
      hold_src=$(resp_old_new "${path_full_src_wrp_rlv_dm}" "${path_full_src_pts_dm}")
      if [[ "${hold_src}" == "FALSE" ]]
      then
         whether_make="TRUE"
         break
      fi
   done

   if [[ "${whether_make}" == "TRUE" ]]
   then
      break
   fi
done

if [[ "${whether_make}" == "TRUE" ]]
then
   # XXX: prepare part from wrapped
   # ${????} "${list_path_full_src_wrp_rlv}" "${path_full_src_pts_dm}"
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Compilation of the score.
whether_make="FALSE"

for path_full_src_pts_dm in "${list_path_full_src_pts}" "${list_path_full_src_wrp}"
do
   hold_grph=$(resp_old_new "${path_full_src_pts_dm}" "${path_full_grph}")
   hold_snd1=$(resp_old_new "${path_full_src_pts_dm}" "${path_full_snd1}")
   if [[ "${hold_grph}" == "FALSE" ]] || [[ "${hold_snd1}" == "FALSE" ]]
   then
      whether_make="TRUE"
      break
   fi
done

if [[ "${whether_make}" == "TRUE" ]]
then
   echo "Compiling ${path_full_grph} from ${path_full_src_chief} ..."
   set -x
   ${COMPILER} ${OPT_COMPILER} ${path_full_src_chief}
   { set +x; } 2>/dev/null
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Compilation of the WAV.
whether_make="FALSE"

hold_snd2=$(resp_old_new "${path_full_snd1}" "${path_full_snd2}")
if [[ "${hold_snd2}" == "FALSE" ]]
then
   whether_make="TRUE"
   break
fi

if [[ "${whether_make}" == "TRUE" ]]
then
   echo "Compiling ${path_full_snd2} from ${path_full_snd1} ..."
   set -x
   ${1ST_CONVERTER} ${OPT_1ST_CONVERTER} ${SOUNDFONT} ${path_full_snd1}
   { set +x; } 2>/dev/null
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Compilation of the MP3.
whether_make="FALSE"

hold_snd3=$(resp_old_new "${path_full_snd2}" "${path_full_snd3}")
if [[ "${hold_snd3}" == "FALSE" ]]
then
   whether_make="TRUE"
   break
fi

if [[ "${whether_make}" == "TRUE" ]]
then
   echo "Compiling ${path_full_snd3} from ${path_full_snd2} ..."
   set -x
   ${2ND_CONVERTER} ${OPT_2ND_CONVERTER} ${path_full_snd2}
   { set +x; } 2>/dev/null
fi

