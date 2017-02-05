#!/usr/bin/env bash

# filename: run-pandoc.sh
# author: Tzu-Yu Jeng
# date: Jan. 2017
# description: to export `.md` (Markdown) file as `.pdf`
# requirement: having assumed library `pandoc` and script `xelatex`

# The library `pandoc` exports, here, Markdown to LaTeX then to PDF.
COMPILER='pandoc'
EXT_BIN='.pdf'

# `pandoc` seems to allow any character valid in Mac filename.
# But all Bash-reserved characters must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).md` is passed as `draft\ \(2016\).md`.
name_src="$1"
# Wildcards explained: Suppose `str` is `foo.bar.qux`,
# then `${str%%.*}` is `foo`, and `${str%.*}` is `foo.bar`,
# and `${str##.*}` is `qux`, and `${str#.*}` is `bar.qux`.
name_bin="${name_src%%.*}${EXT_BIN}"

# Location of template for `pandoc`
PATH_TEMPLATE=${HOME}/Documents/templates_configs_notes/tex_templates/template_pandoc.tex

# `pandoc` options: `-s` for standalone, `-o` for output,
# `-V` for value, `margin` meaning page margin,
# `--template` is called for LaTeX compiler's use,
# `xelatex` is required for CJK characters.
options=(
      -s
      -o "${name_bin}"
      -V geometry:margin=1in
      --template=${PATH_TEMPLATE}
      --latex-engine=xelatex
)

# The full line of command (echo what is executed)
set -x
"${COMPILER} ${options[*]} ${name_src}"
set +x
