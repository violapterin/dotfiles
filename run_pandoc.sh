#!/usr/bin/env bash

# filename: run-pandoc.sh
# author: Tzu-Yu Jeng
# date: Jan. 2017
# description: to export `.md` (Markdown) file as `.pdf`
# requirement: having assumed library `pandoc` and script `xelatex`

# The library `pandoc` exports, here, Markdown to LaTeX then to PDF.
program='pandoc'

# `pandoc` seems to allow any character valid in Mac filename.
# But all Bash-reserved characters must be escaped, 
# as usually the case for executables.
# Like: `draft (2016).md` is passed as `draft\ \(2016\).md`.
nameSrc="$1"
# Wildcards explained: Suppose `str` is `foo.bar.qux`,
# then `${str%%.*}` is `foo`, and `${str%.*}` is `foo.bar`,
# and `${str##.*}` is `qux`, and `${str#.*}` is `bar.qux`.
namePdf="${nameSrc%%.*}.pdf"

# Despite being read into Bash, it's still necessary to escape
# Bash-reserved characters, just as if being entered literally.
nameSrc=$(printf '%q' "${nameSrc}")
namePdf=$(printf '%q' "${namePdf}")

# `pandoc` options: `-s` for standalone, `-o` for output,
# `-V` for value, `margin` meaning page margin,
# `--template` is called for LaTeX compiler's use,
# `xelatex` is required for CJK characters.
options=(
      -s
      -o ${namePdf}
      -V geometry:margin=1in
      --template=/Users/amino/template_pandoc.tex
      --latex-engine=xelatex
)

# The full line of command
command="${program} ${options[*]} ${nameSrc}"
echo ${command} # first print it
eval ${command} # then evaluate it
