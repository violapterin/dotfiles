#!/usr/bin/env bash
# To update newest version of templates and scripts.

# the directory where source is.
DIR_FROM="${HOME}"

# the destination they are copied to.
# `"$0"` is filename (with path) of this script.
DIR_TO=$(dirname "$0")

# To first copy (deleting old versions), then set them to read-only.
transfer () {
   local file_from=${DIR_FROM}\/"$1"
   local file_to=${DIR_TO}\/"$1"\/"$2"
   cp -f ${file_from} ${file_to}
   chmod 444 ${file_to}
}


# list of filenames to be copied.
list_file=(
   .vimrc
   .bashrc
   .bash_profile 
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

# list of local directories which they are to be copied into.
list_dir=(
   configs
   configs
   configs
   tex_templates
   tex_templates
   tex_templates
   scripts
   scripts
   scripts
   makefiles
   makefiles
   makefiles
)

len_file=${#list_file[@]}

# Do for all files listed above:
for ((i=1; i<=${len_file}; i++))
do
   transfer list_file[i] list_dir[i]
done
