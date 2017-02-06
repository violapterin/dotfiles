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

# The full line of command (echo what is executed)
set -x
"${COMPILER}" ${options[*]} "${name_src}"
{ set +x; } 2>/dev/null
