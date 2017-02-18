# Filename: build_markdown.mk
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export all `.md` (Markdown) files into `.pdf`
# Requirement: that `pandoc` and `xelatex` be installed

# To call bash shell for recipe.
SHELL := /usr/bin/env bash

# To specify location of program.
NAME_PRG := run_pandoc.sh
DIR_PRG := $${HOME}/Documents/templates_configs_notes/scripts
FULL_PRG := $(DIR_PRG)/$(NAME_PRG)

# To delete binary files.
RM := rm -f

# extensions resp. of souce and binary files
EXT_SRC := .md
EXT_BIN := .pdf

# To set the Markdown source files in the top directory,
# or in a subfolder, or in a subsubfolder.
# Filenames must not contain whitespace ` `, or Makefile parses them.
SRC = $(wildcard *$(EXT_SRC) */*$(EXT_SRC) */*/*$(EXT_SRC))

# To replace all `.md` with `.pdf`.
BIN = $(SRC:$(EXT_SRC)=$(EXT_BIN))

# Partial derivative, indicating unfinished work.
PARTIAL = ∂

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

all : $(BIN)

# To compile only if not-`∂`-prefixed (otherwise unfinished).
./%$(EXT_BIN) : ./%$(EXT_SRC)
ifeq ($(call substr,$@,1,1),$(PARTIAL))
	
else
	@echo Compiling "$@" from "$<" ...
	$(FULL_PRG) "$<"
endif

# To declare phony objects, so rules are always executed.
.PHONY : all clean

# To delete binary files.
clean :
	$(RM) $(BIN)
