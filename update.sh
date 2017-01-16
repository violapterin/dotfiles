#! /usr/bin/env bash
# To update newest version of templates and scripts.

NUM_DOC=11 # number of documents
COMMAND="cp -f" # command to be applied

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

dir_from="~"
dir_to="dirname $0"


for (( i=1; i<=NUM_DOC; i++ ));
do
   ${CMD} ${dir_from}\/${list_files[i]} ${dir_to}\/${list_files[i]}
done
