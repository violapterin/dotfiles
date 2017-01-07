# Templates and Settings
*as of late 2016*

This repo backs up templates and settings I commonly use. 

# The `.vimrc`

The `.vimrc` is a pure text file that holds desired settings to be initialized in Vim. 
It specifies read-and-write settings, search-and-replace options, self-defined shortcuts, user-implemented functions, and more. 
If saved in the current user's home, it is read in runtime, and applied by Vim.

One short note on end-of-line styles of different file format, and another longer note on "solarized" and other color schemes, are to be found in this repo.

# The `.bash_profile`

In the `.bash_profile`, the user specifies appearances, shortcuts, functions, and variables he defines. 
If saved in the current user's home, it is read in runtime, and applied by Vim. 

# LaTeX template for Latin languages

This is the LaTeX template I use, except for Chinese writings. 
It contain self-defined abbreviations, the load of important packages, customized appearences, self-implemented functions and more.

The LaTeX documents based on this template is supposed to be compiled into `.pdf` by `pdflatex` engine. 
To compile, enter `pdflatex <file-name>`. 
The binary `pdflatex` is already inlcuded in [MacTex](http://www.tug.org/mactex/) distribution. I run `pdflatex` on my MacBook Air. 

# LaTeX template for CJK

This is the LaTeX template I use for Chinese writings. 
It is largely the same as that of Latin laguages, but with `xeCJK` lines included, and some seemingly incompatible packages removed. 

The LaTeX documents based on this template is supposed to be compiled into `.pdf` by `pdflatex` engine. 
To compile, enter `xelatex <file-name>`. 
The binary `xelatex` is already inlcuded in [MacTex](http://www.tug.org/mactex/) distribution. I run `xelatex` on my MacBook Air. 

# Script for update

Since I save the newest version of these files in my home (`~`), instead of this local repo, a short script that facilitates their update is included in this repo. 
