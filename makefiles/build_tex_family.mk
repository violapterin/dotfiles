# Filename: make_tex_family
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export all `.tex` (TeX-family) sources into `.pdf`
# Requirement: that the engine be installed (specified as `NAME_PRG`)

# To call bash shell for recipe.
SHELL := /usr/bin/env bash

# To specify location of program.
DIR_PRG := $${HOME}/Documents/templates_configs_notes/scripts
FULL_PRG := $(DIR_PRG)/$(NAME_PRG)

# To delete binary files.
RM := rm -f

# Directives where each source is saved (with slash suffixed).
DIR = $(sort $(dir $(wildcard ./*/*/*)))

# Extensions resp. of souce and binary files.
BASE_IN := main
BASE_OUT := all
EXT_SRC := .tex
EXT_BIN := .pdf

# To set the LaTeX source files in the top directory,
# or in a subfolder, or in a subsubfolder.
# Filenames must not contain whitespace ` `, or Makefile parses them.
SRC = $(addsuffix $(BASE_IN)$(EXT_SRC),$(DIR))

# To replace all `.tex` with `.pdf`.
BIN = $(addsuffix $(BASE_OUT)$(EXT_BIN),$(DIR))

# Other affiliated files, to be deleted.
AUX = $(wildcard $(addsuffix *.aux,$(DIR)))
LOG = $(wildcard $(addsuffix *.log,$(DIR)))
GZ = $(wildcard $(addsuffix *.gz,$(DIR)))

# Partial derivative, indicating unfinished work.
PARTIAL = ∂

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

all : $(BIN)

# To compile only if not-`∂`-prefixed (otherwise unfinished).
# Note that `cd` is executed in a temporary shell twice `cd ..` is not necessary.
%/$(BASE_OUT)$(EXT_BIN) : %/$(BASE_IN)$(EXT_SRC)
ifeq ($(call substr,$(call notdir,$@),1,1),$(PARTIAL))
	
else
	@echo Compiling "$@" from "$<" ...
	cd $$(dirname "$<") && $(FULL_PRG) "$(BASE_IN)$(EXT_SRC)" "$(BASE_OUT)$(EXT_BIN)"
endif

.PHONY : all clean

clean :
	$(RM) $(BIN) $(AUX) $(LOG) $(GZ)
