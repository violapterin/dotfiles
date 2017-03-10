#!/usr/bin/env bash

# Filename: build_lilypond.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Jan. 2017
# Description: To export `.ly` {LilyPond} files into graphics and audio files.
# Requirement: That `lilypond`, `fluidsynth`, and `lame` be installed.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To specify location of program.
# Note: `NAME_PROGRAM` and `DIR_TOP` must be specified in advance!
DIR_SCRIPTS="${HOME}/templates_configs_scripts/scripts"
PATH_FULL_PROGRAM="${DIR_SCRIPTS}/${NAME_PROGRAM}"

# Define the dependency-checking function.
FULL_FUN_DEF="function_resp_old_new.sh"
source "${DIR_SCRIPTS}/${FULL_FUN_DEF}"

# The readable files wrapped in notation I defined.
DIR_WRAPPED="${DIR_TOP}/wrapped/"
# The parts in notation LilyPond accepts.
DIR_PARTS="${DIR_TOP}/parts/"
# The chief files compilation directly calls.
DIR_LINKAGE="${DIR_TOP}/linkage/"
# The final output PDF, MIDI, WAV, and MP3.
DIR_PRODUCTS="${DIR_TOP}/products/"

# Extensions of LilyPond source and my wrapper.
EXT_SRC=".ly"
EXT_WRP=".lyw"

# `main.ly` is the principal source being input to LilyPond.
BARE_SRC_CHIEF="main"
path_full_src_chief="${DIR_LINKAGE}${BARE_CHIEF}${EXT_SRC}"
# To append directory to `NAME`, and so on.
path_bare_bin_common="${DIR_PRODUCT}/${NAME_PROJECT}"

# List of LylyPond sources.
list_src_parts="${DIR_SOURCE}*${EXT_SRC}"
list_src_linkage="${DIR_LINKAGE}*${EXT_SRC}"

# To remove my wrapping of LilyPond sources.
UNWRAPPER=

# The location of music engraver LilyPond.
COMPILER="/Applications/LilyPond.app/Contents/Resources/bin/lilypond"
# To specify filename to save {w/o extension}.
OPT_COMPILER="--output ${path_bare_bin_common}"

# `fluidsynth`, by default, converts MIDI to WAV.
# {see `fluidsynth -T help` for other supported formats.}
1ST_CONVERTER="fluidsynth"
# This renders MIDI file to raw audio data and store in [file].
OPT_1ST_CONVERTER="--fast-render=${path_bare_bin_common}.wav"
# FluidR3 is a free, open-source midi-to-sound synthesiser,
# basing on General Midi SoundFont format {.sf2}.
# The directory shown is used by Mac OS X as soundfont plug-ins.
SOUNDFONT="/Library/Audio/Sounds/Banks/FluidR3_GM.sf2"

# `lame` is an open-source audio encoder that converts WAV to MP3.
2ND_CONVERTER="lame"
# To choose quality of conversion.
OPT_2ND_CONVERTER="--preset standard"

# Removal of files.
DELETE="rm -f"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

if "${path_bare_bin_common}.pdf"

# For this project of this top directory, find main source, and compile.
for full_src in "${list_src_parts}"
do
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
   dir="$(dirname ${dir_full_src})"
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

