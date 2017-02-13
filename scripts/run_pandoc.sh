#!/usr/bin/env bash

# Filename: run-pandoc.sh
# Author: Tzu-Yu Jeng
# Date: Jan. 2017
# Description: to export `.md` (Markdown) file as `.pdf`
# Requirement: having assumed library `pandoc` and script `xelatex`

# The library `pandoc` exports, here, Markdown to LaTeX then to PDF.
COMPILER="pandoc"
EXT_BIN=".pdf"

# `pandoc` seems to allow any character valid in Mac filename.
name_src="$1"
echo ${name_src}

name_bin="${name_src/%.md/.pdf}"

# Wildcards explained: Suppose `str` is `foo.bar.qux`,
# then `${str%%.*}` is `foo`, and `${str%.*}` is `foo.bar`,
# and `${str##.*}` is `qux`, and `${str#.*}` is `bar.qux`.
#name_bin="${name_src%%.*}${EXT_BIN}"

# Location of template for `pandoc`
PATH_TEMPLATE="${HOME}/Documents/templates_configs_notes/tex_templates/template_pandoc.tex"

# `pandoc` options: `-s` for standalone, `-o` for output,
# `-V` for value, `margin` meaning page margin,
# `--template` is called for LaTeX compiler's use,
# `xelatex` is required for CJK characters.
options=(
      -s
      -o "${name_bin}"
      -V geometry:margin=1in
      --template="${PATH_TEMPLATE}"
      --latex-engine=xelatex
)

# To check argument, then run main commands.
# `set -x` echoes what is executed; `set +x` cancels this.
if [ "$#" -eq 0 ]; then
   echo "No arguments supplied. 1 or 2 expected, 0 present. Stop."
   exit 1
elif [ "$#" -gt 3 ]; then
   echo "Too many arguments. 1 or 2 expected, $# present. Stop."
   exit 1
elif [ "$#" -eq 1 ]; then
   # the main command
   # `set -x` echoes what is executed; `set +x` cancels this.
   set -x
   "${COMPILER}" ${options[*]} "${name_src}"
   { set +x; } 2>/dev/null
elif [ "$#" -eq 2 ]; then
   set -x
   "${COMPILER}" ${options[*]} "-jobname=$2" "${name_src}"
   { set +x; } 2>/dev/null
fi
