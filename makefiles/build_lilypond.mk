# Filename: build_lilypond.mk
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export all `.ly` (LilyPond) sources into `.pdf`.
# Requirement: that `lilypond` be installed.

# Note that this file is shared by all makefiles for `.ly`.
# Please specify `NAME`, the name (stripped of extension) of project,
# which will also be used as of corresponding PDF and MP3 files.

# Human readable wrapper I defined, to be translated.
DIR_WRAPPED := ./wrapped/
# The notation LilyPond accepts.
DIR_SOURCE := ./source/
# What compilation directly calls.
DIR_LINKAGE := ./linkage/
# Where final output files in PDF are stored.
DIR_PRODUCT := ./product/

# To append directory to `NAME`, and so on.
dir_name = $(addprefix $(DIR_PRODUCT), $(NAME))
dir_name_pdf = $(addsuffix .pdf, $(dir_name))
dir_name_midi = $(addsuffix .midi, $(dir_name))
dir_name_wav = $(addsuffix .wav, $(dir_name))
dir_name_mp3 = $(addsuffix .mp3, $(dir_name))

# Extensions of LilyPond source and my wrapper.
EXT_SOURCE := .ly
EXT_WRAPPED := .lyw

# `main.ly` is the principal source being input to LilyPond.
dir_main_source = $(addprefix $(DIR_LINKAGE), main$(EXT_SOURCE))
source = $(wildcard $(addprefix $(DIR_SOURCE), *$(EXT_SOURCE)) ) 
linkage = $(wildcard $(addprefix $(DIR_LINKAGE), *$(EXT_SOURCE)) ) 
wrapped = $(wildcard $(addprefix $(DIR_WRAPPED), *$(EXT_WRAPPED)) )

# To remove my wrapping of LilyPond sources.
UNWRAPPER =

# The location of music engraver LilyPond.
COMPILER := /Applications/LilyPond.app/Contents/Resources/bin/lilypond
# To specify filename to save (w/o extension).
COMPILER_OPT = --output $(dir_name)

# `fluidsynth`, by default, converts MIDI to WAV.
# (see `fluidsynth -T help` for other supported formats.)
1ST_CONVERTER := fluidsynth
# This renders MIDI file to raw audio data and store in [file].
1ST_CONVERTER_OPT = --fast-render=$(dir_name_wav)
# FluidR3 is a free, open-source midi-to-sound synthesiser,
# basing on General Midi SoundFont format (.sf2).
# The directory shown is used by Mac OS X as soundfont plug-ins.
SOUNDFONT := /Library/Audio/Sounds/Banks/FluidR3_GM.sf2

# `lame` is an open-source audio encoder that converts WAV to MP3.
2ND_CONVERTER := lame
# To choose quality of conversion.
2ND_CONVERTER_OPT := --preset standard

# Removal of files.
DELETE := rm -f

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

all : unwrap get_pdf get_midi get_mp3

get_pdf : $(dir_name_pdf)
get_midi : $(dir_name_midi)
get_mp3 : $(dir_name_mp3)

$(DIR_SOURCE)/%$(EXT_SOURCE) : $(DIR_WRAPPED)/%$(EXT_WRAPPED)
   $(UNWRAPPER) "$@" "$<"

# The chief compilation process goes here.
# Beware : the `.ly` file must be in the very end.
# A `@` suppresses printing command (since it echoes already).
$(dir_name_pdf) $(dir_name_midi) : $(dir_main_source) $(source) $(linkage)
	@echo Compiling LilyPond file $(dir_main_source)...
	$(COMPILER) $(COMPILER_OPT) $(dir_main_source)
	@echo $(dir_name_pdf) has been successfully typeset!
	@echo $(dir_name_midi) has been generated too!

$(dir_name_mp3) : $(dir_name_midi)
	@echo Converting MIDI to WAV...
	$(1ST_CONVERTER) $(1ST_CONVERTER_OPT) $(SOUNDFONT) $(dir_name_midi)
	@echo Converting WAV to MP3...
	$(2ND_CONVERTER) $(1ST_CONVERTER_OPT) $(dir_name_wav)
	@echo MP3 has been successfully written!
	$(DELETE) $(dir_name_wav)

# A phony (fake) target is always out-of-date, and thus re-made.
.PHONY : all unwrap get_pdf get_midi get_mp3 clean

# To delete output files. Shell command `rm` means "remove".
clean :
	 $(DELETE) $(dir_name_pdf) $(dir_name_midi) $(dir_name_mp3)
