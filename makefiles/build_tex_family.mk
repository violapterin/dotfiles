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

# Extensions resp. of souce and binary files.
BASE_SRC := main
EXT_SRC := .tex
EXT_BIN := .pdf

# To set the LaTeX source files in the top directory,
# or in a subfolder, or in a subsubfolder.
# Filenames must not contain whitespace ` `, or Makefile parses them.
SRC = $(wildcard *$(EXT_SRC) */*$(EXT_SRC) */*/*$(EXT_SRC))

# To replace all `.tex` with `.pdf`.
BIN = $(SRC:$(EXT_SRC)=$(EXT_BIN))

# Other affiliated files, to be deleted.
AUX = $(wildcard *.aux */*.aux */*/*.aux)
LOG = $(wildcard *.log */*.log */*/*.log)
GZ = $(wildcard *.gz */*.gz */*/*.gz)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

all : $(BIN)

./*/%/%$(EXT_BIN) : ./*/%/$(BASE_SRC)$(EXT_SRC)
	@echo Compiling "$@" from "$<" ...
	$(FULL_PRG) "$<"

.PHONY : all clean 

clean :
	$(RM) $(BIN) $(AUX) $(LOG) $(GZ)
