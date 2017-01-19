#! /usr/bin/env bash
# To update newest version of templates and scripts, and set read-only.

list_files=(
   .vimrc
   .bash_profile 
   .bashrc
   template_pandoc.tex
   template_Latin.tex
   template_CJK.tex
   run_pandoc.sh
   run_pdflatex.sh
   run_xelatex.sh
   makefile_pandoc
   makefile_pdflatex
   makefile_xelatex
)

# the directory where source is
dir_from="${HOME}"
# the destination they are copied to.
# `"$0"` is filename (with path) of this script.
dir_to=$(dirname "$0")

for file in "${list_files[@]}"; do
   cp -f ${dir_from}\/${file} ${dir_to}\/${file}
   chmod 444 ${dir_to}\/${file}
done
